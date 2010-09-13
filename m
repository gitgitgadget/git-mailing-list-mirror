From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH/RFC 01/12] gettextize: git-submodule add git-sh-i18n
Date: Mon, 13 Sep 2010 22:09:07 +0000
Message-ID: <1284415758-20931-2-git-send-email-avarab@gmail.com>
References: <1284415758-20931-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Lars Hjemli <hjemli@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 14 00:10:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OvHDl-0006mj-La
	for gcvg-git-2@lo.gmane.org; Tue, 14 Sep 2010 00:09:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753511Ab0IMWJq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 13 Sep 2010 18:09:46 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:64182 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752950Ab0IMWJo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Sep 2010 18:09:44 -0400
Received: by mail-ww0-f44.google.com with SMTP id 20so393266wwd.1
        for <git@vger.kernel.org>; Mon, 13 Sep 2010 15:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=YFY6YopsWjtw2gc41tadno4aEaApL+i/TGe9S3flfu8=;
        b=pb/NkT17wM9+34ip+sZ4pZok2RZPvhx0urLeaSm41zTiuFDPENoz+rx/wXCY+kP7yt
         pOcQYfOmRr8NLEgk//RRHFeGFYUlzaGuuIvS4Po+dB/tL9esAm6s6qM2ac8C+etybwKS
         n+VuGftzctkk+SmRIWEn4JL6Sn5LOOzZu+66o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=mGy72IJ7Q6lpLhBYb8bqV1Cr9R1jzJpGv3GZMlmXVciZ2nd5AugiHyKcK/vwgBggvF
         XlLtPYyumAArsHIROj6stAdAighN2e0cwaYVxnxje6D0aeKZZHYXvmSgvwBIKUoDcLIw
         hNx/dxoCw1VlMYiFWjLJt1foNdZmQKz4iHjzw=
Received: by 10.216.154.131 with SMTP id h3mr3156716wek.74.1284415783945;
        Mon, 13 Sep 2010 15:09:43 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id w14sm4296416weq.9.2010.09.13.15.09.42
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 13 Sep 2010 15:09:42 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.rc1.220.gb4d42
In-Reply-To: <1284415758-20931-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156133>

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 git-submodule.sh |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 9ebbab7..5ef3d0d 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -14,6 +14,7 @@ USAGE=3D"[--quiet] add [-b branch] [-f|--force] [--re=
ference <repository>] [--] <r
    or: $dashless [--quiet] sync [--] [<path>...]"
 OPTIONS_SPEC=3D
 . git-sh-setup
+. git-sh-i18n
 . git-parse-remote
 require_work_tree
=20
--=20
1.7.3.rc1.220.gb4d42
