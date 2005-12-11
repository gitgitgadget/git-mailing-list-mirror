From: Ben Lau <benlau@ust.hk>
Subject: Branches merging by only overwrite files
Date: Sun, 11 Dec 2005 16:30:49 +0800
Message-ID: <439BE3B9.3040308@ust.hk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sun Dec 11 09:32:54 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ElMc1-0001sf-Bc
	for gcvg-git@gmane.org; Sun, 11 Dec 2005 09:31:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751340AbVLKIa6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Dec 2005 03:30:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751343AbVLKIa6
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Dec 2005 03:30:58 -0500
Received: from mx4.ust.hk ([143.89.13.26]:31237 "EHLO mx4.ust.hk")
	by vger.kernel.org with ESMTP id S1751340AbVLKIa6 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 11 Dec 2005 03:30:58 -0500
Received: from [221.125.13.158] ([221.125.13.158])
	(authenticated bits=0)
	by mx4.ust.hk (8.12.11/8.12.11) with ESMTP id jBB8UoQk019304
	for <git@vger.kernel.org>; Sun, 11 Dec 2005 16:30:55 +0800 (HKT)
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
To: Git Mailing List <git@vger.kernel.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13490>

Hi,

    I am looking for a solution to merge two branches but do not perform 
file level merge. Instead, I wish the result file is the copy from any 
one of the branches.

    For example, assumes it has two branches A and B,  some of the files 
are modified in both of them. In this case, `/usr/bin/merge` could not 
be execated, it just have to choose the revision from branch A and 
discards all the changes from B. For the rest of files, it just simply 
choose the newest copy from A or B.

    How can I perform this action?

Thanks in advance.
