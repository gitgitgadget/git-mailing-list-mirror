From: Thomas Glanzmann <thomas@glanzmann.de>
Subject: Re: [PATCH] Don't rely on unspecified behavior
Date: Sat, 28 Jul 2007 21:34:02 +0200
Message-ID: <20070728193402.GE23337@cip.informatik.uni-erlangen.de>
References: <20070728173948.GD23337@cip.informatik.uni-erlangen.de> <11856471952272-git-send-email-tschwinge@gnu.org> <Pine.LNX.4.64.0707282028130.14781@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Jul 28 21:34:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IEs3E-000151-Iw
	for gcvg-git@gmane.org; Sat, 28 Jul 2007 21:34:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753052AbXG1TeF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 28 Jul 2007 15:34:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752266AbXG1TeE
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Jul 2007 15:34:04 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:44559 "EHLO
	faui03.informatik.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752463AbXG1TeD (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 28 Jul 2007 15:34:03 -0400
Received: by faui03.informatik.uni-erlangen.de (Postfix, from userid 31401)
	id CC7A43F428; Sat, 28 Jul 2007 21:34:02 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0707282028130.14781@racer.site>
User-Agent: Mutt/1.5.15 (2007-05-02)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54052>

Hello Dscho,

> Isn't this the same patch as you sent before?

> > @@ -74,7 +74,7 @@ static void fill_directory(struct dir_struct *dir, const char **pathspec)
> > @@ -60,7 +60,7 @@ static void fill_directory(struct dir_struct *dir, const char **pathspec,
       ~~~~~ ~~~~~                                                                            ~

The offset of the diff has changed. Not that git couldn't sort it out by
itself. And the function had one or more parameters less.

	Thomas
