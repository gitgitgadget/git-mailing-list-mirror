From: Mark A Rada <marada@uwaterloo.ca>
Subject: git format-patch glitch?
Date: Thu, 6 Aug 2009 00:55:47 -0400
Message-ID: <ED82D2F5-3E0A-491E-BDD8-3742B769193D@uwaterloo.ca>
Mime-Version: 1.0 (Apple Message framework v935.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 06 06:56:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYv1H-0006tb-1a
	for gcvg-git-2@gmane.org; Thu, 06 Aug 2009 06:56:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751902AbZHFEz4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Aug 2009 00:55:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751595AbZHFEzz
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Aug 2009 00:55:55 -0400
Received: from services10.student.cs.uwaterloo.ca ([129.97.152.18]:40237 "EHLO
	services10.student.cs.uwaterloo.ca" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751461AbZHFEzz (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Aug 2009 00:55:55 -0400
Received: from [192.168.1.102] (CPE0018397ddc22-CM001225dfe86e.cpe.net.cable.rogers.com [174.117.223.147])
	(authenticated bits=0)
	by services10.student.cs.uwaterloo.ca (8.13.8/8.13.8) with ESMTP id n764tqN3008698
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO)
	for <git@vger.kernel.org>; Thu, 6 Aug 2009 00:55:55 -0400 (EDT)
X-Mailer: Apple Mail (2.935.3)
X-Greylist: Sender succeeded SMTP AUTH authentication, not delayed by milter-greylist-3.0 (services10.student.cs.uwaterloo.ca [129.97.152.13]); Thu, 06 Aug 2009 00:55:55 -0400 (EDT)
X-Miltered: at mailchk-w05 with ID 4A7A6258.000 by Joe's j-chkmail (http://j-chkmail.ensmp.fr)!
X-Virus-Scanned: ClamAV version 0.94.2, clamav-milter version 0.94.2 on localhost
X-Virus-Status: Clean
X-UUID: fce5b86a-c256-4054-9cac-a35930a52960
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125040>

I noticed this at the top of every patch that git creates for me:

 From 3c34cfa3987c310e4c3194e06d25a08557f0bdb0 Mon Sep 17 00:00:00 2001

Well, the commit hash is different, but the date is always the same.  
Is this expected
behaviour? It happens for different repositories on different  
computers that use different
versions of git.

--
Mark A Rada (ferrous26)
marada@uwaterloo.ca
