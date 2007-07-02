From: Yann Dirson <ydirson@altern.org>
Subject: Re: git-rm isn't the inverse action of git-add
Date: Mon, 2 Jul 2007 21:42:37 +0200
Message-ID: <20070702194237.GN7730@nan92-1-81-57-214-146.fbx.proxad.net>
References: <46893F61.5060401@jaeger.mine.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Christian Jaeger <christian@jaeger.mine.nu>
X-From: git-owner@vger.kernel.org Mon Jul 02 21:43:08 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5Rnd-0000ua-PW
	for gcvg-git@gmane.org; Mon, 02 Jul 2007 21:43:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753240AbXGBTm7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 2 Jul 2007 15:42:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753088AbXGBTm7
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Jul 2007 15:42:59 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:49507 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752755AbXGBTm6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jul 2007 15:42:58 -0400
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 14CC85A384;
	Mon,  2 Jul 2007 21:42:56 +0200 (CEST)
Received: by gandelf.nowhere.earth (Postfix, from userid 1000)
	id 5A6001F176; Mon,  2 Jul 2007 21:42:37 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <46893F61.5060401@jaeger.mine.nu>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51395>

On Mon, Jul 02, 2007 at 08:09:37PM +0200, Christian Jaeger wrote:
> Why so complicated? Why not just make git-rm without options behave like
> cg-rm? (Or at the very least, I'd change the hint to say "try -f --cached".)

It is probably a matter of taste.  Personally, I am really upset by
this behaviour that cvs, cogito, stgit and others share, which forces
me to issue 2 commands to really delete a file from version control
and from the filesystem.

Do you really need to undo an add more often than you need to remove a
file from version-control ?  It may be worth, however, to make things
easier.  Maybe "git add --undo foo" would be a solution ?  Not sure
we'd want to add --undo to many git commands, though.  Opinions ?

Best regards,
-- 
Yann
