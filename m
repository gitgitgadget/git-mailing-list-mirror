From: Matthias Fechner <idefix@fechner.net>
Subject: Update Webservers from a remote repository
Date: Tue, 21 Sep 2010 11:02:51 +0200
Message-ID: <4C9874BB.5060908@fechner.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 21 11:31:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OxzBp-0006F3-Jr
	for gcvg-git-2@lo.gmane.org; Tue, 21 Sep 2010 11:31:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756692Ab0IUJaj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Sep 2010 05:30:39 -0400
Received: from anny.lostinspace.de ([80.190.182.2]:63775 "EHLO
	anny.lostinspace.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751980Ab0IUJai (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Sep 2010 05:30:38 -0400
X-Greylist: delayed 1637 seconds by postgrey-1.27 at vger.kernel.org; Tue, 21 Sep 2010 05:30:38 EDT
Received: from server.idefix.lan (host-188-174-193-180.customer.m-online.net [188.174.193.180])
	(authenticated bits=0)
	by anny.lostinspace.de (8.14.4/8.14.4) with ESMTP id o8L93En8004514
	for <git@vger.kernel.org>; Tue, 21 Sep 2010 11:03:18 +0200 (CEST)
	(envelope-from idefix@fechner.net)
Received: from server.idefix.lan (localhost [127.0.0.1])
	by server.idefix.lan (Postfix) with ESMTP id E9AE5660D
	for <git@vger.kernel.org>; Tue, 21 Sep 2010 11:03:13 +0200 (CEST)
X-Virus-Scanned: amavisd-new at server.idefix.lan
Received: from server.idefix.lan ([127.0.0.1])
	by server.idefix.lan (server.idefix.lan [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nujq4PdkNrqS for <git@vger.kernel.org>;
	Tue, 21 Sep 2010 11:02:53 +0200 (CEST)
Received: from dhcp-10-27-1-64.internal.epo.org (unknown [192.168.20.6])
	(using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
	(No client certificate requested)
	by server.idefix.lan (Postfix) with ESMTPSA
	for <git@vger.kernel.org>; Tue, 21 Sep 2010 11:02:52 +0200 (CEST)
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; de; rv:1.9.2.8) Gecko/20100802 Thunderbird/3.1.2
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.2.6 (anny.lostinspace.de [80.190.182.2]); Tue, 21 Sep 2010 11:03:18 +0200 (CEST)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,UNPARSEABLE_RELAY
	autolearn=ham version=3.3.1
X-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on anny.lostinspace.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156701>

Dear list,

I'm new to git but the more I use it I more I like/love it. :)

I have a central --bare git repository which is the master for all web 
servers (I did a git clone http://xxx on each web server).
If I now push changes from my devel station to the central repository I 
would like to have them available on all server with a script.

If I understood everything correctly I execute the following commands on 
each server:
git checkout master (to be sure we are on branch master)
git fetch (to fetch changes from the central repository)
git merge origin (to update the repo to the changes on the central repo)

I use here origin because the remote name for the central server in the 
.git/config file is named origin.

Is that correct or did I missed something?

Thanks,
Matthias

-- 
"Programming today is a race between software engineers striving to 
build bigger and better idiot-proof programs, and the universe trying to 
produce bigger and better idiots. So far, the universe is winning." -- 
Rich Cook
