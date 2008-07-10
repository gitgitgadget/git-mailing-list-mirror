From: "Asankha C. Perera" <asankha@wso2.com>
Subject: Errors importing Apache Synapse SVN using Git
Date: Thu, 10 Jul 2008 17:31:39 +0530
Message-ID: <4875FA23.30603@wso2.com>
References: <4875F5D6.9080906@wso2.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 10 14:02:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGurI-0003qH-GS
	for gcvg-git-2@gmane.org; Thu, 10 Jul 2008 14:02:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752289AbYGJMBl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jul 2008 08:01:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753351AbYGJMBl
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Jul 2008 08:01:41 -0400
Received: from relay02.pair.com ([209.68.5.16]:3523 "HELO relay02.pair.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751482AbYGJMBk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jul 2008 08:01:40 -0400
Received: (qmail 21693 invoked from network); 10 Jul 2008 12:01:39 -0000
Received: from unknown (HELO ?10.100.1.92?) (unknown)
  by unknown with SMTP; 10 Jul 2008 12:01:39 -0000
X-pair-Authenticated: 222.165.132.170
User-Agent: Thunderbird 2.0.0.12 (X11/20080227)
In-Reply-To: <4875F5D6.9080906@wso2.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87970>

Hi All

I am an Apache Synapse developer, and want to import the Synapse SVN 
repo into Git, so that Ohloh can properly get the Synapse history 
(http://www.ohloh.net/topics/1326?page=1#post_6287)

However, when I try the command: "git svn clone --trunk=trunk 
--tags=tags --branches=branches http://svn.apache.org/repos/asf/synapse" 
it seems to take forever, (or at least until the next network glitch), 
and keeps filling up a file with just plain zeros ("0") : 
./.git/svn/trunk/.rev_db.13f79535-47bb-0310-9956-ffa450edef68

Can someone try the above command on the Synapse repo and tell me what I 
can do to import from the SVN?

many thanks
asankha
