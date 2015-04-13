From: Julian Gindi <juliangindi@gmail.com>
Subject: Re: [PATCH v2] CodingGuidelines: updating 'rough' rule count
Date: Mon, 13 Apr 2015 00:26:44 -0400
Message-ID: <20150413042644.GA39596@Serenity.local>
References: <20150412234720.GA37658@Serenity.local>
 <CAPig+cS=xBoe-hr5Kwm0N9hBUy4bzN1NoXTcDEwz_4ZwrrXPXA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon Apr 13 06:26:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YhVxV-0008L4-Jp
	for gcvg-git-2@plane.gmane.org; Mon, 13 Apr 2015 06:26:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752196AbbDME0t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Apr 2015 00:26:49 -0400
Received: from mail-qk0-f178.google.com ([209.85.220.178]:34457 "EHLO
	mail-qk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750728AbbDME0s (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Apr 2015 00:26:48 -0400
Received: by qkgx75 with SMTP id x75so158880870qkg.1
        for <git@vger.kernel.org>; Sun, 12 Apr 2015 21:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=nDSm4TjJpzqd5lBd/dNqgHJ45YFetUqrPWrflk9zJoc=;
        b=KnBSI2ODmI7GHafKXI3q/YZBUmOIUaCyKar0e8YTP5lbMlA0LNLTXBruMpM7MUmmjs
         QeNLssgD+eIgDRswJXSFS3f9qhKPGg/Qg6NwFrdHAzNxhESge8ZlpSPMNpuMLj3GD78l
         zCwlYMj+qmBS+lrpOiiToJ8FAwMXEoUNJBHliKDgUfhGE5SnGMebDjx1vsa3F2WAL+Kl
         YUbZwoHNkjAGo1Gr/SLwT1ela/huV4PySOTT6b2j8l9rIz7hXISlZdmPygoFfVNAcJK4
         p8i2uGQi7eW4OVWc3amqUJzZW16RZQRLauQ3LCsXzfjX+3ZzHHbrTy4i/7oTKJo93uxT
         TQ6g==
X-Received: by 10.140.148.129 with SMTP id 123mr16622735qhu.23.1428899207745;
        Sun, 12 Apr 2015 21:26:47 -0700 (PDT)
Received: from localhost (c-50-190-25-147.hsd1.dc.comcast.net. [50.190.25.147])
        by mx.google.com with ESMTPSA id k85sm4943690qkh.48.2015.04.12.21.26.46
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 Apr 2015 21:26:46 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAPig+cS=xBoe-hr5Kwm0N9hBUy4bzN1NoXTcDEwz_4ZwrrXPXA@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267061>

    Changed inaccurate count of "rough rules" from three to the more
    generic 'a few'.
---
 Documentation/CodingGuidelines | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
index 0f8cccf..2dd35bd 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -1,5 +1,5 @@
 Like other projects, we also have some guidelines to keep to the
-code.  For Git in general, three rough rules are:
+code.  For Git in general, a few rough rules are:
 
  - Most importantly, we never say "It's in POSIX; we'll happily
    ignore your needs should your system not conform to it."
-- 
2.3.5
