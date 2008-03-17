From: Eyvind Bernhardsen <eyvind-git@orakel.ntnu.no>
Subject: "commit"s without "from" in fast-import
Date: Mon, 17 Mar 2008 23:10:07 +0100
Message-ID: <F6F70627-FAE7-43F1-BECC-E70A4A561982@orakel.ntnu.no>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Mar 17 23:11:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JbNY2-0002Os-B4
	for gcvg-git-2@gmane.org; Mon, 17 Mar 2008 23:11:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752184AbYCQWKL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Mar 2008 18:10:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752727AbYCQWKL
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Mar 2008 18:10:11 -0400
Received: from 97.84-49-228.nextgentel.com ([84.49.228.97]:55477 "EHLO
	eyvind.bernhardsens.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751946AbYCQWKK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Mar 2008 18:10:10 -0400
Received: from vredefort.d.eyvind.bernhardsens.net (vredefort.d.eyvind.bernhardsens.net [172.16.3.223])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by eyvind.bernhardsens.net (Postfix) with ESMTP id DFE3714458D;
	Mon, 17 Mar 2008 23:10:07 +0100 (CET)
X-Mailer: Apple Mail (2.919.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77466>

Hi,

I have a question about fast-import, specifically a (possibly)  
unorthodox usage of it by cvs2svn.  Cvs2svn generates "commit"s with  
no "from" commands; instead, it emits a "merge" from the previous  
commit on the branch, and then rebuilds the entire state of the tree.

I've verified that the generated repositories are correct, so I know  
that it works, and I _think_ that it's equivalent to having "from  
<mark>" followed by "filedeleteall".

What I'm wondering is: is there any reason to modify cvs2svn's output  
to comply more to the man page's way of doing things, or is this a  
perfectly valid usage?
-- 
Eyvind Bernhardsen
