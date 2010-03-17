From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: git-gui: with themed widgets not all window geometry is restored
Date: Wed, 17 Mar 2010 16:58:28 +0100
Message-ID: <20100317155757.GA12994@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Pat Thoyts <patthoyts@googlemail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 17 16:58:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nrvdk-0005MI-3m
	for gcvg-git-2@lo.gmane.org; Wed, 17 Mar 2010 16:58:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753235Ab0CQP6a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Mar 2010 11:58:30 -0400
Received: from darksea.de ([83.133.111.250]:60272 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753161Ab0CQP6a (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Mar 2010 11:58:30 -0400
Received: (qmail 5045 invoked from network); 17 Mar 2010 16:58:26 +0100
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 17 Mar 2010 16:58:26 +0100
Content-Disposition: inline
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142404>

Hallo,

since c80d7be we use ttk widgets for git gui. With them the position of
the Widget sizes of Unstaged Changes and Stages Changes are not restored
correctly anymore.

If you open git gui, resize the widgets and reopen the gui it will not
restore the previous size. When setting

  git config gui.usettk false

the sizes are kept. I do not know the ttk widgets that well so maybe Pat
can spot the problem quite easily. Otherwise I can have a stab at it but
it will probably take me more time.

cheers Heiko
