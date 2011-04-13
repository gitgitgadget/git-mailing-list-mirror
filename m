From: Matej Batic <matej.batic@ge.infn.it>
Subject: using aliases within the subdirectory
Date: Wed, 13 Apr 2011 12:24:10 +0200
Message-ID: <4DA579CA.5030908@ge.infn.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 13 13:26:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q9yDc-0005Df-MG
	for gcvg-git-2@lo.gmane.org; Wed, 13 Apr 2011 13:26:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758446Ab1DML0j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Apr 2011 07:26:39 -0400
Received: from dns2.ge.infn.it ([193.206.144.11]:52873 "EHLO dns2.ge.infn.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757464Ab1DML0j (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Apr 2011 07:26:39 -0400
X-Greylist: delayed 3743 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Apr 2011 07:26:38 EDT
Received: from smtp1.ge.infn.it (smtp1.ge.infn.it [193.206.144.39])
	by dns2.ge.infn.it (8.13.8/8.13.8) with ESMTP id p3DAOD61000633
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Wed, 13 Apr 2011 12:24:14 +0200
Received: from [193.206.144.226] (pcgeant08.ge.infn.it [193.206.144.226])
	(authenticated bits=0)
	by smtp1.ge.infn.it (8.13.8/8.13.8) with ESMTP id p3DAOAE5000706
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Wed, 13 Apr 2011 12:24:13 +0200
User-Agent: Thunderbird 2.0.0.24 (X11/20110322)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (dns2.ge.infn.it [193.206.144.11]); Wed, 13 Apr 2011 12:24:14 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171443>

Dear all,

I am facing a problem, noted previously in
    
http://git.661346.n2.nabble.com/git-alias-always-chdir-to-top-td1609456.html  

    http://kerneltrap.org/mailarchive/git/2010/5/5/29818/thread
which in practice means that I cannot pass the " -- 
relative_path_to_some_file_in_the_tree" argument to my alias.

Is there any way to get the current working dir before git changes dir 
to root directory?

Best regards,
Matej
