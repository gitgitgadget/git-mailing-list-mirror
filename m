From: =?UTF-8?B?SmFrdWIgTmFyxJlic2tp?= <jnareb@gmail.com>
Subject: [PATCH] gitweb/INSTALL: GITWEB_CONFIG_SYSTEM is for backward compatibility
Date: Tue, 16 Apr 2013 14:26:01 +0200
Message-ID: <516D4359.2070501@gmail.com>
References: <CAPig+cSXC6cA8gc1T=byqeQF_gUYKpHTjpTt54Xog=jtfdgMwA@mail.gmail.com> <85f4e2b8e40efb234a7fc0d0ce0d40562690d001.1365719690.git.stefano.lattarini@gmail.com> <7v4nfch90r.fsf@alter.siamese.dyndns.org> <20130412064837.GA5710@elie.Belkin> <20130412064953.GB5710@elie.Belkin> <7vy5cnd0m4.fsf@alter.siamese.dyndns.org> <516888C0.90501@gmail.com> <CAM9Z-nmOzpJdT3ni0rYRkg7Z26N5XSRyqp0TkTY79AAZ85pw2A@mail.gmail.com> <7vobdfnlc7.fsf@alter.siamese.dyndns.org> <CAM9Z-nm=SUNAHXZtOnz_BSS8VrVYPczicX99FUmDJe6Lj_oKpQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org,
	Stefano Lattarini <stefano.lattarini@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Drew Northup <n1xim.email@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 16 14:26:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1US4xg-0002wQ-Ie
	for gcvg-git-2@plane.gmane.org; Tue, 16 Apr 2013 14:26:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756379Ab3DPM0H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Apr 2013 08:26:07 -0400
Received: from mail-ee0-f45.google.com ([74.125.83.45]:64387 "EHLO
	mail-ee0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755268Ab3DPM0G (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Apr 2013 08:26:06 -0400
Received: by mail-ee0-f45.google.com with SMTP id c50so215272eek.32
        for <git@vger.kernel.org>; Tue, 16 Apr 2013 05:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        bh=wMwu/ugafcl+vxoKrLbUwSsLU9PXfIifRA3cfbxoajI=;
        b=NVwa9ez8YBnY7wsmcpLy7s36rQ5Xgwcae/W/dEhB/WS7iVOtsjIvkfUl16dH7ghAq2
         xEtld6+r8zVxBV3WZNeWcDtUzDXYwySriM7gq+93rx8nAdKeRlMPBTiRYbC5Zhiin7tf
         bHD23tg7xGaG6v5rkQO5qeF1n5w3D55KlzEuGZ+8Eie9iEipKSEEcZwBh9Z4yxq7ULL1
         TK8JMZJ0jda5uhzY6yRsLzy8y6azlCYm3W/PhzxLYwc9uDMbNsYzGuDqS0BtoeapPukS
         t1JHGdCwIAaszDvJAEiKL7FWAPMy9vsfys0BPhCKjeDPjpEi8XY/v50nJ+EKMDiT4PX7
         rPog==
X-Received: by 10.15.32.67 with SMTP id z43mr5917496eeu.24.1366115164195;
        Tue, 16 Apr 2013 05:26:04 -0700 (PDT)
Received: from [192.168.1.14] (ept17.neoplus.adsl.tpnet.pl. [83.20.61.17])
        by mx.google.com with ESMTPS id bk42sm2627054eeb.3.2013.04.16.05.26.02
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 16 Apr 2013 05:26:03 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130329 Thunderbird/17.0.5
In-Reply-To: <CAM9Z-nm=SUNAHXZtOnz_BSS8VrVYPczicX99FUmDJe6Lj_oKpQ@mail.gmail.com>
X-Enigmail-Version: 1.5.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221410>

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
This can be either squashed with previous patch to gitweb/INSTALL,
kept as separate patch or discarded.

Drew: gitweb(1) or gitweb.conf(5) solution is more involved, so
perhaps something like that?

 gitweb/INSTALL |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/gitweb/INSTALL b/gitweb/INSTALL
index 7ad1050..386e62f 100644
--- a/gitweb/INSTALL
+++ b/gitweb/INSTALL
@@ -243,7 +243,6 @@ for gitweb (in gitweb/README), and gitweb.conf(5) manpage.
   GITWEB_CONFIG_SYSTEM build configuration variable, and override it
   through the GITWEB_CONFIG_SYSTEM environment variable.
 
-
   Note that the GITWEB_CONFIG_SYSTEM system-wide configuration file is
   only used for instances that lack per-instance configuration file.
   You can use GITWEB_CONFIG_COMMON common system-wide configuration
@@ -252,6 +251,8 @@ for gitweb (in gitweb/README), and gitweb.conf(5) manpage.
   system-wide configuration file override those from common system-wide
   configuration file.
 
+  (Idiosyncratic GITWEB_CONFIG_SYSTEM is present for backward compatibility.)
+
 - The gitweb config file is a fragment of perl code. You can set variables
   using "our $variable = value"; text from "#" character until the end
   of a line is ignored. See perlsyn(1) for details.
-- 
1.7.10.4
