From: Iain Paton <ipaton0@gmail.com>
Subject: Re: git no longer prompting for password
Date: Mon, 27 Aug 2012 09:28:25 +0100
Message-ID: <503B2FA9.6030700@gmail.com>
References: <5037E1D0.6030900@gmail.com> <20120824212501.GA16285@sigill.intra.peff.net> <5038E781.1090008@gmail.com> <20120825203904.GA10470@sigill.intra.peff.net> <5039F327.9010003@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Aug 27 10:29:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T5ugw-0000Gu-TL
	for gcvg-git-2@plane.gmane.org; Mon, 27 Aug 2012 10:29:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753347Ab2H0I24 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Aug 2012 04:28:56 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:65424 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752968Ab2H0I2z (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Aug 2012 04:28:55 -0400
Received: by weyx8 with SMTP id x8so2213663wey.19
        for <git@vger.kernel.org>; Mon, 27 Aug 2012 01:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=U1AFPWJnLTQ3tBSef8vfUZ9eRRSpWFkkO7WVV4f/DwU=;
        b=Nb2PyjdgxDG+85uev6JjQv0jMIQMdE2dkRJnsJFuqndiOFS6afQgcAcjAVt5UXSCJp
         G5IFQvhdxZvdJF5bZRLZ08kTVO08Y9WHfU+Fqrmhp3auBMvXA3e99LFlc2JwKdwN2nLh
         LAGJNxbj9jW0opVcuc1sihclWC2A8tcosBL0Uf6cDY3LHByNRcurFaA6yk0qVAaRbFJc
         3iaPhdHgYyVPICMXXiu1g5wXOxFWiOD20oZ+nBLUa8jgBygTlFhMDMuyXlwEsVO0Zx18
         xIDG0ABk66n1ahu0DTgJJomi1h//Yoeb5olAyKunMPIwVRMcotwCBaHukXR1DK7QrUgd
         Rg2w==
Received: by 10.180.75.209 with SMTP id e17mr27360606wiw.0.1346056134786;
        Mon, 27 Aug 2012 01:28:54 -0700 (PDT)
Received: from [10.44.16.58] (hades.darkvoyage.org.uk. [81.187.177.1])
        by mx.google.com with ESMTPS id k20sm14040722wiv.11.2012.08.27.01.28.53
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 27 Aug 2012 01:28:53 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:13.0) Gecko/20120615 Thunderbird/13.0.1
In-Reply-To: <5039F327.9010003@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204328>

On 26/08/12 10:57, Iain Paton wrote:

>         <If "%{THE_REQUEST} =~ /git-receive-pack/">

I've just discovered that the <If ..> directive only appears in apache 2.4 
so something more generic will probably be a better idea. Not everyone will 
be running 2.4.x for a while yet.

Iain
