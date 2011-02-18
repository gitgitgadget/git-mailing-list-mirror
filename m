From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 5/3] block-sha1: do not use relative path for
 git-compat-util.h
Date: Thu, 17 Feb 2011 22:34:14 -0600
Message-ID: <20110218043413.GE15643@elie>
References: <7vmxm4onwk.fsf@alter.siamese.dyndns.org>
 <1297304069-14764-1-git-send-email-pclouds@gmail.com>
 <20110218022701.GA23435@elie>
 <20110218023750.GD23435@elie>
 <AANLkTi=VhJi4eDrtRPHukckQKo9TYCcnh1_u0_tnv24z@mail.gmail.com>
 <20110218042916.GC15643@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Nicolas Pitre <nico@fluxnic.net>, Jeff King <peff@peff.net>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 18 05:34:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqI2y-0001bp-JJ
	for gcvg-git-2@lo.gmane.org; Fri, 18 Feb 2011 05:34:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752283Ab1BREeU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Feb 2011 23:34:20 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:61503 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751973Ab1BREeS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Feb 2011 23:34:18 -0500
Received: by iyj8 with SMTP id 8so3118230iyj.19
        for <git@vger.kernel.org>; Thu, 17 Feb 2011 20:34:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=rzTdMKE1pfpfBB8p4+f4EBt70m2S2kU7cvuIoQp0Ngs=;
        b=ecFId0UsT+XVfLysDOkoDu6P9T5QjzpyPD9xftfKdOesokEVVtBjBBrXbE1gX1H76p
         cZAK8FttxT5Nx+aEJtDHIwMS+0Q0TWhUnYgGo9EgRe+iRyZj3xIINp3CjK9rcu3l9Wf2
         HC623VNk9Zp3JboJXmzD3tp0H8Ardkyq0xu9k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=P+jxdE2TuVnaTlAc7n+8wWRGXxIpD9HaeWD9HACFV361M+4RrdlWaOQs4lEX5DYSDj
         e5UdB8qLKoYX/JY4IbL0+lKlB5quVa86pFjysbAu6bN0Sr0IclCxxMS3J/L6vLym41MZ
         V/bQyuMdyi59Lw47pUCP3SeBrCeGuo/4grtSA=
Received: by 10.42.178.135 with SMTP id bm7mr347368icb.101.1298003658317;
        Thu, 17 Feb 2011 20:34:18 -0800 (PST)
Received: from elie (adsl-69-209-72-148.dsl.chcgil.ameritech.net [69.209.72.148])
        by mx.google.com with ESMTPS id u9sm1341861ibe.2.2011.02.17.20.34.16
        (version=SSLv3 cipher=OTHER);
        Thu, 17 Feb 2011 20:34:17 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110218042916.GC15643@elie>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167169>

Rely on the includepath instead of specifying a path to
git-compat-util.h explicitly.  This way, git-compat-util.h can move
more easily.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 block-sha1/sha1.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/block-sha1/sha1.c b/block-sha1/sha1.c
index c0054a0..71464fa 100644
--- a/block-sha1/sha1.c
+++ b/block-sha1/sha1.c
@@ -7,7 +7,7 @@
  */
 
 /* this is only to get definitions for memcpy(), ntohl() and htonl() */
-#include "../git-compat-util.h"
+#include "git-compat-util.h"
 
 #include "sha1.h"
 
-- 
1.7.4.1
