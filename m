From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: [PATCH] command-list.txt: mark git-archive plumbing
Date: Tue, 15 Feb 2011 14:04:26 +0700
Message-ID: <20110215070426.GA6118@duynguyen-vnpc>
References: <4D4EF7E4.7050303@hartwork.org>
 <vpq1v3kopn3.fsf@bauges.imag.fr>
 <7vwrlcv1ea.fsf@alter.siamese.dyndns.org>
 <20110207055314.GA5511@sigill.intra.peff.net>
 <7vhbcguytf.fsf@alter.siamese.dyndns.org>
 <20110207195035.GA13461@sigill.intra.peff.net>
 <20110208100518.GA9505@neumann>
 <20110209210312.GB2083@sigill.intra.peff.net>
 <7vipwsomq8.fsf@alter.siamese.dyndns.org>
 <20110209234621.GA12575@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Sebastian Pipping <webmaster@hartwork.org>,
	Git ML <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 15 08:05:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PpEyR-0005rZ-UZ
	for gcvg-git-2@lo.gmane.org; Tue, 15 Feb 2011 08:05:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752041Ab1BOHFT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 Feb 2011 02:05:19 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:46860 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751931Ab1BOHFR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Feb 2011 02:05:17 -0500
Received: by ywo7 with SMTP id 7so2418184ywo.19
        for <git@vger.kernel.org>; Mon, 14 Feb 2011 23:05:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=ETjrVJKJ/X94bQqimZOR8CrWITmmPheExR2ZtDwxXlU=;
        b=obr07PhtnkvC5ynL/GBOmRUi8zB9XCBtwSZmW0jtbb8RNG9pefl8H07lHS2j8I8Jep
         nmGSf11XIXBrydhG1LoLe1bVYrA3j8vQNfcfn+q+rzz/BMsMkfoE2MGkNh9ouPuhLM8a
         Bf/O8PDbJqvq1JX7bO2dlrObqwV3jtTj8+OEA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=UWgepqIAjGPGBE2uxcgXrm22H6TDt9hkCA/wkLnKKMDsRegeq7FP05IqgYRGzusJbc
         ABISB7hsEVkNnaWMn6B9ACtau0nA4s9fRTbyt9oRXpaawW7PFMvPsu3nAlDdjJxm1ZXI
         DMOzcAeQwGJfo+2Q4QLYDivlfeELMqGmSRRbI=
Received: by 10.90.90.18 with SMTP id n18mr5708438agb.101.1297753516223;
        Mon, 14 Feb 2011 23:05:16 -0800 (PST)
Received: from pclouds@gmail.com ([118.69.34.31])
        by mx.google.com with ESMTPS id f10sm4627099anh.25.2011.02.14.23.05.11
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 14 Feb 2011 23:05:15 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Tue, 15 Feb 2011 14:04:26 +0700
Content-Disposition: inline
In-Reply-To: <20110209234621.GA12575@sigill.intra.peff.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166817>

The command's official status is porcelain. However by the nature of th=
e
command it is frequently used in scripting and therefore its interface
must be strictly backward compatible.

Mark it plumbing to make it clear.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
  On Wed, Feb 09, 2011 at 06:46:21PM -0500, Jeff King wrote:
  > Obviously add and grep are the two that people have talked about. T=
he
  > archive behavior surprised me, and I would think it should be full-=
tree
  > by default. But it is sort of plumbing-ish, in that people have pro=
bably
  > scripted around and people _don't_ tend to create archives a lot. S=
o it
  > may fall into the same category as ls-files/ls-tree.
 =20
  Perhaps a patch like this for the record?

 command-list.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/command-list.txt b/command-list.txt
index 95bf18c..7888121 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -5,7 +5,7 @@ git-am                                  mainporcelain
 git-annotate                            ancillaryinterrogators
 git-apply                               plumbingmanipulators
 git-archimport                          foreignscminterface
-git-archive                             mainporcelain
+git-archive                             mainporcelain plumbinginterrog=
ators
 git-bisect                              mainporcelain common
 git-blame                               ancillaryinterrogators
 git-branch                              mainporcelain common
--=20
1.7.3.1.256.g2539c.dirty
