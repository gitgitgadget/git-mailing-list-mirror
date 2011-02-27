From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Consistent terminology: cached/staged/index
Date: Sun, 27 Feb 2011 02:16:40 +0200
Message-ID: <AANLkTimyXciScc5K6ozggMHsy9YmgyOFpy6pgKBEypC9@mail.gmail.com>
References: <AANLkTi=9OWqz66Ab6O9tc4eYSrhZZ1YC_+ta9sutAn30@mail.gmail.com>
	<20110213193738.GA26868@elie>
	<7v8vxjwnhj.fsf@alter.siamese.dyndns.org>
	<AANLkTim4UKxYwRagCk3R20e7wsRb7CxvS_ze9b8MfWjL@mail.gmail.com>
	<20110214231920.GA24814@elie>
	<AANLkTik-jc0ZX9S4bCYV8VBgPXJZsX0U08W2H+jufO8r@mail.gmail.com>
	<20110226215139.GA19176@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Piotr Krukowiecki <piotr.krukowiecki.news@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 27 01:16:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PtUJl-0002DY-0i
	for gcvg-git-2@lo.gmane.org; Sun, 27 Feb 2011 01:16:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751120Ab1B0AQm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 26 Feb 2011 19:16:42 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:40241 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750838Ab1B0AQl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 26 Feb 2011 19:16:41 -0500
Received: by bwz15 with SMTP id 15so2860669bwz.19
        for <git@vger.kernel.org>; Sat, 26 Feb 2011 16:16:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=jdzhUL0Qe8EJJj9yFWDUsCzPi151tdg3GNh/v+YhblM=;
        b=retGMlj0V4L5H0Lgv4Yn0y3LF135E54ufAveEgDKg5Yk2dYYMvX0vC1jnjnI2+UKBB
         VtdtMLBrqKyz8Y5P53su2EQX6B6ZeJ3zf4/rUCNez7kSr8a/K7pAEgPOykLzTAHFInzX
         QOBHddfBlyv9VnVUKf7AYw8xK9VpAHAs1jKeo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=SFukX/DcP/U4jJtEgQ2cLM3diHQ9gMdmG3z2KyQbaxe+R2jXEF+hhErY1cyV73BtfZ
         QLNEsfgK2HVcDYxiWoNMbCvFShFlDk1sV7XULWLidTZZbIMq9JyTSVZV1W2wDAVvAFa3
         XcXL2tRZx+jv1/ULAiHAD/uq6ID0AgkJOBa34=
Received: by 10.204.16.211 with SMTP id p19mr3376064bka.162.1298765800317;
 Sat, 26 Feb 2011 16:16:40 -0800 (PST)
Received: by 10.204.67.141 with HTTP; Sat, 26 Feb 2011 16:16:40 -0800 (PST)
In-Reply-To: <20110226215139.GA19176@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168003>

On Sat, Feb 26, 2011 at 11:51 PM, Jonathan Nieder <jrnieder@gmail.com> =
wrote:
> These terms you suggest aren't the established ones (as I'm sure you
> know). =C2=A0Just as with everyday language, there is some resistance=
 to
> moving to new terms that have not been established for a while. =C2=A0=
In
> everyday language, many terms gained popularity by
>
> =C2=A0- appearing in some document that people read for another reaso=
n
> =C2=A0- describing the notion they are meant to describe clearly (or
> =C2=A0 having some other feature that makes them likeable)

There's always resistance, but 1.8 is supposed to contain stuff as "if
git was written from scratch". I think this makes sense as one of
them.

> This is how "staging area" has been gaining popularity, I think ---
> some (out-of-tree) documentation that is good for other reasons uses
> it, and it really does seem to be a clearer term than "index" for
> "place where the next commit is being prepared". =C2=A0Unfortunately,=
 I do
> not think it is a clearer term than "index" for "the git index, which
> contains stat() information and pointers to blobs that either belong
> in the next commit or are participating in a merge conflict". =C2=A0S=
o it
> does not seem to justify rewriting everything to use it.

Why should the users care about the stat() information? Or how the
merge conflicts are being tracked? That's plumbing, not porcelain.

--=20
=46elipe Contreras
