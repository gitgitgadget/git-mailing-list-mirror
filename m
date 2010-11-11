From: Gelonida <gelonida@gmail.com>
Subject: git clone / git pull to USB memory stick (FAT) and symlinks
Date: Thu, 11 Nov 2010 17:35:17 +0100
Message-ID: <ibh605$adm$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 11 17:35:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PGa7h-0000cl-2v
	for gcvg-git-2@lo.gmane.org; Thu, 11 Nov 2010 17:35:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754238Ab0KKQfg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Nov 2010 11:35:36 -0500
Received: from lo.gmane.org ([80.91.229.12]:39350 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754111Ab0KKQff (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Nov 2010 11:35:35 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1PGa7Z-0000Xz-Ih
	for git@vger.kernel.org; Thu, 11 Nov 2010 17:35:33 +0100
Received: from unicorn.dungeon.de ([81.56.82.123])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 11 Nov 2010 17:35:33 +0100
Received: from gelonida by unicorn.dungeon.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 11 Nov 2010 17:35:33 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: unicorn.dungeon.de
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.15) Gecko/20101027 ""
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161267>

Hi,

For a given project I'd like to have some USB memory sticks, which I'd
like to keep up to date.

I thought about cloning a remote git repository onto the stick
and performing
- regular pulls in order to update the USB stick
- occasional pushes in orderto publish changes performed on the stick.


Now my questions:


1.) Ignore skip / symlinks
-----------------------------
The git repository might contain symlinks (as it was created on a  linux
host)

Is there any way to perform a git clone / pull and just skip any symlink
in the working directory


2.) Avoiding file permission issues: Is this sufficient
---------------------------------------------------------

I read about some config setting which should avoid problems with
the rather limited file permissions on a FAT file system

git config --add core.fileMode false



3.) Any other special config settings
-----------------------------------------
Are there any other special preparations to be done fi I'd like to
have a non bare git repository on a memory stick.


Thanks for your suggestions
