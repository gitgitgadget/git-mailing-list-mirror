From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 1/5] tag -v: use =?utf-8?B?4oCYZ2l0?=
	=?utf-8?Q?_verify-tag=E2=80=99?= without dash
Date: Sat, 20 Mar 2010 00:11:48 -0500
Message-ID: <20100320051148.GA24791@progeny.tock>
References: <20100320050953.GA24746@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Carlos Rica <jasampler@gmail.com>,
	Santi =?iso-8859-1?Q?B=E9jar?= <santi@agolina.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 20 06:11:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nsqxm-0008Gu-PS
	for gcvg-git-2@lo.gmane.org; Sat, 20 Mar 2010 06:11:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751998Ab0CTFLA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Mar 2010 01:11:00 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:48012 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751690Ab0CTFK7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Mar 2010 01:10:59 -0400
Received: by gwaa18 with SMTP id a18so139413gwa.19
        for <git@vger.kernel.org>; Fri, 19 Mar 2010 22:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=RHuk6ULwTekiz/97WvLAL8v0AHvLfJHAfG/Fkb8HBqg=;
        b=haF1I3JJP2tGhIGdz5KbOfhMGFh16NiiSdQE3I+axWTbaBdqBkFxSY8wTbGble/xCc
         l83AwN+tejhsDieEv2gZiKqqxJMn9StuY2wwrV/Pu1tdMmctTFH4WWk1xiXE0XqMUavD
         VvoYpCiRTp9BUNRR5maLKARRBmbZ1ldCbK6Gc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=n1e6uF6Nd4Gs+30ZWlSA16Kfsc/8LmOjbLjteuqlGDrY9x4jTspV7NaDUjxWzYsQ3U
         M6N1+N4ZxK1ZmoQPVDrP/RAQFPqiUw1cn62AJvfW6a9LrFzDKtO6pnWwWI9mBjK7ML7M
         n4LFD1ZW1skrDmuaS4LmOAmTQqYEwecoNacm4=
Received: by 10.100.24.40 with SMTP id 40mr9211855anx.77.1269061858369;
        Fri, 19 Mar 2010 22:10:58 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 20sm1111945iwn.1.2010.03.19.22.10.57
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 19 Mar 2010 22:10:58 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100320050953.GA24746@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142682>

There is not much reason to avoid dashed command names here except
setting a good example, but setting a good example is reason enough.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 builtin/tag.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/tag.c b/builtin/tag.c
index 4ef1c4f..d56c882 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -147,9 +147,9 @@ static int delete_tag(const char *name, const char *ref,
 static int verify_tag(const char *name, const char *ref,
 				const unsigned char *sha1)
 {
-	const char *argv_verify_tag[] = {"git-verify-tag",
+	const char *argv_verify_tag[] = {"git", "verify-tag",
 					"-v", "SHA1_HEX", NULL};
-	argv_verify_tag[2] = sha1_to_hex(sha1);
+	argv_verify_tag[3] = sha1_to_hex(sha1);
 
 	if (run_command_v_opt(argv_verify_tag, 0))
 		return error("could not verify the tag '%s'", name);
-- 
1.7.0.2
