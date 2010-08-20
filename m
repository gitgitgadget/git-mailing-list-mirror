From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 04/17] Documentation: clarify quoting in "git add" example
Date: Fri, 20 Aug 2010 05:26:13 -0500
Message-ID: <20100820102613.GD10407@burratino>
References: <20100820101902.GA10356@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	=?utf-8?B?RnLDqWTDqXJpYyBCcmnDqHJl?= <fbriere@fbriere.net>,
	Christian Couder <chriscool@tuxfamily.org>,
	Thomas Rast <trast@student.ethz.ch>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 20 12:28:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OmOpO-0000qm-Qe
	for gcvg-git-2@lo.gmane.org; Fri, 20 Aug 2010 12:28:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752138Ab0HTK16 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 20 Aug 2010 06:27:58 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:48579 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751431Ab0HTK14 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Aug 2010 06:27:56 -0400
Received: by iwn5 with SMTP id 5so680430iwn.19
        for <git@vger.kernel.org>; Fri, 20 Aug 2010 03:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=6M9rZ1V1AsLsBOwC08ZgPME+qxfcj3CY0J6+PCea5jw=;
        b=TpJdJZMoWryUQRNZlU4GwEQvTu3QGDnkpKyQ+x0k9z0bhKRLYfk1FlrjU4t+l0ZR0L
         kBTtMp2X2gez/Qy4CBOYloF33SAdm0iBKiC+aE/mLUn6X1wtwcBWfU50flkkCK3JCeQk
         x8JsQQlnIh9ldf/i5FSvF25bZCAIk3vhwmW6w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=tD7Sz8638IrgtWcdydofYGiowNIF6Bx8HFWI7M7udtBhOTZ+WIQ0bUOrorWeFTJM6g
         q37yhR5m2d3nMKJB0BQBw8OxntGk2AgiHCvvQbXxymVqYm5s3VDb4Zc6u2NLEvCQK1+9
         gVU58qAMNNWkcaXDDjRCYun4lS3EeHROMeYQU=
Received: by 10.231.157.212 with SMTP id c20mr1249645ibx.186.1282300074481;
        Fri, 20 Aug 2010 03:27:54 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id n20sm2490792ibe.17.2010.08.20.03.27.53
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 20 Aug 2010 03:27:54 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100820101902.GA10356@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153998>

The intended text looks like this:

	=C2=B7 Adds content from all *.txt files under Documentation
	  directory and its subdirectories:

		$ git add Documentation/\*.txt

	  Note that the asterisk * is quoted from the shell in this
	  example; this lets the command include the files from
	  subdirectories of Documentation/ directory.

The current asciidoc 8.5.2 output has a backslash before _every_
asterisk, which is more confusing than it needs to be.

Reported-by: Fr=C3=A9d=C3=A9ric Bri=C3=A8re <fbriere@fbriere.net>
Cc: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 Documentation/git-add.txt |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
index e22a62f..e213a2e 100644
--- a/Documentation/git-add.txt
+++ b/Documentation/git-add.txt
@@ -157,14 +157,14 @@ those in info/exclude.  See linkgit:gitrepository=
-layout[5].
 EXAMPLES
 --------
=20
-* Adds content from all `\*.txt` files under `Documentation` directory
+* Adds content from all `*.txt` files under `Documentation` directory
 and its subdirectories:
 +
 ------------
 $ git add Documentation/\*.txt
 ------------
 +
-Note that the asterisk `\*` is quoted from the shell in this
+Note that the asterisk `*` is quoted from the shell in this
 example; this lets the command include the files from
 subdirectories of `Documentation/` directory.
=20
--=20
1.7.2.2.536.g42dab.dirty
