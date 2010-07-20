From: Ivan Uemlianin <ivan@llaisdy.com>
Subject: unpack failed --- is my repos broken?
Date: Tue, 20 Jul 2010 14:42:29 +0100
Message-ID: <4C45A7C5.1050601@llaisdy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 20 16:11:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ObDXc-0001nV-3i
	for gcvg-git-2@lo.gmane.org; Tue, 20 Jul 2010 16:11:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758350Ab0GTOLP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Jul 2010 10:11:15 -0400
Received: from mail.ukfsn.org ([77.75.108.10]:60698 "EHLO mail.ukfsn.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758316Ab0GTOLM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jul 2010 10:11:12 -0400
X-Greylist: delayed 1721 seconds by postgrey-1.27 at vger.kernel.org; Tue, 20 Jul 2010 10:11:12 EDT
Received: from localhost (smtp-filter.ukfsn.org [192.168.54.205])
	by mail.ukfsn.org (Postfix) with ESMTP id 30A5BDF354
	for <git@vger.kernel.org>; Tue, 20 Jul 2010 14:42:30 +0100 (BST)
Received: from mail.ukfsn.org ([192.168.54.25])
	by localhost (smtp-filter.ukfsn.org [192.168.54.205]) (amavisd-new, port 10024)
	with ESMTP id zoHq1dSnxD4Y for <git@vger.kernel.org>;
	Tue, 20 Jul 2010 14:42:30 +0100 (BST)
Received: from ivan-uemlianins-macbook-pro.local (unknown [217.33.230.66])
	by mail.ukfsn.org (Postfix) with ESMTP id 0366BDEEB8
	for <git@vger.kernel.org>; Tue, 20 Jul 2010 14:42:29 +0100 (BST)
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; en-GB; rv:1.9.1.10) Gecko/20100512 Thunderbird/3.0.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151313>

Dear All

I have several git repositories on a server, with which I'm 
communicating using smart-http.  Push and pull is all going fine.  Until 
this morning, one of the repositories is not allowing pushes:

     $ git push
     Password: ...
     Counting objects: 5, done.
     Delta compression using up to 2 threads.
     Compressing objects: 100% (3/3), done.
     Writing objects: 100% (3/3), 410 bytes, done.
     Total 3 (delta 2), reused 0 (delta 0)
     error: unpack failed: unpack-objects abnormal exit

Other repositories on the same server (and under the same /var/www/git/ 
directory) are working fine.

I have googled around and this doesn't seem to be an uncommon problem, 
but I haven't found a solution.

Does the above mean this repository is broken and I should rescue or 
replace it (as in "How to fix a broken repository?" on the git wiki [1])?

Is smart-http not entirely reliable?  In which case what is the 
preferred way to communicate remotely (we need to push as well as pull; 
there are a very small number of active developers)?

With thanks and best wishes

Ivan


[1] How to fix a broken repository?
     
http://git.wiki.kernel.org/index.php/GitFaq#How_to_fix_a_broken_repository.3F


-- 
============================================================
Ivan A. Uemlianin
Speech Technology Research and Development

                     ivan@llaisdy.com
                      www.llaisdy.com
                          llaisdy.wordpress.com
                      www.linkedin.com/in/ivanuemlianin

     "Froh, froh! Wie seine Sonnen, seine Sonnen fliegen"
                      (Schiller, Beethoven)
============================================================
