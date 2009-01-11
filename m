From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: current git kernel has strange problems during bisect
Date: Sun, 11 Jan 2009 16:07:59 +0100
Message-ID: <200901111607.59054.borntraeger@de.ibm.com>
References: <200901111602.53082.borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	torvalds@linux-foundation.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 11 16:09:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LM1wM-0006f5-4Y
	for gcvg-git-2@gmane.org; Sun, 11 Jan 2009 16:09:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753786AbZAKPIF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Jan 2009 10:08:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753671AbZAKPID
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Jan 2009 10:08:03 -0500
Received: from mtagate1.uk.ibm.com ([194.196.100.161]:59400 "EHLO
	mtagate1.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753608AbZAKPIB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Jan 2009 10:08:01 -0500
Received: from d06nrmr1407.portsmouth.uk.ibm.com (d06nrmr1407.portsmouth.uk.ibm.com [9.149.38.185])
	by mtagate1.uk.ibm.com (8.13.1/8.13.1) with ESMTP id n0BF80Ib027941;
	Sun, 11 Jan 2009 15:08:00 GMT
Received: from d06av04.portsmouth.uk.ibm.com (d06av04.portsmouth.uk.ibm.com [9.149.37.216])
	by d06nrmr1407.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id n0BF7xbB3199148;
	Sun, 11 Jan 2009 15:07:59 GMT
Received: from d06av04.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av04.portsmouth.uk.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id n0BF7xpv025744;
	Sun, 11 Jan 2009 15:07:59 GMT
Received: from sig-9-145-110-244.uk.ibm.com (sig-9-145-110-244.uk.ibm.com [9.145.110.244])
	by d06av04.portsmouth.uk.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id n0BF7wCb025738
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Sun, 11 Jan 2009 15:07:59 GMT
User-Agent: KMail/1.9.9
In-Reply-To: <200901111602.53082.borntraeger@de.ibm.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105187>

Am Sonntag 11 Januar 2009 schrieb Christian Borntraeger:
> doing a 
> git bisect start
> git bisect good a3a798c
> git bisect bad v2.6.29-rc1
> 
> results in a repository without several files, e.g Makefile!
> git describe also fails.

In fact, retesting with a clean repository shows, that there are only btrfs 
files - nothing else.

Linus did you pull a broken btrfs repository?

Christian
