From: Ivan Uemlianin <ivan@llaisdy.com>
Subject: A sudden lack of permission
Date: Mon, 27 Sep 2010 15:52:52 +0100
Message-ID: <4CA0AFC4.1060001@llaisdy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Sep 27 17:15:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0FQb-0008T5-Ql
	for gcvg-git-2@lo.gmane.org; Mon, 27 Sep 2010 17:15:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933133Ab0I0PPO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Sep 2010 11:15:14 -0400
Received: from mail.ukfsn.org ([77.75.108.10]:48189 "EHLO mail.ukfsn.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759553Ab0I0PPN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Sep 2010 11:15:13 -0400
X-Greylist: delayed 1339 seconds by postgrey-1.27 at vger.kernel.org; Mon, 27 Sep 2010 11:15:13 EDT
Received: from localhost (smtp-filter.ukfsn.org [192.168.54.205])
	by mail.ukfsn.org (Postfix) with ESMTP id 62BE0DEC06
	for <git@vger.kernel.org>; Mon, 27 Sep 2010 15:52:53 +0100 (BST)
Received: from mail.ukfsn.org ([192.168.54.25])
	by localhost (smtp-filter.ukfsn.org [192.168.54.205]) (amavisd-new, port 10024)
	with ESMTP id nlwgDMBTlaIe for <git@vger.kernel.org>;
	Mon, 27 Sep 2010 15:52:53 +0100 (BST)
Received: from ivan-uemlianins-macbook-pro.local (unknown [217.33.230.66])
	by mail.ukfsn.org (Postfix) with ESMTP id 1A846DEBA3
	for <git@vger.kernel.org>; Mon, 27 Sep 2010 15:52:52 +0100 (BST)
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; en-GB; rv:1.9.2.9) Gecko/20100915 Thunderbird/3.1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157338>

  Dear All

I have been using git quite happily for a good while, pushing to my 
remote.  Suddenly this afternoon the remote told me I didn't have 
permission:

     $ git push
     ivan@remote.org's password:
     Counting objects: 19, done.
     Delta compression using up to 2 threads.
     Compressing objects: 100% (11/11), done.
     Writing objects: 100% (11/11), 1.04 KiB, done.
     Total 11 (delta 8), reused 0 (delta 0)
     error: insufficient permission for adding an object to repository 
database ./objects

     fatal: failed to write object
     error: unpack failed: unpack-objects abnormal exit
     To ivan@remote.org:/var/www/git/my_repos.git
      ! [remote rejected] master -> master (n/a (unpacker error))
     error: failed to push some refs to 
'ivan@remote.org:/var/www/git/my_repos.git'

I had sufficient permission even this morning!

Please could someone tell me what might have happened and, more 
importantly, how I can start pushing to the remote again?  The project 
in my_repos is large, so I'd rather not start a new repos from scratch.

With thanks and best wishes

Ivan

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
