From: Yann Dirson <ydirson@altern.org>
Subject: [StGIT RFC] Changing patch@branch syntax
Date: Wed, 16 May 2007 00:03:10 +0200
Message-ID: <20070515220310.GJ16903@nan92-1-81-57-214-146.fbx.proxad.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: GIT list <git@vger.kernel.org>,
	Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 16 00:04:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ho58E-0006DS-2R
	for gcvg-git@gmane.org; Wed, 16 May 2007 00:04:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756145AbXEOWE3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 May 2007 18:04:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756153AbXEOWE3
	(ORCPT <rfc822;git-outgoing>); Tue, 15 May 2007 18:04:29 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:39118 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756145AbXEOWE2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 May 2007 18:04:28 -0400
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id A75375EFB9;
	Wed, 16 May 2007 00:04:27 +0200 (CEST)
Received: by gandelf.nowhere.earth (Postfix, from userid 1000)
	id 6A43B1F161; Wed, 16 May 2007 00:03:10 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47379>

The patch@branch syntax is annoying, at least for bash-completion
purposes: we don't want to provide all possible completions accross
all branches, yet we'd like to get completion for foreign patches.

Another place where I feel it is bad is when using the full
"patch@branch//top" syntax: the MSB is in the middle, and the LSB is
on the right.

Both issues would be solved by switching to a MSB ordering, with a way
to distinguish branchnames when given.  Something similar to pathnames
would fit well - eg. [/branchname/]patchname[//top].  However, I'm not
sure using slashes would be a good choice, precisely because of the
similarity with real pathnames.  But we don't have so many separator
chars that are not special in one way or another, and would require
quoting them to avoid more user confusion.

What do you think ?
-- 
Yann.
