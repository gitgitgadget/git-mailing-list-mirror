From: Vaclav Hanzl <hanzl@noel.feld.cvut.cz>
Subject: Re: [PATCH] Documentation: Note about the meaning of "clone"
Date: Sun, 15 Jun 2008 18:31:50 +0200 (CEST)
Message-ID: <20080615.183150.74717434.hanzl@noel.feld.cvut.cz>
References: <m3od63ozuf.fsf@localhost.localdomain>
	<200806151505.27686.robin.rosenberg.lists@dewire.com>
	<D6D7C2A1-C755-4564-AB85-B893FA3000D0@wincent.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: robin.rosenberg.lists@dewire.com, jnareb@gmail.com,
	git@vger.kernel.org, gitster@pobox.com
To: win@wincent.com
X-From: git-owner@vger.kernel.org Sun Jun 15 18:38:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K7vF3-0002I6-Jp
	for gcvg-git-2@gmane.org; Sun, 15 Jun 2008 18:38:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759150AbYFOQhN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Jun 2008 12:37:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758443AbYFOQhM
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Jun 2008 12:37:12 -0400
Received: from magi4.feld.cvut.cz ([147.32.198.214]:36093 "EHLO mepi"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1758379AbYFOQhL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jun 2008 12:37:11 -0400
Received: from localhost (localhost [127.0.0.1])
	by mepi (Postfix) with ESMTP id 16FFBFD806;
	Sun, 15 Jun 2008 18:31:50 +0200 (CEST)
In-Reply-To: <D6D7C2A1-C755-4564-AB85-B893FA3000D0@wincent.com>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85099>

> You might also want to mention that the clone is not necessarily a  
> redundant _copy_ of the original repo, because at least for local  
> clones on the same file system clone will use hard links rather than  
> actually making a copy, unless you explicitly tell it not to.

At the moment this is covered in description of the --local option
(I personally found it very easy to get this knowledge, dislike other
differences from 1:1)

Vaclav
