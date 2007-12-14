From: Jakub Narebski <jnareb@gmail.com>
Subject: StGIT: "stg refresh -e/--edit" to refresh patch and edit description no longer works
Date: Fri, 14 Dec 2007 15:07:00 +0100
Message-ID: <200712141507.01552.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 14 15:07:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J3BCW-0002UL-8q
	for gcvg-git-2@gmane.org; Fri, 14 Dec 2007 15:07:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751785AbXLNOHR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Dec 2007 09:07:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751512AbXLNOHQ
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Dec 2007 09:07:16 -0500
Received: from nf-out-0910.google.com ([64.233.182.190]:37734 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751505AbXLNOHP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Dec 2007 09:07:15 -0500
Received: by nf-out-0910.google.com with SMTP id g13so933163nfb.21
        for <git@vger.kernel.org>; Fri, 14 Dec 2007 06:07:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=IVvTKTuQ/x/DWAxQ417UJPwfhPD4P2u5Gmt55JsKZcU=;
        b=F9Wgt/xOvMUZDOWlnWekL5Fs35w+i/ekoC2McW1ZSyouHsU6ReZZhJWeP2qQrP9kVfnHXJ3KYutf14zUbmHNtKQCU1TK4ItUpsUjAuTL/JRUFcJvj8IyD+1s9QtMnf/YQ03Jle4PoG6oUoSkcFtX293h0QiDpEHD3v2gqPmxoU8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=I1h/s92m8+KSa0Zt1uHjoMoiUTaA95PgEpzh9DElqziE0GXbY20i0QVYG2j6t5LYsUaW19Z1l7i0UZic4YDzjv5bN/ej3Id3yWiA4l08sMvc2tqL0uVEOBXMOdsWoloSxZu98TV+YlMpFEoaVpnCHMGXrrwMA84Atk5Bjvv0x4w=
Received: by 10.86.54.3 with SMTP id c3mr3035843fga.40.1197641233300;
        Fri, 14 Dec 2007 06:07:13 -0800 (PST)
Received: from ?192.168.1.11? ( [83.8.223.189])
        by mx.google.com with ESMTPS id 4sm6550fge.2007.12.14.06.07.03
        (version=SSLv3 cipher=OTHER);
        Fri, 14 Dec 2007 06:07:04 -0800 (PST)
User-Agent: KMail/1.9.3
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68307>

The command I used quite often in my StGIT workflow, namely 
"stg refresh -e", which used to refresh patch and launch editor to edit 
commit (patch) description no longer works in Stacked GIT 0.14.1.

I used it when new (refreshed) changes needed also changes in commit 
description (commit message). Now I have to run two commands: 
"stg refresh" and "stg edit".

-- 
Jakub Narebski
Poland
