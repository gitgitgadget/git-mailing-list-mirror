From: Ossi Herrala <oherrala@gmail.com>
Subject: [PATCH] Fix settings in default_user_config template
Date: Fri, 17 Apr 2015 20:08:54 +0300
Message-ID: <1429290535-38647-1-git-send-email-oherrala@gmail.com>
References: <20150417145516.GB2421@peff.net>
Cc: git@vger.kernel.org, Ossi Herrala <oherrala@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Apr 17 19:10:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yj9mN-00026K-Ey
	for gcvg-git-2@plane.gmane.org; Fri, 17 Apr 2015 19:10:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752876AbbDQRKH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Apr 2015 13:10:07 -0400
Received: from mail-la0-f52.google.com ([209.85.215.52]:33435 "EHLO
	mail-la0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751966AbbDQRKG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Apr 2015 13:10:06 -0400
Received: by layy10 with SMTP id y10so85292625lay.0
        for <git@vger.kernel.org>; Fri, 17 Apr 2015 10:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8hXcp1RsCK8m9lyOCUH1ArHCgsBMryBkII1fvOo+4Iw=;
        b=AUkn3Q3/Z0p7WqBgt4N3pRcN53ZEX2t0A7d8Wy3kZg0GG8u0zBm6Xax+OLw7OUgKrg
         MTcYDunsbBf/CtSXNWUUK28GW36b8k1w6xzEvl8COwI5K9dhZPd5mbXw3p7utIBPXjUH
         GkdlkdavaGPV8KKRwGCVL1Y4dj6/HTiCV4pZnEO6NVERyFRUZTQW+geydj3qgBaOrsC7
         jOPsqmpk3jz/kxG+4t5veXHchaiFgMihw0IoR1AWC3samP3fz/SBXGLs4cb+CMBH/BmL
         Dd0K9Xwun0QD+i9CK77lAhJ5bMx8Jz8Xq0PpDVEK3QxcxfyU+jtDvrNGutEZLHt24hhe
         Vl5w==
X-Received: by 10.112.17.68 with SMTP id m4mr5279258lbd.10.1429290604471;
        Fri, 17 Apr 2015 10:10:04 -0700 (PDT)
Received: from localhost.localdomain (nat4.panoulu.net. [212.50.147.101])
        by mx.google.com with ESMTPSA id oe1sm2529058lbb.23.2015.04.17.10.10.02
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 17 Apr 2015 10:10:03 -0700 (PDT)
X-Mailer: git-send-email 2.3.5
In-Reply-To: <20150417145516.GB2421@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267367>

The name (not user) and email setting should be in config section
"user" and not in "core" as documented in Documentation/config.txt.

Signed-Off-By: Ossi Herrala <oherrala@gmail.com>
Reviewed-by: Jeff King <peff@peff.net>
