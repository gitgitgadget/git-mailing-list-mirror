From: Gelonida N <gelonida@gmail.com>
Subject: How to properly rename a repository with submodules
Date: Sun, 20 May 2012 20:19:31 +0200
Message-ID: <jpbcjj$ho$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 20 20:20:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SWAk2-0007mP-Al
	for gcvg-git-2@plane.gmane.org; Sun, 20 May 2012 20:20:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756714Ab2ETSTr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 May 2012 14:19:47 -0400
Received: from plane.gmane.org ([80.91.229.3]:60872 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756651Ab2ETSTq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 May 2012 14:19:46 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1SWAjH-0006Vr-Ch
	for git@vger.kernel.org; Sun, 20 May 2012 20:19:43 +0200
Received: from unicorn.dungeon.de ([81.56.82.123])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 20 May 2012 20:19:43 +0200
Received: from gelonida by unicorn.dungeon.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 20 May 2012 20:19:43 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: unicorn.dungeon.de
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:12.0) Gecko/20120430 Thunderbird/12.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198067>

Hi,

Today I noticed to my surprise, that a repository with submodules 
contains absolute paths.in the .git file of each sub module.

This is kind of surprising to me and seems to make it absolutely 
impossible to have a non bare git repository on a memory stick.

It also seems to make it impossible to rename a working repository after 
cloning.

So I have three questions.

1.) Is there any way to force git to use relative path names, such, that 
this issue just disappears.

2,) Is there any existing script, that allows me to move a git 
repository to another location without breaking it's sub modules.

3.) Why do these path names have to be absolute? Is this for performance 
reasons? path names relative to the location of the .git file seem to be 
much more flexible / portable.


Thanks in advance for your answers
