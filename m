From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 05/17] Documentation: add missing quotes to "git grep"
 examples
Date: Fri, 20 Aug 2010 05:28:53 -0500
Message-ID: <20100820102853.GE10407@burratino>
References: <20100820101902.GA10356@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	=?utf-8?B?RnLDqWTDqXJpYyBCcmnDqHJl?= <fbriere@fbriere.net>,
	Christian Couder <chriscool@tuxfamily.org>,
	Thomas Rast <trast@student.ethz.ch>,
	Mark Lodato <lodatom@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 20 12:30:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OmOs1-0001wT-Rm
	for gcvg-git-2@lo.gmane.org; Fri, 20 Aug 2010 12:30:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752173Ab0HTKal convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 20 Aug 2010 06:30:41 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:57508 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751311Ab0HTKak convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Aug 2010 06:30:40 -0400
Received: by iwn5 with SMTP id 5so683023iwn.19
        for <git@vger.kernel.org>; Fri, 20 Aug 2010 03:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=E0IMZ/vdwfHyEPfFpKF0YUd0zx53B0ntl43jX8BV40Y=;
        b=T4LAF7sEi701Y6ICVycGVHbOS9nji9UUlh+msyawv5d4XZ7xTnkKYSbUiLmNnSMKU+
         /G9NkL5n5uZf4OtZd1f3Xg87JH5KBpHm7ABbr66gDEYcHpKciGiQemVEM+9fGLMCJycI
         i1/+qzJGyM/5MxIcORzdbe3elgd1mcybnS3Hw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=wlnm90d7QVxYWjd6HTSWmBEfNbW82yGpc4SE3UcwkOl8bh40w2S1LjOugL/uxx9x4v
         ruqZ4SKDP3IdZ6OoEQOYT0ku9l1wdL2s6zB85VnQfOtWZd51Rl/f97XvwYmWv46ETmTF
         JxC6HCr8wHk3BkPJ69JWiD1e8v+g6TfpkQo/Y=
Received: by 10.231.192.80 with SMTP id dp16mr1458167ibb.39.1282300239386;
        Fri, 20 Aug 2010 03:30:39 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id j2sm2492899iba.18.2010.08.20.03.30.38
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 20 Aug 2010 03:30:39 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100820101902.GA10356@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153999>

Without an indication to the contrary, Asciidoc puts 'quoted
text' in italics, making the output look like this:

	git grep time_t -- *.[ch]
	    Looks for time_t in all tracked .c and .h
	    files in the working directory and its subdirectories.

	git grep -e '#define\' --and \( -e MAX_PATH -e PATH_MAX \)
	    Looks for a line that has #define and either MAX_PATH or
	    PATH_MAX.

In the first example, the *.[ch] argument needs to be protected from
the shell, or else it will only match files in the current directory.
The second example has a stray backslash.

Reported-by: Fr=C3=A9d=C3=A9ric Bri=C3=A8re <fbriere@fbriere.net>
Cc: Mark Lodato <lodatom@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 Documentation/git-grep.txt |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index 5474dd7..dab0a78 100644
--- a/Documentation/git-grep.txt
+++ b/Documentation/git-grep.txt
@@ -191,11 +191,11 @@ OPTIONS
 Examples
 --------
=20
-git grep 'time_t' \-- '*.[ch]'::
+git grep {apostrophe}time_t{apostrophe} \-- {apostrophe}*.[ch]{apostro=
phe}::
 	Looks for `time_t` in all tracked .c and .h files in the working
 	directory and its subdirectories.
=20
-git grep -e \'#define\' --and \( -e MAX_PATH -e PATH_MAX \)::
+git grep -e {apostrophe}#define{apostrophe} --and \( -e MAX_PATH -e PA=
TH_MAX \)::
 	Looks for a line that has `#define` and either `MAX_PATH` or
 	`PATH_MAX`.
=20
--=20
1.7.2.2.536.g42dab.dirty
