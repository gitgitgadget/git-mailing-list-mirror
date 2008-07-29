From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Hackontest ideas?
Date: Mon, 28 Jul 2008 22:31:10 -0700
Message-ID: <20080729053110.GD11947@spearce.org>
References: <20080729000103.GH32184@machine.or.cz> <20080729001016.GT32057@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Petr Baudis <pasky@ucw.cz>, git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Tue Jul 29 07:32:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNhoi-0006it-OO
	for gcvg-git-2@gmane.org; Tue, 29 Jul 2008 07:32:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752696AbYG2FbN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jul 2008 01:31:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751860AbYG2FbN
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jul 2008 01:31:13 -0400
Received: from george.spearce.org ([209.20.77.23]:49221 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751160AbYG2FbL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jul 2008 01:31:11 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id C3368383A5; Tue, 29 Jul 2008 05:31:10 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20080729001016.GT32057@genesis.frugalware.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90578>

Miklos Vajna <vmiklos@frugalware.org> wrote:
> On Tue, Jul 29, 2008 at 02:01:03AM +0200, Petr Baudis <pasky@ucw.cz> wrote:
> > 
> > (What feature in Git or a Git-related tool would you implement, given 24
> > hours staight and unlimited pizza supply?)
> 
> Restartable git-clone? :-)
> 
> It was a GSoC idea this year, but in the end nobody started working on
> it.
> 
> (I was about to work on it, but finally my 'builtin-merge' application
> was accepted.)

Yea, we eventually decided it was probably too small for a
GSoC project.  Given how quickly you put together your git-merge
project, I'm actually happy we got you working on git-merge and
not restartable clone, as I think you may have finished restartable
clone in 24 hours and then said "now what mr. mentor?" ;-)


Pasky, et.al.:

How about smart fetch/push over HTTP?  E.g. a CGI (or extension to
gitweb) that does native pack transport over HTTP rather than dumb
object traversal with GET and WebDAV LOCK/PUT.  Note that the push
side doesn't need to support tell-me-more extension, making it a
fairly trivial GET, POST (or PUT) sequence.

-- 
Shawn.
