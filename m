From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 15/17] Documentation: avoid stray backslash in user manual
Date: Fri, 20 Aug 2010 05:38:14 -0500
Message-ID: <20100820103814.GO10407@burratino>
References: <20100820101902.GA10356@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	=?utf-8?B?RnLDqWTDqXJpYyBCcmnDqHJl?= <fbriere@fbriere.net>,
	Christian Couder <chriscool@tuxfamily.org>,
	Thomas Rast <trast@student.ethz.ch>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 20 12:40:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OmP0z-0006F6-Bo
	for gcvg-git-2@lo.gmane.org; Fri, 20 Aug 2010 12:40:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752677Ab0HTKj5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Aug 2010 06:39:57 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:51958 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751103Ab0HTKjz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Aug 2010 06:39:55 -0400
Received: by gxk23 with SMTP id 23so1168624gxk.19
        for <git@vger.kernel.org>; Fri, 20 Aug 2010 03:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=XSrthq7W0VlMdogKeR1uxBWjqJ3VWxToVMs5hkBd3ew=;
        b=goapryxHTR+H+Rqq7PfnWmnmm+OZFp0zXncCofDAY7ulBKJw6U/c1WKNaiANFELdKC
         38+piDjm168k8qrbP2Br2mZnUbcjXqEhSfKQH7g63xitniv/LkXg07jve1yD9k3BWft+
         2INrpXbxxsvbHgSh15+6Zt/JrDJkuAVXWmEj4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=ZSU4az3GVnu2m5bmIdddwcN92oogBlBHMt0H+IptCdUOLMnDuJjUFBLBIEKnCeQw6g
         1PcBQklcwnV4eaXAFHYa2rUENlC1QpuV2iCk/kVwe6IZv6GjSI3gDVJT0eFCMG46Q2RL
         2xQ36ogTHUn237h16cH9+gvrWwuaUVoq5F9IA=
Received: by 10.100.131.6 with SMTP id e6mr1390778and.111.1282300795163;
        Fri, 20 Aug 2010 03:39:55 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id j2sm2506330iba.0.2010.08.20.03.39.54
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 20 Aug 2010 03:39:54 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100820101902.GA10356@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154010>

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 Documentation/user-manual.txt |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index 22aee34..fecc4eb 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -4251,9 +4251,9 @@ Two things are interesting here:
   negative numbers in case of different errors--and 0 on success.
 
 - the variable `sha1` in the function signature of `get_sha1()` is `unsigned
-  char \*`, but is actually expected to be a pointer to `unsigned
+  char {asterisk}`, but is actually expected to be a pointer to `unsigned
   char[20]`.  This variable will contain the 160-bit SHA-1 of the given
-  commit.  Note that whenever a SHA-1 is passed as `unsigned char \*`, it
+  commit.  Note that whenever a SHA-1 is passed as `unsigned char {asterisk}`, it
   is the binary representation, as opposed to the ASCII representation in
   hex characters, which is passed as `char *`.
 
-- 
1.7.2.2.536.g42dab.dirty
