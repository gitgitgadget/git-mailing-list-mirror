From: Adam Flott <adam@npjh.com>
Subject: [RFC] git-gui and spell checking
Date: Sat, 2 Feb 2008 12:07:29 -0600 (CST)
Message-ID: <alpine.DEB.1.00.0802021142320.21831@an.sumeria>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Cc: git@vger.kernel.org
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Sat Feb 02 19:09:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLMnU-0006mI-QZ
	for gcvg-git-2@gmane.org; Sat, 02 Feb 2008 19:09:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933831AbYBBSIF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Feb 2008 13:08:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752023AbYBBSID
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Feb 2008 13:08:03 -0500
Received: from npjh.com ([200.46.204.250]:56467 "EHLO npjh.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933831AbYBBSH7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Feb 2008 13:07:59 -0500
Received: from localhost (unknown [200.46.204.182])
	by npjh.com (Postfix) with ESMTP id F38D813517BD;
	Sat,  2 Feb 2008 18:07:57 +0000 (UTC)
Received: from npjh.com ([200.46.204.250])
 by localhost (mx1.hub.org [200.46.204.182]) (amavisd-maia, port 10024)
 with ESMTP id 42332-02; Sat,  2 Feb 2008 14:07:54 -0400 (AST)
Received: from an.sumeria (unknown [70.124.58.159])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by npjh.com (Postfix) with ESMTP id 316DD13517AE;
	Sat,  2 Feb 2008 18:07:55 +0000 (UTC)
X-X-Sender: adam@an.sumeria
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72293>

Shawn,

The other day I committed something with a comment that had a rather
embarrassing misspelling. I had some more commits on top of that and I
was about to dcommit it up to the companies SVN repository before I
caught it. I reset the commits to fix it and all was well.

But it had me thinking about avoiding the problem in the future and how
I handle it in other applications. So far, I think Opera has the best
GUI spell checking[1]. I then went and poked around the git-gui code to
see how hard it would be to learn some minimal Tk in order to implement
such a thing.

[1]: http://npjh.com/etc/opera-spell-check.png

If Tk comes really natural and you could crank this sort of thing out
and have the time to do so, I would really appreciate it. Otherwise I
might take a stab at it. Reading the aspell documentation (what Opera)
uses doesn't seem all that bad about operating with stdout/stdin. I
browsed the web looking for "recipes" for making something very similar
to the Opera spell checker, but I don't think I found any good resources
which explain going from little Tcl/Tk to a workable simple GUI.

Is this some functionality you and/or others would like to see?


Adam
