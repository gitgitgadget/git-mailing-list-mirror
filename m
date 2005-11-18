From: Ismail Donmez <ismail@uludag.org.tr>
Subject: Rss produced by git is not valid xml?
Date: Fri, 18 Nov 2005 18:33:39 +0200
Organization: =?utf-8?q?T=C3=9CB=C4=B0TAK/UEKAE?=
Message-ID: <200511181833.40048.ismail@uludag.org.tr>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri Nov 18 17:37:44 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ed9CE-0000vn-Iq
	for gcvg-git@gmane.org; Fri, 18 Nov 2005 17:34:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964782AbVKRQe1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 Nov 2005 11:34:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964789AbVKRQe1
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Nov 2005 11:34:27 -0500
Received: from ns2.uludag.org.tr ([193.140.100.220]:61155 "EHLO uludag.org.tr")
	by vger.kernel.org with ESMTP id S964782AbVKRQeY (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Nov 2005 11:34:24 -0500
Received: from dsl.dynamic8599158195.ttnet.net.tr (unknown [85.99.158.195])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by uludag.org.tr (Postfix) with ESMTP id C1A85AB3FC
	for <git@vger.kernel.org>; Fri, 18 Nov 2005 18:34:19 +0200 (EET)
To: git@vger.kernel.org
User-Agent: KMail/1.9
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12240>

Hi all,

I am trying to parse git's rss feed and now xml parsers seems to choke on it 
because of an error in the produced feed. Looking at 
http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=rss

line 781 says :

On Thu, 17 Nov 2005, David G\363mez wrote:<br/>

which is part of the commit : 
http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=05b8b0fafd4cac75d205ecd5ad40992e2cc5934d

This looks like malformed xml to me ( because of \363 part ). Is there any way 
to fix this so git rss can be parsed? Or is this legal in xml and parsers are 
buggy? 

Regards,
ismail
