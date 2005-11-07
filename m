From: Marco Roeland <marco.roeland@xs4all.nl>
Subject: Re: expat.h missing
Date: Mon, 7 Nov 2005 09:24:46 +0100
Message-ID: <20051107082446.GB2678@fiberbit.xs4all.nl>
References: <200511062139.15622.ivo.alxneit@psi.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Nov 07 09:25:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EZ2JW-0007UA-6i
	for gcvg-git@gmane.org; Mon, 07 Nov 2005 09:25:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751315AbVKGIYs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 7 Nov 2005 03:24:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751316AbVKGIYs
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Nov 2005 03:24:48 -0500
Received: from fiberbit.xs4all.nl ([213.84.224.214]:56759 "EHLO
	fiberbit.xs4all.nl") by vger.kernel.org with ESMTP id S1751315AbVKGIYs
	(ORCPT <rfc822;git@vger.kernel.org>); Mon, 7 Nov 2005 03:24:48 -0500
Received: from marco by fiberbit.xs4all.nl with local (Exim 4.54)
	id 1EZ2J4-0000jC-F7; Mon, 07 Nov 2005 09:24:46 +0100
To: alxneit <ivo.alxneit@psi.ch>
Content-Disposition: inline
In-Reply-To: <200511062139.15622.ivo.alxneit@psi.ch>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11258>

On Sunday November 6th 2005 at 21:39 uur alxneit wrote:

> Nick Hengevelds patch to add support for pushing to a remote repository using 
> HTTP/DAV (58e60dd203362ecb9fdea765dcc2eb573892dbaf)
> introduces "#include expat.h" in http-push.c. this file seems to be missing.

Expat is a standard package for reading XML files, it is not part of git
itself. You have to install the expat development kit package of your
distribution to get its headers installed, or alternatively set
"NO_EXPAT" before compilation.
-- 
Marco Roeland
