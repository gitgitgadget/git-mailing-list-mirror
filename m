From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Linux Kernel + GIT SCM
Date: Fri, 12 Aug 2011 17:01:21 -0700 (PDT)
Message-ID: <m3pqka18ow.fsf@localhost.localdomain>
References: <CACivvv1-UcZdOx+ThLuUkqwL=oy7aETckV+18Fpj_zoXkcXJWQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-4
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Vecu BOSSEUR <vecu.bosseur@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 13 02:05:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qs1jI-0004On-0v
	for gcvg-git-2@lo.gmane.org; Sat, 13 Aug 2011 02:05:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751817Ab1HMABY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 12 Aug 2011 20:01:24 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:51060 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751331Ab1HMABY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 12 Aug 2011 20:01:24 -0400
Received: by fxh19 with SMTP id 19so2606257fxh.19
        for <git@vger.kernel.org>; Fri, 12 Aug 2011 17:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=v2LRmU/k4AY1m54RA7X762pg9Rmp2V9IcRZz2uF2z1E=;
        b=pToZtdNFzjoV5MOGr4615ZGDPIVyWFN/qObXdxY4jHKPcRmMmUA9ofiJM0gXkZN4Pg
         9uC1wLyBzXv5o6Qo5cJw10e1q6Q5mfI34gTO/QDXGkyU8lwq8jcOqTHBZ7wmhveM94Pn
         iznkaQLWpLJV1a0ww8b5+WUEX8DS6BpcZ07PI=
Received: by 10.223.15.13 with SMTP id i13mr2018351faa.51.1313193682761;
        Fri, 12 Aug 2011 17:01:22 -0700 (PDT)
Received: from localhost.localdomain (abvk82.neoplus.adsl.tpnet.pl [83.8.208.82])
        by mx.google.com with ESMTPS id j19sm2828988faa.17.2011.08.12.17.01.21
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 12 Aug 2011 17:01:21 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id p7D01EEc020308;
	Sat, 13 Aug 2011 02:01:25 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id p7D01491020305;
	Sat, 13 Aug 2011 02:01:04 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <CACivvv1-UcZdOx+ThLuUkqwL=oy7aETckV+18Fpj_zoXkcXJWQ@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179266>

Vecu BOSSEUR <vecu.bosseur@gmail.com> writes:

> Hello,
>=20
> I need GIT SCM to allow me to suspend an operation and to resume it
> later : initial cloning, synchronizing repositories, ...
>=20
> I believed this was the purpose of the "GIT Sequencer" feature
> developped at 2011 Google Summmer Of Code ; please, tell me if I
> missed something.
>=20
> And I would like to know whether "kernel.org" servers will support
> this feature soon or not.

No, "Git sequencer" has nothing to do with resumable (and suspendable)
clone, fetch or push.  Resumable transport is not implemented, and it
looks like ti would be difficult to add.

The sequencer project is about engine that it is to be used by rebase,
multiple cherry-pick, multiple revert, and git-am.  Among others it is
meant to increase consistency between those commands.
=20
--=20
Jakub Nar=EAbski
