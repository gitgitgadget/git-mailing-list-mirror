From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: Two crazy proposals for changing git's diff commands
Date: Sat, 11 Feb 2006 22:15:27 -0500
Message-ID: <20060212031527.GA31228@fieldses.org>
References: <87slqtcr2f.wl%cworth@cworth.org> <7vfymtl43b.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Carl Worth <cworth@cworth.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 12 04:15:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F87i1-0006K4-Eu
	for gcvg-git@gmane.org; Sun, 12 Feb 2006 04:15:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932116AbWBLDPb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 11 Feb 2006 22:15:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932194AbWBLDPa
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Feb 2006 22:15:30 -0500
Received: from mail.fieldses.org ([66.93.2.214]:8074 "EHLO pickle.fieldses.org")
	by vger.kernel.org with ESMTP id S932116AbWBLDPa (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 11 Feb 2006 22:15:30 -0500
Received: from bfields by pickle.fieldses.org with local (Exim 4.60)
	(envelope-from <bfields@fieldses.org>)
	id 1F87hv-0000qz-N5; Sat, 11 Feb 2006 22:15:27 -0500
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vfymtl43b.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15976>

On Wed, Feb 08, 2006 at 05:21:12PM -0800, Junio C Hamano wrote:
> Of course, learning various flags to give "git diff" is part of
> understanding the index

Well, there's understanding the index, and then there's memorizing the
flags.  I would've thought it'd be a lot easier to remember something
like

git diff HEAD INDEX
git diff INDEX WORK
git diff HEAD WORK

than, respectively,

git diff --cached
git diff
git diff HEAD

But maybe that's just me.  (And maybe the namespace in question is
already to crowded to allow for INDEX and WORK.)

--b.
