From: Bahadir Balban <bahadir@l4dev.org>
Subject: git repack memory limit
Date: Wed, 19 May 2010 01:10:13 +0300
Message-ID: <4BF31045.1000700@l4dev.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 19 00:43:31 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OEVVa-000635-Dj
	for gcvg-git-2@lo.gmane.org; Wed, 19 May 2010 00:43:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756134Ab0ERWnZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 May 2010 18:43:25 -0400
Received: from 17.254.223.67.in-addr.arpa ([67.223.254.17]:45809 "EHLO
	l4dev.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754493Ab0ERWnY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 May 2010 18:43:24 -0400
X-Greylist: delayed 1972 seconds by postgrey-1.27 at vger.kernel.org; Tue, 18 May 2010 18:43:24 EDT
Received: from [192.168.2.2] (unknown [78.172.81.157])
	by l4dev.org (Postfix) with ESMTP id C438F36E12C2
	for <git@vger.kernel.org>; Tue, 18 May 2010 23:10:25 +0100 (BST)
User-Agent: Thunderbird 2.0.0.24 (X11/20100411)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147311>

I am running git-repack on a server with memory limits. I am seeing the
repack spending 400MB and going out of memory. I could not limit repack
memory usage in anyway. I tried:

git config pack.deltaCacheLimit 1
git config pack.deltaCacheSize 1
git config pack.windowMemory 32m

then git repack -a -f -d

also I would particularly expect git repack -a -f -d --window-memory=16
to succeed.

Using git 1.6.5. Any thoughts?

-- 
Bahadir
