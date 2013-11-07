From: Karsten Blees <karsten.blees@gmail.com>
Subject: [PATCH 0/2] Improve gitignore documentation wrt excluded directories
Date: Thu, 07 Nov 2013 17:30:05 +0100
Message-ID: <527BC00D.8000501@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>,
	Karsten Blees <karsten.blees@gmail.com>
To: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 07 17:30:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VeSTA-0002Yx-UI
	for gcvg-git-2@plane.gmane.org; Thu, 07 Nov 2013 17:30:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754451Ab3KGQaF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Nov 2013 11:30:05 -0500
Received: from mail-ea0-f182.google.com ([209.85.215.182]:62990 "EHLO
	mail-ea0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752216Ab3KGQaD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Nov 2013 11:30:03 -0500
Received: by mail-ea0-f182.google.com with SMTP id o10so467241eaj.13
        for <git@vger.kernel.org>; Thu, 07 Nov 2013 08:30:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :content-type:content-transfer-encoding;
        bh=vOW5vTkQceQ8/KeJOihT30jBaf6vYWoDZytJ+Ap/ipQ=;
        b=dCKSbtFBocdE8PNoPNVdtkn0+/tWQKLty+aV1Cbsya1f0fkASXi8RDJ0izjv6fFE7C
         msbWwdN04v7u4AxxqhNdCO905m8ZmMspJrbZ6QraEmdP84IaYodNXnaXgzbJ3MY9DB18
         dutuw6Q/0aU5ZqfVNy8ne9WSj3y/AUwgAeoMC0nz9a9Q7qGdO0eFXlLes9s5+KLS4JrY
         V6qjYoQEEFK99l1jovV5NDnJS612u0LcITWDCt4i4b0B9MC/CRKXZjj3EW0ia0FOa/GV
         zUYzJ17CZwUf4jpYFOQJaGE/AGOHwLh3cxUp8GjP/Lpo59k6pmVw7yL/MUFgDRrD1Ncz
         GzdA==
X-Received: by 10.15.98.9 with SMTP id bi9mr10167018eeb.67.1383841802262;
        Thu, 07 Nov 2013 08:30:02 -0800 (PST)
Received: from [10.1.100.55] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id x4sm11135755eef.1.2013.11.07.08.30.00
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 07 Nov 2013 08:30:01 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237414>

Also here:
https://github.com/kblees/git/commits/kb/gitignore-doc

These two patches were the result of a discussion mid-october [1] that I almost forgot about...now including an example as suggested by Jeff.

[1] http://thread.gmane.org/gmane.comp.version-control.git/235753/focus=235856

Karsten Blees (2):
  gitignore.txt: fix documentation of "**" patterns
  gitignore.txt: clarify recursive nature of excluded directories

 Documentation/gitignore.txt | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

-- 
1.8.4.msysgit.0.12.g88f5ed0
