From: Graeme Geldenhuys <graemeg.lists@gmail.com>
Subject: git-pull doesn't update my refs for remotes/origin/master
Date: Mon, 25 Jul 2011 09:58:54 +0200
Message-ID: <4E2D223E.8090505@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 25 09:59:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QlG4B-0003Tp-Eo
	for gcvg-git-2@lo.gmane.org; Mon, 25 Jul 2011 09:59:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751025Ab1GYH7C (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jul 2011 03:59:02 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:52192 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750776Ab1GYH7B (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jul 2011 03:59:01 -0400
Received: by wyg8 with SMTP id 8so2560457wyg.19
        for <git@vger.kernel.org>; Mon, 25 Jul 2011 00:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        bh=9aMP7SbofsPE4ZmZdZIS/FtRVayTi/IoluvNi+rc93Q=;
        b=VB05vUSZ+uLVioc18IdVogDX7vKI/j+zi0v7vfSelEIlPCb391IXYdXNQH7viDEzsX
         Sd7N2vF8OiPFw8bVzbi8/CXnSutjIh4yDoU7MQzoFgQLvO+KFsgeRON/lNd7zSosIUxa
         hftBeH0gowWoNIo81GeyNP33JHmryEPC+9CwA=
Received: by 10.227.178.135 with SMTP id bm7mr3525997wbb.52.1311580739634;
        Mon, 25 Jul 2011 00:58:59 -0700 (PDT)
Received: from [192.168.0.53] (41-133-134-247.dsl.mweb.co.za [41.133.134.247])
        by mx.google.com with ESMTPS id fc2sm4102213wbb.1.2011.07.25.00.58.56
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 25 Jul 2011 00:58:58 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.18) Gecko/20110617 Thunderbird/3.1.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177784>

Hi,

Any idea why this happens? When I do a 'git pull origin master' while in
the master branch, it fetches all the latest commits, but doesn't update
the 'remotes/origin/master' reference. When I do a 'gitk', the
remotes/origin/master reference is still pointing to the old original
HEAD commit. Only when I do a 'git push origin master', does it update
the remotes/origin/master references?

I'm using git version 1.7.0.4 as is include with Ubuntu 10.04

Here is my .git/config file:

----8<-------------8<-------------8<-------------8<-------------8<----
[core]
	repositoryformatversion = 0
	filemode = true
	bare = false
	logallrefupdates = true
	safecrlf = true
[remote "origin"]
	url = ssh://graemeg@fpgui.git.sourceforge.net/gitroot/fpgui/fpgui
	fetch = +refs/heads/*:refs/remotes/origin/*
[branch "master"]
	remote = origin
	merge = refs/heads/master
[gui]
	geometry = 1182x686+1573+97 387 428
	wmstate = normal
[push]
	default = current
[remote "usb"]
	url = /media/flash16gig/git_repos/fpgui.git
	fetch = +refs/heads/*:refs/remotes/usb/*
[branch "v0.4_fixes"]
	remote = origin
	merge = refs/heads/v0.4_fixes
[remote "github"]
	url = git@github.com:graemeg/fpGUI.git
	fetch = +refs/heads/*:refs/remotes/github/*
----8<-------------8<-------------8<-------------8<-------------8<----


Regards,
  - Graeme -

-- 
fpGUI Toolkit - a cross-platform GUI toolkit using Free Pascal
http://fpgui.sourceforge.net/
