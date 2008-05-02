From: Kevin Ballard <kevin@sb.org>
Subject: To page or not to page
Date: Fri, 2 May 2008 01:41:05 -0400
Message-ID: <70F76C0E-E16D-4047-873D-7FD19FDBB55D@sb.org>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 02 07:41:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jro1u-0001A9-AJ
	for gcvg-git-2@gmane.org; Fri, 02 May 2008 07:41:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755144AbYEBFlK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 May 2008 01:41:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753565AbYEBFlJ
	(ORCPT <rfc822;git-outgoing>); Fri, 2 May 2008 01:41:09 -0400
Received: from sd-green-bigip-145.dreamhost.com ([208.97.132.145]:42750 "EHLO
	randymail-a12.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752795AbYEBFlH (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 2 May 2008 01:41:07 -0400
Received: from [192.168.0.215] (c-24-91-11-245.hsd1.nh.comcast.net [24.91.11.245])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by randymail-a12.g.dreamhost.com (Postfix) with ESMTP id B53D2A8A65
	for <git@vger.kernel.org>; Thu,  1 May 2008 22:41:06 -0700 (PDT)
X-Mailer: Apple Mail (2.919.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80957>

c8af1de9cfa0a5678ae766777e0f905e60b69fda makes git status use a pager.  
I think this is a horrible choice. Now when I type `git status` I have  
to type "q" to get back to my shell, and I've lost the output of the  
pager. It makes sense for commands with long output like `git log`,  
but `git status` rarely has output longer than my terminal's height,  
and so making it use the pager simply detracts from its functionality.

Does anybody have any comments or opinions about this either way?

-Kevin Ballard

-- 
Kevin Ballard
http://kevin.sb.org
kevin@sb.org
http://www.tildesoft.com
