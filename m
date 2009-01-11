From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: current git kernel has strange problems during bisect
Date: Sun, 11 Jan 2009 16:02:53 +0100
Message-ID: <200901111602.53082.borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 11 16:06:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LM1sZ-0005HW-Ov
	for gcvg-git-2@gmane.org; Sun, 11 Jan 2009 16:05:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752187AbZAKPEJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Jan 2009 10:04:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751474AbZAKPEJ
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Jan 2009 10:04:09 -0500
Received: from mtagate5.uk.ibm.com ([195.212.29.138]:63027 "EHLO
	mtagate5.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750825AbZAKPEG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Jan 2009 10:04:06 -0500
Received: from d06nrmr1407.portsmouth.uk.ibm.com (d06nrmr1407.portsmouth.uk.ibm.com [9.149.38.185])
	by mtagate5.uk.ibm.com (8.13.8/8.13.8) with ESMTP id n0BF2rdx530096;
	Sun, 11 Jan 2009 15:02:53 GMT
Received: from d06av03.portsmouth.uk.ibm.com (d06av03.portsmouth.uk.ibm.com [9.149.37.213])
	by d06nrmr1407.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id n0BF2rE0696448;
	Sun, 11 Jan 2009 15:02:53 GMT
Received: from d06av03.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av03.portsmouth.uk.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id n0BF2rRS018073;
	Sun, 11 Jan 2009 15:02:53 GMT
Received: from sig-9-145-110-244.uk.ibm.com (sig-9-145-110-244.uk.ibm.com [9.145.110.244])
	by d06av03.portsmouth.uk.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id n0BF2qBA018041
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Sun, 11 Jan 2009 15:02:53 GMT
User-Agent: KMail/1.9.9
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105186>

doing a 
git bisect start
git bisect good a3a798c
git bisect bad v2.6.29-rc1

results in a repository without several files, e.g Makefile!
git describe also fails.

Any ideas how to fix this problem to continue with my bisect?

Christian
