From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: git-diff on touched files: bug or feature?
Date: Thu, 2 Aug 2007 13:58:38 -0400
Message-ID: <20070802175838.GA31885@fieldses.org>
References: <7v4pjj5fp6.fsf@assigned-by-dhcp.cox.net> <vpqhcni47ek.fsf@bauges.imag.fr> <Pine.LNX.4.64.0708021050500.14781@racer.site> <vpqbqdq45ua.fsf@bauges.imag.fr> <Pine.LNX.4.64.0708021147110.14781@racer.site> <AF1190E2-A0F4-479F-B0A1-50B2C7278995@yahoo.ca> <Pine.LNX.4.64.0708021541520.14781@racer.site> <46B1F3F4.5030504@midwinter.com> <Pine.LNX.4.64.0708021614420.14781@racer.site> <vpqtzrivt2n.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Steven Grimm <koreth@midwinter.com>,
	=?utf-8?Q?Jean-Fran=C3=A7ois?= Veillette 
	<jean_francois_veillette@yahoo.ca>,
	Junio C Hamano <g
X-From: git-owner@vger.kernel.org Thu Aug 02 19:59:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGewx-0005mr-7F
	for gcvg-git@gmane.org; Thu, 02 Aug 2007 19:59:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753771AbXHBR65 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Aug 2007 13:58:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752604AbXHBR65
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Aug 2007 13:58:57 -0400
Received: from mail.fieldses.org ([66.93.2.214]:37108 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751449AbXHBR64 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Aug 2007 13:58:56 -0400
Received: from bfields by fieldses.org with local (Exim 4.67)
	(envelope-from <bfields@fieldses.org>)
	id 1IGewY-0000CY-Bo; Thu, 02 Aug 2007 13:58:38 -0400
Content-Disposition: inline
In-Reply-To: <vpqtzrivt2n.fsf@bauges.imag.fr>
User-Agent: Mutt/1.5.16 (2007-06-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54578>

On Thu, Aug 02, 2007 at 05:45:20PM +0200, Matthieu Moy wrote:
> Depending on the kind of things I'm doing, I usually run status
> regularly, because it's short to read, and it shows me both staged and
> unstaged changes.  git-status tells me if I did something obviously
> totally wrong (changing a file on which I was not working, deleting
> something important ...), and after that, git-diff gives me a
> finer-grained vision of what I did.

Yeah, ditto for me.  When I return to a project after having been away a
few minutes, the first things I do are

	git branch	# remind me which topic I was working on
	git status	# remind me if I was in the middle of something.

So I end up running it a lot.  I only do a git-diff if I need some
details.

--b.
