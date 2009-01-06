From: "Tobin Harris" <tobin@tobinharris.com>
Subject: Fwd: error: Unable to append to logs/refs/heads/master:
Date: Tue, 6 Jan 2009 09:44:47 +0000
Message-ID: <9a081f0e0901060144v23883c99x7735f62785ffffa0@mail.gmail.com>
References: <9a081f0e0901060138g7cd3d92cvc061b7abf6ad6df7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 06 10:46:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LK8Vn-0005bo-P0
	for gcvg-git-2@gmane.org; Tue, 06 Jan 2009 10:46:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751559AbZAFJos (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jan 2009 04:44:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751226AbZAFJos
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Jan 2009 04:44:48 -0500
Received: from rv-out-0506.google.com ([209.85.198.239]:24160 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751126AbZAFJor (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jan 2009 04:44:47 -0500
Received: by rv-out-0506.google.com with SMTP id k40so7270874rvb.1
        for <git@vger.kernel.org>; Tue, 06 Jan 2009 01:44:47 -0800 (PST)
Received: by 10.141.5.17 with SMTP id h17mr10858988rvi.165.1231235087553;
        Tue, 06 Jan 2009 01:44:47 -0800 (PST)
Received: by 10.141.210.7 with HTTP; Tue, 6 Jan 2009 01:44:47 -0800 (PST)
In-Reply-To: <9a081f0e0901060138g7cd3d92cvc061b7abf6ad6df7@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104673>

Hi folks

I'm experiencing a weird error that I can't seem to get around...

$ git push
Counting objects: 67, done.
Compressing objects: 100% (39/39), done.
Writing objects: 100% (43/43), 6.20 KiB, done.
Total 43 (delta 33), reused 0 (delta 0)
Unpacking objects: 100% (43/43), done.
error: Unable to append to logs/refs/heads/master: Invalid argument
To /z/RemoteGit/Zcms.git
 ! [remote rejected] master -> master (failed to write)
error: failed to push some refs to '/z/RemoteGit/Zcms.git'

This usually works fine, so I'm not sure what's happend.

My config looks like this

[core]
        repositoryformatversion = 0
        filemode = false
        bare = false
        logallrefupdates = true
        symlinks = false
        ignorecase = true
[remote "origin"]
        url = /z/RemoteGit/Zcms.git
        fetch = +refs/heads/*:refs/remotes/origin/*
[branch "master"]
        remote = origin
        merge = refs/heads/master

Notes: Using with Cygwin + Windows XP, bare repos is on a network
drive.

Any help appreciated.

Tobin
