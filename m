From: Kevin Ballard <kevin@sb.org>
Subject: Git aliases executed from wrong dir
Date: Wed, 25 Jun 2008 16:44:49 -0700
Message-ID: <9777229F-27FD-4CB2-A5C7-6CA15733B8D2@sb.org>
Mime-Version: 1.0 (Apple Message framework v924)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jun 26 01:45:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBegO-00040c-6x
	for gcvg-git-2@gmane.org; Thu, 26 Jun 2008 01:45:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754203AbYFYXow (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jun 2008 19:44:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754028AbYFYXov
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jun 2008 19:44:51 -0400
Received: from sd-green-bigip-66.dreamhost.com ([208.97.132.66]:41784 "EHLO
	randymail-a12.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751358AbYFYXov (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 Jun 2008 19:44:51 -0400
Received: from [10.100.18.129] (dsl092-049-214.sfo4.dsl.speakeasy.net [66.92.49.214])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by randymail-a12.g.dreamhost.com (Postfix) with ESMTP id AAE39A885D
	for <git@vger.kernel.org>; Wed, 25 Jun 2008 16:44:50 -0700 (PDT)
X-Mailer: Apple Mail (2.924)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86375>

If I create an alias with `git config alias.foo '!pwd'` and then run  
it from a subdirectory of my repo, it prints out the root of my repo.  
This prevents the ability to create aliases that take filenames, as  
they simply won't work if you try and reference a file from a  
subdirectory.

-- 
Kevin Ballard
http://kevin.sb.org
kevin@sb.org
http://www.tildesoft.com
