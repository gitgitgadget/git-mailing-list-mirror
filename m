From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [RFC PATCH] config: Introduce functions to write non-standard file
Date: Tue, 19 Jul 2011 14:22:45 +0530
Message-ID: <CALkWK0mSWxkGZOrZor0+bZNd4V-OrU+6-0n_Lo+F8qCyd=72vA@mail.gmail.com>
References: <20110713190724.GA31965@sigill.intra.peff.net> <1311025032-835-1-git-send-email-artagnon@gmail.com>
 <7vr55n9mc3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 19 10:53:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qj63S-0006dO-VD
	for gcvg-git-2@lo.gmane.org; Tue, 19 Jul 2011 10:53:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752649Ab1GSIxI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 19 Jul 2011 04:53:08 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:33239 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752607Ab1GSIxH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Jul 2011 04:53:07 -0400
Received: by wwe5 with SMTP id 5so3963962wwe.1
        for <git@vger.kernel.org>; Tue, 19 Jul 2011 01:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=WhE6L5m256FEMNw5SfypTZkGgeDnVhk35fRUBKMEIFc=;
        b=b6Islayc/1Y3860TX/ts4A9SMhXP1SjEGpXqCUsxXtcKgdVYz+l9JcIhXF2uZ4CybD
         XtWPf739Dkd229Wtedtic/Qqwi/3Liy4fHACiEZqsCmzW+3y8tf8BQq0T5cxbtyMnrQC
         o+uQJVaY7zSdopK5NbjNkIGjIhUPboiVa3uBM=
Received: by 10.216.70.14 with SMTP id o14mr6865729wed.111.1311065586183; Tue,
 19 Jul 2011 01:53:06 -0700 (PDT)
Received: by 10.216.234.143 with HTTP; Tue, 19 Jul 2011 01:52:45 -0700 (PDT)
In-Reply-To: <7vr55n9mc3.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177444>

Hi Junio,

Junio C Hamano writes:
> Ramkumar Ramachandra <artagnon@gmail.com> writes:
[...]
> Yuck, what an ugly hack when you are so close. =C2=A0Why not restruct=
ure the
> code in such a way that the updated config-set-multivar and set-in-fi=
le
> share the code better? =C2=A0If the former takes a hardcoded logic to=
 decide
> which file to write to while the latter takes the filename to write t=
o as
> its argument, wouldn't it be a lot more natural to make config-set-mu=
ltivar
> call set-in-file after computing what filename parameter to pass?

Ugh, sorry. Fixed now.

-- Ram
