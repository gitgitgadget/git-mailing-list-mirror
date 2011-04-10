From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: Re: [PATCH 1/8] gitk: fix file highlight when run in subdirectory
Date: Sun, 10 Apr 2011 14:03:34 -0400
Message-ID: <BANLkTinZCCMQbQBF-j3bq3Wfxm2YRksCYQ@mail.gmail.com>
References: <1301969659-19703-1-git-send-email-martin.von.zweigbergk@gmail.com>
	<1301969659-19703-2-git-send-email-martin.von.zweigbergk@gmail.com>
	<20110410015410.GA25368@brick.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Sun Apr 10 20:03:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q8yzI-0005wS-Ts
	for gcvg-git-2@lo.gmane.org; Sun, 10 Apr 2011 20:03:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754102Ab1DJSDg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 10 Apr 2011 14:03:36 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:44316 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753791Ab1DJSDf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 10 Apr 2011 14:03:35 -0400
Received: by eyx24 with SMTP id 24so1522592eyx.19
        for <git@vger.kernel.org>; Sun, 10 Apr 2011 11:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=z8cRjDXykRDuWOTUAFFGzVldCmYcw/U83JigeyMwNxg=;
        b=fon34f09bafdMsllMaKT9XPpU1+fXD09vHFcsURO7gA5TZg8hQC2D3xBrvUfITYB4N
         I17UJnunCszbD998L8wz25q/2jcOOlmyMDCOhNcWobciL9neZ1+LnxAXmhv2Cra07P0g
         T0A41eYY5Pt3tbZrvcX4coMQP4JgCCj3mkzqA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=dNft0Y+mR/YpSw3GTQ/4bznUDbLwMpfQXKVE62jU7j7vDbthid0OZvcNhzSpRznOqi
         dsxA9SR0lu17w0Zy8kbnGyml3gEwl2AGfmN1UUfpmOLxWdd/hqVVxjCpRVOT5Kzb9pbU
         OgOepfgmuK8SOeLObEZ77YAj86V03mc64TmBA=
Received: by 10.213.32.17 with SMTP id a17mr1779623ebd.94.1302458614072; Sun,
 10 Apr 2011 11:03:34 -0700 (PDT)
Received: by 10.213.101.11 with HTTP; Sun, 10 Apr 2011 11:03:34 -0700 (PDT)
In-Reply-To: <20110410015410.GA25368@brick.ozlabs.ibm.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171269>

Hi Paul,

Thanks for your input. I will work on a re-roll of this series based
on, at least,
your input on patch 8/8. However, I am going away for 4 weeks today and=
 I will
probably not be able to do that until some time after I come back. If
anyone else
cares to do it before then, please go ahead.

On Sat, Apr 9, 2011 at 9:54 PM, Paul Mackerras <paulus@samba.org> wrote=
:
> I have to admit I wasn't aware of GIT_WORK_TREE before I saw your
> patches. =C2=A0The patches look OK, but I wonder how many of the prob=
lems
> would go away if gitk were simply to set GIT_WORK_TREE in the
> environment for the programs it runs, if it is not already set.

Most of the problems I have tried to fix in this series only appear whe=
n
GIT_WORK_TREE _is_ set, so I don't think setting it would help. When
it it not set,
setting it to the directory that git detected should have no effect as
far as I can see.


/Martin
