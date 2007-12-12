From: Wink Saville <wink@saville.com>
Subject: [egit] How-to use egit
Date: Wed, 12 Dec 2007 11:12:34 -0800
Message-ID: <476032A2.9010308@saville.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 12 20:13:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2X19-0005CE-VX
	for gcvg-git-2@gmane.org; Wed, 12 Dec 2007 20:13:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753710AbXLLTMj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Dec 2007 14:12:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753554AbXLLTMj
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Dec 2007 14:12:39 -0500
Received: from rv-out-0910.google.com ([209.85.198.187]:44054 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750856AbXLLTMi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Dec 2007 14:12:38 -0500
Received: by rv-out-0910.google.com with SMTP id k20so294000rvb.1
        for <git@vger.kernel.org>; Wed, 12 Dec 2007 11:12:38 -0800 (PST)
Received: by 10.141.113.6 with SMTP id q6mr579394rvm.135.1197486757894;
        Wed, 12 Dec 2007 11:12:37 -0800 (PST)
Received: from ?192.168.0.133? ( [70.91.206.233])
        by mx.google.com with ESMTPS id 3sm1199356rvi.2007.12.12.11.12.36
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 12 Dec 2007 11:12:37 -0800 (PST)
User-Agent: Thunderbird 2.0.0.6 (X11/20071022)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68090>

Robin et. al,


I cloned egit from git://repo.or.cz/egit and imported it into my workspace
following the instructions in INSTALL I did successfully compile although
there were 1115 warnings but no compilation errors.

I then exported to a archive org.spearce.egit.jar and then copied this file
to /usr/eclipse/plugin/ I then restarted Eclipse. But I don't see any 
evidence
that I properly installed the plugin. BUT I've never compiled or installed
a plugin by hand before so I may have not done this correctly.

Anyway, I need a small nudge on what to do next or maybe redo what I've
done correctly. Note, currently my entire workspace is in a git repository
and it's config file is:

wink@ic2d1:$ cat .git/config
[core]
        repositoryformatversion = 0
        filemode = true
        bare = false
        logallrefupdates = true
[remote "origin"]
        url = git://192.168.0.8/eclipse-workspace.git
        fetch = +refs/heads/*:refs/remotes/origin/*
[branch "master"]
        remote = origin
        merge = refs/heads/master
[gui]
        geometry = 918x909+633+116 107 218

With the working copy named "workspace".

Cheers,

Wink Saville
