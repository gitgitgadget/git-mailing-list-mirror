From: Matthew Clemence <matthew.clemence@virgin.net>
Subject: Suggested workflow for frequent directory renames.
Date: Tue, 26 May 2009 01:17:48 +0100
Message-ID: <4A1B352C.9030409@virgin.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 26 02:39:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M8khC-0004qX-2L
	for gcvg-git-2@gmane.org; Tue, 26 May 2009 02:39:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752465AbZEZAi6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 May 2009 20:38:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752516AbZEZAi6
	(ORCPT <rfc822;git-outgoing>); Mon, 25 May 2009 20:38:58 -0400
Received: from smtprelay-virgin0153.hostedemail.com ([64.99.136.153]:42038
	"EHLO smtprelay-virgin.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751857AbZEZAi5 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 May 2009 20:38:57 -0400
X-Greylist: delayed 1262 seconds by postgrey-1.27 at vger.kernel.org; Mon, 25 May 2009 20:38:57 EDT
Received: from smtprelay-virgin.hostedemail.com (ff-bigip1 [10.5.19.254])
	by smtpgrave07.hostedemail.com (Postfix) with ESMTP id B03032E346D
	for <git@vger.kernel.org>; Tue, 26 May 2009 00:19:02 +0000 (UTC)
Received: from filter.hostedemail.com (ff-bigip1 [10.5.19.254])
	by smtprelay05.hostedemail.com (Postfix) with SMTP id AEA0B1A670C
	for <git@vger.kernel.org>; Tue, 26 May 2009 00:17:55 +0000 (UTC)
X-Spam-Summary: 2,0,0,d0572914cbbf58b6,96158787c8943071,matthew.clemence@virgin.net,git@vger.kernel.org,RULES_HIT:355:379:854:945:969:988:989:1187:1260:1261:1277:1311:1313:1314:1345:1437:1515:1516:1518:1534:1540:1593:1594:1711:1730:1747:1766:1792:2194:2199:2393:2559:2562:2828:3352:3622:3740:3865:3866:3867:3868:3869:3871:3874:3876:3877:5007:6114:7652:7875:8501:9108,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:none,DNSBL:none
X-Session-Marker: 6D6174746865772E636C656D656E6365
X-Filterd-Recvd-Size: 1609
Received: from [192.168.2.2] (client-86-27-120-160.hers.adsl.virgin.net [86.27.120.160])
	(Authenticated sender: matthew.clemence)
	by omf11.hostedemail.com (Postfix) with ESMTP
	for <git@vger.kernel.org>; Tue, 26 May 2009 00:17:55 +0000 (UTC)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119989>

Dear git users,

I am working with an externally supplied code tree (some 2000 files, 
which gets passed to me without any SCM) and have multiple users wokring 
on their own individual branched versions under git control. The problem 
I am facing is that there are frequenct directory renames when the code 
updates which I need to find a relatively painless way of bringing the 
users branches up to date. From reading the lists and faq, there seems 
to be problems (and strong opinions) with this, and I am struggling to 
find an effcient model to manage this merging - either git loses track 
of the users changed files (and so have to be manually merged from diff 
files and usually lose history) or git loses track of everything else 
(and I end up manually adding files from the new tree to get out of 
merge conflict).

I would be very interested to hear if anyone has a suggestion on how 
this could best be handled.

Many thanks

Matthew
