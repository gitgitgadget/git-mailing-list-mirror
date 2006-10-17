From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: VCS comparison table
Date: Tue, 17 Oct 2006 14:52:25 -0400
Message-ID: <20061017185225.GE2867@fieldses.org>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com> <egr3ud$nqm$1@sea.gmane.org> <45340713.6000707@utoronto.ca> <Pine.LNX.4.63.0610170128350.14200@wbgn013.biozentrum.uni-wuerzburg.de> <4534656B.7080105@utoronto.ca> <7v64ejqx3a.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Aaron Bentley <aaron.bentley@utoronto.ca>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 17 20:53:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZu3Y-00013L-Nh
	for gcvg-git@gmane.org; Tue, 17 Oct 2006 20:52:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751429AbWJQSwe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Oct 2006 14:52:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751427AbWJQSwe
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Oct 2006 14:52:34 -0400
Received: from mail.fieldses.org ([66.93.2.214]:30189 "EHLO
	pickle.fieldses.org") by vger.kernel.org with ESMTP
	id S1751425AbWJQSwc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Oct 2006 14:52:32 -0400
Received: from bfields by pickle.fieldses.org with local (Exim 4.63)
	(envelope-from <bfields@fieldses.org>)
	id 1GZu37-0003fG-Ux; Tue, 17 Oct 2006 14:52:25 -0400
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7v64ejqx3a.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29103>

On Mon, Oct 16, 2006 at 11:23:53PM -0700, Junio C Hamano wrote:
> Aaron Bentley <aaron.bentley@utoronto.ca> writes:
> 
> > Johannes Schindelin wrote:
> >
> >>> You'll note we referred to that bevhavior on the page.  We don't think
> >>> what Git does is the same as supporting renames.  AIUI, some Git users
> >>> feel the same way.
> >> 
> >> Oh, we start another flamewar again?
> >
> > I'd hope not.  It sounds as though you feel that supporting renames in
> > the data representation is *wrong*, and therefore it should be an insult
> > to you if we said that Git fully supported renames.
> 
> Not recording and not supporting are quite different things.

Yes.  There's a risk of confusing a feature with an implementation
detail.  From http://bazaar-vcs.org/RcsComparisons:

	"If a user can rename a file in the RCS without loosing the RCS
	history for a file, then renames are considered supported. If
	the operation resultes in a delete/add (aka "DA pair"), then
	renames are not considered supported. If the operation results
	in a copy/delete pair, renames are considered "somewhat"
	supported. The problem with copy support is that it is hard to
	define sane merge semantics for copies."

The first sentence sounds like a description of a user-visible feature.
The rest of it sounds like implementation.

And git probably has some deficiencies here, but it'd be more useful to
identify them in terms of things a user can't do.

--b.
