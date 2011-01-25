From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: Git repo on a machine with zero commits is ahead of remote by
 103 commits.. !
Date: Tue, 25 Jan 2011 08:22:10 +0100
Message-ID: <4D3E7A22.7090008@viscovery.net>
References: <AANLkTikj06sjTbNd8afk9cY2=_Hy+kT+J1NCjR-fKP5J@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Srirang Doddihal <om.brahmana@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 25 08:22:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PhdEK-0001h8-DY
	for gcvg-git-2@lo.gmane.org; Tue, 25 Jan 2011 08:22:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751866Ab1AYHWP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Jan 2011 02:22:15 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:54614 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751523Ab1AYHWO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Jan 2011 02:22:14 -0500
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1PhdEA-00086k-IZ; Tue, 25 Jan 2011 08:22:11 +0100
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 4CF531660F;
	Tue, 25 Jan 2011 08:22:10 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
In-Reply-To: <AANLkTikj06sjTbNd8afk9cY2=_Hy+kT+J1NCjR-fKP5J@mail.gmail.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165469>

Am 1/25/2011 6:48, schrieb Srirang Doddihal:
> I am using a simple git based deployment for my rails app and here is
> my setup and current status:
> 
> 1) Git repo initialized on my local development machine with a sample file.
> 2) Pushed to remote repo on Github.com
> 3) Subsequent pushes and pulls made from local development machine
> 4) Repository cloned on the deployed machine
> 5) Subsequent pulls made from the deployed machine (but no commits or
> pushes are made on this machine)
> 
> Now when I run "git status" on the deployed machine it says :
> 
> # On branch master
> # Your branch is ahead of 'origin/master' by 103 commits.
> 
> git pull origin master -- says it is Already up to date

This 'git pull' is very explicit. I.e., you specify the remote and the
branch; in this case, no remote-tracking branches, like origin/master, are
updated.

Since you cloned the repository (I assume without any special options),
you already have a configuration such that you can use this shorter command:

   git pull

to merge origin's master into your local master. As a side-effect, it also
updates origin/master.

-- Hannes
