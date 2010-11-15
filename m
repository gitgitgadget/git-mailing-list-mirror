From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 06/10] templates: add info/sparse-checkout
Date: Mon, 15 Nov 2010 17:36:46 +0700
Message-ID: <1289817410-32470-7-git-send-email-pclouds@gmail.com>
References: <1289817410-32470-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 15 11:39:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PHwTY-0002CQ-7h
	for gcvg-git-2@lo.gmane.org; Mon, 15 Nov 2010 11:39:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755691Ab0KOKjq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Nov 2010 05:39:46 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:54362 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755147Ab0KOKjp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Nov 2010 05:39:45 -0500
Received: by pwi9 with SMTP id 9so709951pwi.19
        for <git@vger.kernel.org>; Mon, 15 Nov 2010 02:39:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=0G5/ha09Y27qf2J5S3drKKWsD2prBRouvOT81aDxwDA=;
        b=YL7ChadF/+Afo7leA2pDQ/V4OWrEDx7UO17WXye8oBenTeyDlHOOmVWApNakXxSqZr
         k3lgwQ/C4wwGPVK9/FGRfzij2candhfhjoGDhwx/i/mt7ghnV0qBqgEEphN1Ow6Ysm4d
         3KfiYKvqG02qPbJOZ4TwZCBIg2NTAl2tJ9Ugk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=iNYL9m5lOlRtTaU0SOPF/ouRCEmnjBPnSFWXYtrIXO8TUGI+WQvAkhp9wbkmbs0uGd
         q+yJKiELUgYYCW714XyYw07uo2bNLOrfqWc8Md4Y/orGqbYnUsCtEvSdNQcUfMk14/yc
         v+8ZVIWKkyJDnL4r9YZpEeXUCw146mSfWB3/o=
Received: by 10.142.72.12 with SMTP id u12mr4715263wfa.159.1289817585431;
        Mon, 15 Nov 2010 02:39:45 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.247.75])
        by mx.google.com with ESMTPS id w42sm8576496wfh.3.2010.11.15.02.39.39
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 15 Nov 2010 02:39:44 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 15 Nov 2010 17:38:29 +0700
X-Mailer: git-send-email 1.7.3.2.210.g045198
In-Reply-To: <1289817410-32470-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161483>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 templates/info--sparse-checkout |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)
 create mode 100644 templates/info--sparse-checkout

diff --git a/templates/info--sparse-checkout b/templates/info--sparse-c=
heckout
new file mode 100644
index 0000000..7426475
--- /dev/null
+++ b/templates/info--sparse-checkout
@@ -0,0 +1,3 @@
+# Specify what files are checked out in working directory
+# Run "git checkout" after updating this file to update working direct=
ory
+*
--=20
1.7.3.2.210.g045198
