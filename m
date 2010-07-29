From: Yann Dirson <ydirson@free.fr>
Subject: [BUG] git gui: "unstage line" not working on newly-added file
Date: Thu, 29 Jul 2010 22:53:40 +0200
Message-ID: <20100729205339.GE2864@home.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: GIT list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jul 29 22:48:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oea1T-0006iN-OM
	for gcvg-git-2@lo.gmane.org; Thu, 29 Jul 2010 22:48:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754203Ab0G2UsD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Jul 2010 16:48:03 -0400
Received: from smtp5-g21.free.fr ([212.27.42.5]:60789 "EHLO smtp5-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752952Ab0G2UsA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jul 2010 16:48:00 -0400
Received: from home.lan (unknown [81.57.214.146])
	by smtp5-g21.free.fr (Postfix) with ESMTP id 98504D48144
	for <git@vger.kernel.org>; Thu, 29 Jul 2010 22:47:54 +0200 (CEST)
Received: from yann by home.lan with local (Exim 4.72)
	(envelope-from <ydirson@free.fr>)
	id 1Oea6m-0005da-1m
	for git@vger.kernel.org; Thu, 29 Jul 2010 22:53:40 +0200
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152196>

When looking using git-gui at a file that does not exist in HEAD and
has been added to the index, lines cannot be selectively staged out of
the index.

It would look like outside of the gui such (or similar) behaviour
would be accessible from an interactive mode in reset, but it looks
like we do not have that.

I was able, however, to "add -N" the file and selectively stage the
lines that I wanted using git-gui.
