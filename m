From: Ben Lau <benlau@ust.hk>
Subject: How to restore the original head after `git-reset --hard master^`
Date: Tue, 11 Oct 2005 23:12:26 +0800
Message-ID: <434BD65A.9000108@ust.hk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Oct 11 17:18:44 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EPLrh-0008UB-AM
	for gcvg-git@gmane.org; Tue, 11 Oct 2005 17:16:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932160AbVJKPOy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 11 Oct 2005 11:14:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932126AbVJKPNG
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Oct 2005 11:13:06 -0400
Received: from mx3.ust.hk ([143.89.13.11]:46605 "EHLO mx3.ust.hk")
	by vger.kernel.org with ESMTP id S1751330AbVJKPMl (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Oct 2005 11:12:41 -0400
Received: from [221.125.13.158] ([221.125.13.158])
	(authenticated bits=0)
	by mx3.ust.hk (8.12.11/8.12.11) with ESMTP id j9BFCQ2b063529
	for <git@vger.kernel.org>; Tue, 11 Oct 2005 23:12:29 +0800 (HKT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.7) Gecko/20050420 Debian/1.7.7-2
X-Accept-Language: en, zh-tw, zh-cn
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9970>

Hi all,

   After involves the command `git-reset --hard master^` in a 
repository, the working
tree , current head and index are restored to the parent of master. That 
includes
the content of '.git/refs/head/master'. Although the original commit 
object is still existed
, I couldn't find it back.

  Is there anyway to recover the original master branch ? or I have to 
restore the branch
manually by finding out all the child of current head? If that is the 
solution , what command
could provide this information?

Thanks
