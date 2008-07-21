From: Jonathan Biolaz <jonathan.biolaz@sikatizen.com>
Subject: error: hook declined to update refs/heads/master
Date: Mon, 21 Jul 2008 11:34:53 +0200
Message-ID: <80F1AC38-8A10-4184-BBFB-870399DE9A3A@sikatizen.com>
Mime-Version: 1.0 (Apple Message framework v928.1)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 21 11:42:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKrug-000594-Gn
	for gcvg-git-2@gmane.org; Mon, 21 Jul 2008 11:42:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755449AbYGUJlj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jul 2008 05:41:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755353AbYGUJli
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jul 2008 05:41:38 -0400
Received: from 42.mail-out.ovh.net ([213.251.189.42]:43142 "HELO
	42.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754169AbYGUJli (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jul 2008 05:41:38 -0400
X-Greylist: delayed 397 seconds by postgrey-1.27 at vger.kernel.org; Mon, 21 Jul 2008 05:41:37 EDT
Received: (qmail 28250 invoked by uid 503); 21 Jul 2008 09:34:44 -0000
Received: from gw2.ovh.net (HELO mail22.ha.ovh.net) (213.251.189.202)
  by 42.mail-out.ovh.net with SMTP; 21 Jul 2008 09:34:43 -0000
Received: from b0.ovh.net (HELO queue-out) (213.186.33.50)
	by b0.ovh.net with SMTP; 21 Jul 2008 09:34:48 -0000
Received: from cust.static.84-253-35-196.cybernet.ch (HELO migiwork.sikalab) (jonathan.biolaz@sikatizen.com@84.253.35.196)
  by ns0.ovh.net with SMTP; 21 Jul 2008 09:34:46 -0000
X-Mailer: Apple Mail (2.928.1)
X-Ovh-Tracer-Id: 6356267924504945118
X-Ovh-Remote: 84.253.35.196 (cust.static.84-253-35-196.cybernet.ch)
X-Ovh-Local: 213.186.33.20 (ns0.ovh.net)
X-Spam-Check: DONE|H 0.5/N
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89328>

Hye,

I'm trying to make a remote repository on a Mac Osx Server leopard.
I tried many methods to create the remote. First one, I clone my local  
repository with the --bare options, then copy this repo on the server  
and add the remote to my local repository, Second one, I create an  
empty bare repository on the server and then I try to push my local  
repository on it.

Everything I'm doing is given my the same error when I try to push to  
the server :

$ git push origin master

Counting objects: 1709, done.
Compressing objects: 100% (1523/1523), done.
Writing objects: 100% (1709/1709), 1.95 MiB | 3818 KiB/s, done.
Total 1709 (delta 535), reused 0 (delta 0)
*** Project description file hasn't been set
error: hooks/update exited with error code 1
error: hook declined to update refs/heads/master
To jbiolaz@macpro1.sikalab:/mp1_data/sikatizen/Dev/repo/calame.git
  ! [remote rejected] master -> master (hook declined)
error: failed to push some refs to 'jbiolaz@macpro1.sikalab:/mp1_data/ 
sikatizen/Dev/repo/calame.git'

I made the same on a linux server ad it's working well (but with  
another repository)

I don't know what to do to make this working.
Also, my server Leopard server is driving me crazy, I have to had for  
every user a .bashrc which one contain the path to git. I don't find a  
way to add this for all user !

I hope someone can help me !!

Thanks !!

Jbiolaz
