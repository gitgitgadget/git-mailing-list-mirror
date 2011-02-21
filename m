From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 15/15] add --refresh --verbose: mark "Unstaged changes"
 heading for translation
Date: Mon, 21 Feb 2011 04:29:17 -0600
Message-ID: <20110221102917.GP32137@elie>
References: <1298143495-3681-1-git-send-email-avarab@gmail.com>
 <20110221040012.GB26968@elie>
 <20110221101229.GA32137@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 21 11:37:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PrT9B-0002cB-6G
	for gcvg-git-2@lo.gmane.org; Mon, 21 Feb 2011 11:37:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753300Ab1BUKhg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 21 Feb 2011 05:37:36 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:44595 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754177Ab1BUKhf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Feb 2011 05:37:35 -0500
Received: by iyb26 with SMTP id 26so572325iyb.19
        for <git@vger.kernel.org>; Mon, 21 Feb 2011 02:37:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=Fg+J5S4MHboVn1WvpWiHf3+jNUYtJfkdkEUx8/80KCc=;
        b=bvehHqa4huKPM1aw62XJ65gHnHPKgVdwiTdYcsqynkeIw2P6t/ZtpNGcBERsJBxmL8
         XvJBsJQYv9/V++TZXLE5Edvad8yyq8xyVkprSUS1aUf9O+M/mcyYf8GxPjAA5NWVh9vW
         Eq8FoybGvMLI/3A/A3Itup+Tzn4XzKCUioOpU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=CzoVMkyER8f9iOQVnbmXw/8zgzVyZyW3j3LUUefkF3jBkVNQi3g9G4atKVn8dsFyvL
         Uy5RBhvF/yKk8epSNM3AYdkw2mC/cJaP3/qUjs1dtKXAhMS3CuLy5lZpGXwd/0hVhgfW
         NTWojP6uHZW9huRRQYiWenBpVCDFLJlPTUMtE=
Received: by 10.43.70.143 with SMTP id yg15mr1751785icb.60.1298284162693;
        Mon, 21 Feb 2011 02:29:22 -0800 (PST)
Received: from elie (adsl-69-209-53-52.dsl.chcgil.sbcglobal.net [69.209.53.52])
        by mx.google.com with ESMTPS id i16sm5049019ibl.6.2011.02.21.02.29.20
        (version=SSLv3 cipher=OTHER);
        Mon, 21 Feb 2011 02:29:22 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110221101229.GA32137@elie>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167471>

=46rom: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
Date: Wed, 1 Sep 2010 18:49:22 +0000

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
That's the end of the series.  Thanks for reading.

I also should say, to be clear, I will not be sending more series like
this (though if there are bugs in this one I'd be happy to fix them).

 builtin/add.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index 33b9970..a512597 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -188,7 +188,7 @@ static void refresh(int verbose, const char **paths=
pec)
 		/* nothing */;
 	seen =3D xcalloc(specs, 1);
 	refresh_index(&the_index, verbose ? REFRESH_IN_PORCELAIN : REFRESH_QU=
IET,
-		      pathspec, seen, "Unstaged changes after refreshing the index:"=
);
+		      pathspec, seen, _("Unstaged changes after refreshing the index=
:"));
 	for (i =3D 0; i < specs; i++) {
 		if (!seen[i])
 			die(_("pathspec '%s' did not match any files"), pathspec[i]);
--=20
1.7.4.1
