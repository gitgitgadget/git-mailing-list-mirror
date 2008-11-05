From: Steve Walker <steve@idibu.com>
Subject: Question: 'git pull' hangs on local machine
Date: Wed, 5 Nov 2008 22:49:12 +0100
Message-ID: <C520D4F3-1B6B-4049-911E-F1D82209A7B4@idibu.com>
Mime-Version: 1.0 (Apple Message framework v929.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 05 22:50:36 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KxqGm-000202-UT
	for gcvg-git-2@gmane.org; Wed, 05 Nov 2008 22:50:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752111AbYKEVtS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Nov 2008 16:49:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751866AbYKEVtS
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Nov 2008 16:49:18 -0500
Received: from moutng.kundenserver.de ([212.227.126.186]:54448 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751265AbYKEVtS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Nov 2008 16:49:18 -0500
Received: from [192.168.5.3] (161.Red-83-33-229.dynamicIP.rima-tde.net [83.33.229.161])
	by mrelayeu.kundenserver.de (node=mrelayeu6) with ESMTP (Nemesis)
	id 0ML29c-1KxqFX1CkP-0005Bw; Wed, 05 Nov 2008 22:49:15 +0100
X-Mailer: Apple Mail (2.929.2)
X-Provags-ID: V01U2FsdGVkX194wp+kllRHp+vLbe5h8Ub3zH/N0crJvrZsExX
 BzhInG3LKOPvCVKQYkjWzD18C47WJ3BF5PuVqC4obgRHE+X6Wy
 2VeMx5TPB71zqMKQfATdF6MBM1UpQWt
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100186>

Hi there,

We have git on our server - I can pull between repo's no problem on  
the server. I've also cloned a repo on my local box to dev on. The  
clone has worked perfectly.

The problem occurs when I try to do a 'git pull' to update my local  
repo with updates we've made on the server, i see this:

StevePoota:public_html steve$ git pull
remote: Counting objects: 89, done.
remote: Compressing objects: 100% (63/63), done.
Unpacking objects: 35% (24/67)

It hangs on the unpacking objects stage. I tried pulling from  
different repo, but got the same issue.

I've done some test updates on the server repo's in case they were  
corrupt but they seem to be ok...

Has anyone got any ideas how to fix this?

Kind regards, Steve
