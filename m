From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [RFC] best way to show diff of commit
Date: Sun, 25 Nov 2007 21:27:48 +0000
Message-ID: <20071125212748.GB23820@fieldses.org>
References: <20071125211831.GA21121@artemis.corp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Pierre Habouzit <madcoder@debian.org>, Git ML <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Nov 25 22:28:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IwP1L-00073V-QB
	for gcvg-git-2@gmane.org; Sun, 25 Nov 2007 22:28:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753252AbXKYV1u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Nov 2007 16:27:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753247AbXKYV1t
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Nov 2007 16:27:49 -0500
Received: from mail.fieldses.org ([66.93.2.214]:43106 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753218AbXKYV1t (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Nov 2007 16:27:49 -0500
Received: from bfields by fieldses.org with local (Exim 4.68)
	(envelope-from <bfields@fieldses.org>)
	id 1IwP12-0007N0-Bf; Sun, 25 Nov 2007 21:27:48 +0000
Content-Disposition: inline
In-Reply-To: <20071125211831.GA21121@artemis.corp>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66006>

On Sun, Nov 25, 2007 at 10:18:31PM +0100, Pierre Habouzit wrote:
>   There is specific script I run in my vim with git, that tries to show
> from the 'status' git commit shows in the buffer which list of files has
> changed, and builds a diff from it quite clumsily[0].
> 
>   I wonder how hard it would be for git commit to "stash" the current
> commit being sent somewhere editors would be able to have a look at (an
> alternate index is probably fine). Note that maybe I'm stupid and
> overlooked that such a thing already exists.  I'd like to have it in two
> flavors: normal and amend mode. normal mode would show what the
> resulting commit diff looks like, and the amend mode only shows the
> incrementall diff the amend adds to the previous commit.
> 
>   My question is: what do you think is the best way to do that, and
> where ?

Have you checked whether "git-commit -v" already does what you want?

--b.
