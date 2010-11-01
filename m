From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 0/3] Bringing git-ls-files to porcelain level
Date: Mon, 1 Nov 2010 18:20:59 +0700
Message-ID: <AANLkTin5uw-O=7gOO+uPP1zKy0RghiZLmroZyEWO_EKg@mail.gmail.com>
References: <1262884076-12293-1-git-send-email-pclouds@gmail.com> <87zkttqqse.fsf@anar.kanru.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org, Kan-Ru Chen <kanru@kanru.info>
X-From: git-owner@vger.kernel.org Mon Nov 01 12:21:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PCsS7-0007yn-Fh
	for gcvg-git-2@lo.gmane.org; Mon, 01 Nov 2010 12:21:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757207Ab0KALVW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 1 Nov 2010 07:21:22 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:51208 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754966Ab0KALVU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 1 Nov 2010 07:21:20 -0400
Received: by wyf28 with SMTP id 28so5355758wyf.19
        for <git@vger.kernel.org>; Mon, 01 Nov 2010 04:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:content-type
         :content-transfer-encoding;
        bh=KXMV5CcIc6ugsU1ZwgW28EiHaGB/RvhcnmEnPO/KoAs=;
        b=a++GAJMKIjBbkgVG8RO7e41dCcrgn3bTBFG0dTZ4WfJfVs09qzEDiAwtSMK3d9kHj4
         GmoAMHPkm5Il4oj3RSdOxMzcwpolxKrz4SR9x6AQ5w+jPH6+w1ByrOmweG8Dl0yRi2OX
         CrWd7pV015JihdYkAxEXUJjzvvkxMOimP91Oo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type:content-transfer-encoding;
        b=lS7c11gSkZbwhCJtmOIj1TCl0u2pkC7E5eteW3753RHKSPzG3XVUj7SqzNJ+Fzyto7
         skMqRtr8ZSFlS95rcCgEOZTVyAQ9QH1CS1frD8o0sqzI8NI3MYS54wXEFCat1AoEA5jD
         aGbShIwvY5yiJTX+G8AqGjpnsAhQnkguR4Pgs=
Received: by 10.216.35.74 with SMTP id t52mr3555265wea.41.1288610479279; Mon,
 01 Nov 2010 04:21:19 -0700 (PDT)
Received: by 10.216.172.199 with HTTP; Mon, 1 Nov 2010 04:20:59 -0700 (PDT)
In-Reply-To: <87zkttqqse.fsf@anar.kanru.info>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160478>

2010/11/1 Kan-Ru Chen <kanru@kanru.info>:
> Hi,
>
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes:
>
>> This is a hack, to scratch my itch. These patches add "git ls",
>> which is equivalent to "git ls-files --max-depth 1|column"
>
> What is the status of this patch?

Stalled. I found that there's some more to do. "ls" shows directories.
"git ls" may not.

There were suggestions on improving the columnization part. I should
have resubmitted the column patches because it's really useful. Will
try to make it before the original series celebrates one year old.
--=20
Duy
