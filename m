From: Graeme Geldenhuys <graemeg@gmail.com>
Subject: Correct way of making existing remote repository "bare"
Date: Wed, 15 Jul 2009 14:20:38 +0200
Message-ID: <h3khis$3tq$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 15 14:22:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MR3Ur-00024T-2g
	for gcvg-git-2@gmane.org; Wed, 15 Jul 2009 14:22:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754577AbZGOMVN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jul 2009 08:21:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754576AbZGOMVM
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Jul 2009 08:21:12 -0400
Received: from main.gmane.org ([80.91.229.2]:51588 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753922AbZGOMU6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jul 2009 08:20:58 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1MR3Tl-0004Rb-3o
	for git@vger.kernel.org; Wed, 15 Jul 2009 12:20:57 +0000
Received: from 41.177.101.200 ([41.177.101.200])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 15 Jul 2009 12:20:57 +0000
Received: from graemeg by 41.177.101.200 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 15 Jul 2009 12:20:57 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 41.177.101.200
User-Agent: Thunderbird 2.0.0.22 (X11/20090608)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123303>

Hi,

Yesterday I initialized a new repository on our server. I did some 
coding locally, added the remote server (git remote add ....) and then 
pushed my changes to the remote server.

But I noticed that my remote server is not a "bare" repository and git 
complains when I push to it again. What is the correct way to make an 
existing remote repository bare?

This is what I did and it worked, but not sure if this is the correct 
way of doing it.

Steps I done:

* ssh to remote server
* git clone --bare -l <path_to_repos> <new_dir>
* renamed old repository directory
* renamed new repository dir to what old repository used to be.

Like I said, this did the tick, but is this the correct way of doing it?


Regards,
   - Graeme -

-- 
fpGUI Toolkit - a cross-platform GUI toolkit using Free Pascal
http://opensoft.homeip.net/fpgui/
