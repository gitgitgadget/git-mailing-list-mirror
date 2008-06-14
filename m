From: Theodore Tso <tytso@mit.edu>
Subject: Re: [PATCH] Added mergetool.kdiff3.doubledash config option
Date: Sat, 14 Jun 2008 02:29:04 -0400
Message-ID: <20080614062904.GB12260@mit.edu>
References: <7vve0ez8z3.fsf@gitster.siamese.dyndns.org> <911589C97062424796D53B625CEC0025E46159@USCOBRMFA-SE-70.northamerica.cexp.com> <20080613145803.GE24675@mit.edu> <7vhcbwilps.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Patrick.Higgins@cexp.com, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 14 08:30:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K7PHE-0003Zt-SV
	for gcvg-git-2@gmane.org; Sat, 14 Jun 2008 08:30:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752083AbYFNG3U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Jun 2008 02:29:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752075AbYFNG3U
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Jun 2008 02:29:20 -0400
Received: from www.church-of-our-saviour.org ([69.25.196.31]:46860 "EHLO
	thunker.thunk.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752037AbYFNG3U (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jun 2008 02:29:20 -0400
Received: from root (helo=closure.thunk.org)
	by thunker.thunk.org with local-esmtp   (Exim 4.50 #1 (Debian))
	id 1K7PG5-0001dc-Kk; Sat, 14 Jun 2008 02:29:05 -0400
Received: from tytso by closure.thunk.org with local (Exim 4.67)
	(envelope-from <tytso@mit.edu>)
	id 1K7PG4-0003IR-4G; Sat, 14 Jun 2008 02:29:04 -0400
Content-Disposition: inline
In-Reply-To: <7vhcbwilps.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@mit.edu
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84964>

On Fri, Jun 13, 2008 at 11:17:51PM -0700, Junio C Hamano wrote:
> The reason I suggested either a cheap runtime check or command line
> override was because you can be accessing the same repository from two
> different machines, with different kdiff3.  If you check once and store
> the result in .gitconfig or .git/config, it would not help the situation a
> bit, would it?

Good point.  I'm not sure 0.5s is really fast enough to be considered
a "cheap runtime check", unfortunately.  At the very least it should
be cached across a single "git mergetool" invocation, though; maybe if
that were the case it would be acceptable.

          					- Ted
