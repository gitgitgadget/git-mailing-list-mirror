From: Mark Lodato <lodatom@gmail.com>
Subject: Re: [PATCH 4/4] grep docs: document --no-index option
Date: Fri, 26 Feb 2010 17:07:48 -0500
Message-ID: <ca433831002261407l4d708283m5129c582a55fb1b6@mail.gmail.com>
References: <1267155613-22134-1-git-send-email-lodatom@gmail.com> 
	<1267155613-22134-5-git-send-email-lodatom@gmail.com> <7vocjceg0y.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 26 23:08:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nl8M4-0003lU-85
	for gcvg-git-2@lo.gmane.org; Fri, 26 Feb 2010 23:08:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759484Ab0BZWIL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 26 Feb 2010 17:08:11 -0500
Received: from mail-gw0-f46.google.com ([74.125.83.46]:54799 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759448Ab0BZWIJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 Feb 2010 17:08:09 -0500
Received: by gwb19 with SMTP id 19so163404gwb.19
        for <git@vger.kernel.org>; Fri, 26 Feb 2010 14:08:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=nISktFn0h+DLRUOv7jiXVW6KcfQ8T6WwfMkEGGSDVJ8=;
        b=raE43dJgezG5NDb4nzq8KbGyFmjUVjs9+pvUhawz1930RndIE1u08O6B1VNJXvH6+g
         BOwKd7HdbesBXpR1OUeo5eTRIDo9+XLAVKFe2QEICLUEhCvUhtdhoLZkZ0DIm+X754Zz
         mlJpyiLr+5URkydkykXsXfYkdBvRl2R81BZIk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=LC99YflCmqgEl8WvMfwZmvAXmvlchyzuuQ9pkNoOT/kP4KYCqN1nVe2YaQWmHHUle3
         /h7jP60BW+fiEElc3EL29ETpZ1N8ZS57DW7C94734CZulOwWCv06+20heVXzMkHPuAg8
         s8yf0XrYPrCf0BeHX9x74TuJio6d4wFDUZi0Q=
Received: by 10.91.29.19 with SMTP id g19mr1076511agj.38.1267222088573; Fri, 
	26 Feb 2010 14:08:08 -0800 (PST)
In-Reply-To: <7vocjceg0y.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141156>

On Fri, Feb 26, 2010 at 12:13 AM, Junio C Hamano <gitster@pobox.com> wr=
ote:
> Mark Lodato <lodatom@gmail.com> writes:
>
>> +--no-index::
>> + =C2=A0 =C2=A0 Search all files in the working tree, not just those=
 tracked by git.
>
> This one is meant to be usable outside git directory, and saying "the
> working tree" is misleading. =C2=A0The "work tree" is a technical ter=
m that
> specifically means the files in the directory hierarchy on the filesy=
stem
> that correspond to the index entries that represent them.
>
> It probably should say "the current directory" or something here.

Here's a squashable commit to do just that.

---
 Documentation/git-grep.txt |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index 86d7401..3e6eaf7 100644
--- a/Documentation/git-grep.txt
+++ b/Documentation/git-grep.txt
@@ -37,7 +37,8 @@ OPTIONS
        blobs registered in the index file.

 --no-index::
-       Search all files in the working tree, not just those tracked by=
 git.
+       Search all files in the current directory, not just those track=
ed
+       by git.

 -a::
 --text::
--=20
1.7.0
