From: Juan P <juandavid1707@gmail.com>
Subject: Re: inotify support, nearly there
Date: Mon, 21 Jul 2014 05:10:53 +0000 (UTC)
Message-ID: <loom.20140721T070730-175@post.gmane.org>
References: <CACsJy8CG5QUqYOM46mOHOWDKB-A45B2-fj1uS9OtgniV+P8Ktg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 21 07:20:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X961E-00043G-If
	for gcvg-git-2@plane.gmane.org; Mon, 21 Jul 2014 07:20:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752756AbaGUFUH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jul 2014 01:20:07 -0400
Received: from plane.gmane.org ([80.91.229.3]:36578 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751144AbaGUFUF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jul 2014 01:20:05 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1X9615-0003wl-KO
	for git@vger.kernel.org; Mon, 21 Jul 2014 07:20:04 +0200
Received: from Dynamic-IP-1868710538.cable.net.co ([Dynamic-IP-1868710538.cable.net.co])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 21 Jul 2014 07:20:03 +0200
Received: from juandavid1707 by Dynamic-IP-1868710538.cable.net.co with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 21 Jul 2014 07:20:03 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 186.87.105.38 (Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/36.0.1985.125 Safari/537.36)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253942>

Duy Nguyen <pclouds <at> gmail.com> writes:

> 
> Just a quick update for the enthusiasts. My branch file-watcher [1]
> has got working per-user inotify support. It's a 20 patch series so
> I'll refrain from spamming git <at> vger for a while, even though it hurts
> your eyes a lot less than what I have posted so far. The test suite
> ran fine with it so it's not that buggy. It has new tests too, even
> though real inotify is not tested in the new tests. Documentation is
> there, either in .txt or comments. Using it is simple:
> 
> $ mkdir ~/.watcher
> $ git file-watcher --detach ~/.watcher
> $ git config --global filewatcher.path $HOME/.watcher
> 

Will this mean that Git would work faster with repositories with large 
number of files or commits? I am new into this topic, but I am trying to 
understand, any pointers are appreciated.
