From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: merge into branch currently not active / checked out
Date: Sun, 17 Jun 2007 11:45:21 +0200
Message-ID: <20070617094521.GA2763@steel.home>
References: <20070617072225.GF23473@cip.informatik.uni-erlangen.de>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Thomas Glanzmann <thomas@glanzmann.de>
X-From: git-owner@vger.kernel.org Sun Jun 17 11:45:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HzrK8-0002iT-H1
	for gcvg-git@gmane.org; Sun, 17 Jun 2007 11:45:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759715AbXFQJp1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Jun 2007 05:45:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759712AbXFQJp0
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Jun 2007 05:45:26 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.188]:41823 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758220AbXFQJpY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jun 2007 05:45:24 -0400
Received: from tigra.home (Fc9d7.f.strato-dslnet.de [195.4.201.215])
	by post.webmailer.de (mrclete mo59) (RZmta 7.3)
	with ESMTP id g01ae0j5H7FD8l ; Sun, 17 Jun 2007 11:45:22 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 09C9B277BD;
	Sun, 17 Jun 2007 11:45:22 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 725BEC164; Sun, 17 Jun 2007 11:45:21 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20070617072225.GF23473@cip.informatik.uni-erlangen.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaFzAcmG5c=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50345>

Thomas Glanzmann, Sun, Jun 17, 2007 09:22:25 +0200:
> Hello,
> is it possible to merge into a branch currently not active/checked out?

not in current implementation of merge algorithms and conflict
handling.

> I want to merge master in every of the feature branches. Is that possible or
> just bullshit because I don't have a working tree to handle conflicts?

You are _very_ welcome to improve this :) It's not very often need, so
people just do without it (i.e. clone the repo, do a merge there and
pull back).
