From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv2 2/2] gitweb: clean up gitweb_check_feature() calls
Date: Sat, 29 Nov 2008 12:18:22 +0100
Message-ID: <200811291218.22775.jnareb@gmail.com>
References: <1227904793-1821-3-git-send-email-giuseppe.bilotta@gmail.com> <1227957301-7417-1-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Petr Baudis <pasky@suse.cz>,
	Junio C Hamano <gitster@pobox.com>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 29 12:19:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L6NrU-0008PB-6s
	for gcvg-git-2@gmane.org; Sat, 29 Nov 2008 12:19:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751260AbYK2LS2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Nov 2008 06:18:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751221AbYK2LS1
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Nov 2008 06:18:27 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:53091 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751207AbYK2LS1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Nov 2008 06:18:27 -0500
Received: by ug-out-1314.google.com with SMTP id 39so2172224ugf.37
        for <git@vger.kernel.org>; Sat, 29 Nov 2008 03:18:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=6VxgXjlLGI92SV53cSUM5IFS+NqkEKKOYkeijv2rVn8=;
        b=QswPtUOxMhlJE/14ZbJ2XVe+vc6K8SAypq+KXe+15vrPvqgQuBv4r+p5pwMFYrifAc
         O7JfAYbudFBaUA+FiRLvmJ800sqA4pDJhV0R+CHjdCOohDWNXAcSoja3IcZW00SfgZ1I
         YE02UW76NzIll4oWEXFCnJdHKjGBmxytoVsmo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=in7ollxm2Ua2WQQTTcRCCVTZbJXfXi3xwp9d3JrR94xQaGjOU8cr+4LH+E9WB4Ezat
         KpmVotlipbHu3LAYoVIaudGGSHQA9X1nztKSG6YCYXEn2IkId2jBkvChkW7K2Mfft9w8
         L7Cru3f2iG12FA+mbV1gs5G7K6J3NmNKiGDrs=
Received: by 10.67.97.1 with SMTP id z1mr1656713ugl.9.1227957505646;
        Sat, 29 Nov 2008 03:18:25 -0800 (PST)
Received: from ?192.168.1.11? (abvh10.neoplus.adsl.tpnet.pl [83.8.205.10])
        by mx.google.com with ESMTPS id s8sm1804907uge.18.2008.11.29.03.18.23
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 29 Nov 2008 03:18:24 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <1227957301-7417-1-git-send-email-giuseppe.bilotta@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101906>

Giuseppe Bilotta wrote:

> Since git_check_feature now returns a scalar, the parentheses around the
        ^^^
         \---- missed one.

> variables initialized from gitweb_check_feature() are not needed.
> 
> We remove them for stylistic consistency and to prevent unnecessary
> ambiguity in the code.
> 
> Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
> ---
> 
> Fixed the commit message, use this instead of the previous one.

-- 
Jakub Narebski
Poland
