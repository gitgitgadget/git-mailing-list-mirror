From: Yann Dirson <ydirson@altern.org>
Subject: Handling of 'git-config foo=bar'
Date: Sun, 4 Feb 2007 12:33:50 +0100
Message-ID: <20070204113350.GN5362@nan92-1-81-57-214-146.fbx.proxad.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: GIT list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Feb 04 12:35:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HDfeA-0001Be-Ig
	for gcvg-git@gmane.org; Sun, 04 Feb 2007 12:35:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752294AbXBDLet (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 4 Feb 2007 06:34:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752300AbXBDLet
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Feb 2007 06:34:49 -0500
Received: from smtp8-g19.free.fr ([212.27.42.65]:53326 "EHLO smtp8-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752286AbXBDLet (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Feb 2007 06:34:49 -0500
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp8-g19.free.fr (Postfix) with ESMTP id 8748C5548
	for <git@vger.kernel.org>; Sun,  4 Feb 2007 12:34:47 +0100 (CET)
Received: by gandelf.nowhere.earth (Postfix, from userid 1000)
	id 92CB01F080; Sun,  4 Feb 2007 12:33:50 +0100 (CET)
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38688>

Currently, running "git-config foo=bar", ie. presumably an erroneous
attempt at setting "foo", indeed queries "foo=bar", so outputs nothing
and reports success.

Do we want to allow "=" signs in config var names ?  It would seem
reasonable to refuse them, and report an error to the innocent user
(OK, i'm not that innocent, but still ;)

Or does that sound a bad idea to anyone ?

Best regards,
-- 
Yann.
