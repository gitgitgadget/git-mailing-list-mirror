From: Vibin Nair <vibin@volitionlabs.com>
Subject: Git clone - head not pointing to master
Date: Fri, 30 Dec 2011 16:52:57 +0530
Message-ID: <4EFD9F11.5030309@volitionlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 30 12:23:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RgaYI-0000lB-4v
	for gcvg-git-2@lo.gmane.org; Fri, 30 Dec 2011 12:23:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752606Ab1L3LXE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Dec 2011 06:23:04 -0500
Received: from mail-tul01m020-f174.google.com ([209.85.214.174]:35220 "EHLO
	mail-tul01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751852Ab1L3LXC (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 30 Dec 2011 06:23:02 -0500
Received: by obcwo16 with SMTP id wo16so10041149obc.19
        for <git@vger.kernel.org>; Fri, 30 Dec 2011 03:23:02 -0800 (PST)
Received: by 10.50.160.199 with SMTP id xm7mr45769714igb.24.1325244182097;
        Fri, 30 Dec 2011 03:23:02 -0800 (PST)
Received: from [192.168.1.7] ([122.170.80.208])
        by mx.google.com with ESMTPS id j3sm126579179ibj.1.2011.12.30.03.22.59
        (version=SSLv3 cipher=OTHER);
        Fri, 30 Dec 2011 03:23:01 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:7.0.1) Gecko/20110929 Thunderbird/7.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187799>

Hi,
  I am a Git beginner. Recently i started working on a codebase (that is 
checked in to a git repository) of our client, who is not very aware 
about how git works.
The repository has multiple branches such as

origin/user1
origin/master
origin/user2

Now when i take a clone of this repository : git clone <repo-url>, a 
clone of the repo is created on my machine.

But when i do a : "git branch" it shows

user1 *

which means that the "head" is pointing to the "user1" branch.

The client told me that all the recent code were being merged into the 
"master" branch and hence the "user1" branch has code which is older 
than "master" branch.

I had 2 queries :

1. Is it possible to make the "head" of the remote point to "master" 
instead of "user1", so that other members of my team get the latest code 
when they try to clone the repository.
2. Is there any way to safely merge "user1" to "master".
