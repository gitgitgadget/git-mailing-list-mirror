From: Sylvain <syllant@gmail.com>
Subject: Re: Git commit error: fatal: Repository has been updated, but unable to write =?utf-8?b?bmV3X2luZGV4?= file.
Date: Tue, 15 May 2012 06:34:31 +0000 (UTC)
Message-ID: <loom.20120515T082415-300@post.gmane.org>
References: <34E530A4-A792-42AC-8C19-5F7CB71FA46C@jetbrains.com> <jks9k9$c35$1@dough.gmane.org> <20120327122045.GA7421@ikke-laptop.buyways.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 15 08:40:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SUBQb-0007HV-Nq
	for gcvg-git-2@plane.gmane.org; Tue, 15 May 2012 08:40:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753558Ab2EOGkH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 May 2012 02:40:07 -0400
Received: from plane.gmane.org ([80.91.229.3]:34654 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752007Ab2EOGkG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 May 2012 02:40:06 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1SUBQS-00079L-Hy
	for git@vger.kernel.org; Tue, 15 May 2012 08:40:04 +0200
Received: from tok69-8-78-224-205-94.fbx.proxad.net ([78.224.205.94])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 15 May 2012 08:40:04 +0200
Received: from syllant by tok69-8-78-224-205-94.fbx.proxad.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 15 May 2012 08:40:04 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 78.224.205.94 (Mozilla/5.0 (Windows NT 6.0) AppleWebKit/536.5 (KHTML, like Gecko) Chrome/19.0.1084.46 Safari/536.5)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197821>

Hi,

I'm also experiencing this issue (msysGit 1.7.10-preview20120409 + TortoiseGit 
1.7.9.0 + Intellij IDEA 11).

Don't you think it could be related to parallel usage of msysGit + TortoiseGit?

I.e. after committing with msysGit (through IDEA or not), TortoiseGit would 
launch a background operation (such as updating index) that would mess with 
msysGit?

Just a guess, I don't know internal behaviour of msysGit/TortoiseGit.

Sylvain
