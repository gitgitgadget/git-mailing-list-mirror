From: Rakotomandimby Mihamina <mihamina@gulfsat.mg>
Subject: change URL
Date: Fri, 27 Nov 2009 12:56:35 +0300
Message-ID: <4B0FA253.6060804@gulfsat.mg>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 27 11:07:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDxjD-0007NJ-4c
	for gcvg-git-2@lo.gmane.org; Fri, 27 Nov 2009 11:07:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754257AbZK0KGv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Nov 2009 05:06:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754158AbZK0KGv
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Nov 2009 05:06:51 -0500
Received: from smtp-out.malagasy.com ([41.204.120.134]:51083 "EHLO
	smtp-out.malagasy.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753237AbZK0KGu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Nov 2009 05:06:50 -0500
X-Greylist: delayed 608 seconds by postgrey-1.27 at vger.kernel.org; Fri, 27 Nov 2009 05:06:50 EST
Received: from camel.malagasy.com (camel.malagasy.com [41.204.104.34])
	by smtp-out.malagasy.com (Postfix) with ESMTP id 666578C2D7
	for <git@vger.kernel.org>; Fri, 27 Nov 2009 13:00:04 +0300 (EAT)
Received: from localhost (static-104-53.blueline.mg [41.204.104.53])
	by camel.malagasy.com (Postfix) with ESMTP id 72587FEB2
	for <git@vger.kernel.org>; Fri, 27 Nov 2009 12:56:43 +0300 (EAT)
X-Virus-Scanned: par antivirus2.malagasy.com
X-Spam-Flag: NO
X-Spam-Score: -2.684
X-Spam-Level: 
X-Spam-Status: No, score=-2.684 required=7 tests=[AWL=-0.085, BAYES_00=-2.599]
Received: from camel.malagasy.com ([41.204.104.34])
	by localhost (antivirus2.malagasy.com [41.204.104.53]) (amavisd-new, port 10024)
	with ESMTP id K6TkzHZ5CIYo for <git@vger.kernel.org>;
	Fri, 27 Nov 2009 12:56:37 +0300 (EAT)
Received: from rktmb (sysadmin-cnc.malagasy.com [41.204.104.9])
	by camel.malagasy.com (Postfix) with ESMTP id D8400FE97
	for <git@vger.kernel.org>; Fri, 27 Nov 2009 12:56:34 +0300 (EAT)
Received: from localhost ([127.0.0.1])
	by rktmb with esmtp (Exim 4.69)
	(envelope-from <mihamina@gulfsat.mg>)
	id 1NDxZ5-0003yp-GM
	for git@vger.kernel.org; Fri, 27 Nov 2009 12:56:35 +0300
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.6pre) Gecko/20091125 Shredder/3.0.1pre
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133887>

Hi all,
When I first cloned a project, I used the non fully qualified hostname
if the repo:
   $ git clone ssh://git/git/Mailaka

When pushing, it was OK:
   $ git push
   mihamina@git's password:
   Counting objects: 7, done.
   Compressing objects: 100% (4/4), done.
   Writing objects: 100% (4/4), 825 bytes, done.
   Total 4 (delta 3), reused 0 (delta 0)
   To ssh://git/git/Mailaka
      1e91a44..8af5c57  master -> master

Now, I am on a slow network, with a different search domain in resolv.conf.

What should I edit to make "git push" uses "git.rktmb.org" rather than "git.domainsearch-in-resolv.conf"?

-- 
       Architecte Informatique chez Blueline/Gulfsat:
    Administration Systeme, Recherche & Developpement
                                    +261 33 11 207 36
