From: David Kastrup <dak@gnu.org>
Subject: Re: [RFC/PATCH] git-fetch: mega-terse fetch output
Date: Fri, 19 Oct 2007 10:19:05 +0200
Message-ID: <864pgncy9y.fsf@lola.quinscape.zz>
References: <20071019062219.GA28499@coredump.intra.peff.net> <ee77f5c20710182339g30d025f0tfe74479d672ae36e@mail.gmail.com> <20071019073938.GN14735@spearce.org> <20071019075725.GA29436@coredump.intra.peff.net> <20071019080755.GO14735@spearce.org>  =?ISO-8859-1?Q?=20<?=
	=?ISO-8859-1?Q?2007101=049081127.?= =?ISO-8859-1?Q?GA30168@coredump?=
	=?ISO-8859-1?Q?.intra.peff.net>?=
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 19 10:32:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IinH4-0000tc-VZ
	for gcvg-git-2@gmane.org; Fri, 19 Oct 2007 10:32:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756912AbXJSIbL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Oct 2007 04:31:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756823AbXJSIbL
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Oct 2007 04:31:11 -0400
Received: from main.gmane.org ([80.91.229.2]:39341 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756376AbXJSIbI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Oct 2007 04:31:08 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Iin4c-00016H-6M
	for git@vger.kernel.org; Fri, 19 Oct 2007 08:19:14 +0000
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 19 Oct 2007 08:19:14 +0000
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 19 Oct 2007 08:19:14 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.50 (gnu/linux)
Cancel-Lock: sha1:joaf23v2hU4LCqE3oPybEPZY3Mw=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61673>

Jeff King <peff@peff.net> writes:

> On Fri, Oct 19, 2007 at 04:07:55AM -0400, Shawn O. Pearce wrote:
>
>> Then you get linewrap on smaller terminals, and bigger ones don't
>> line up the right side.  *shrug*
>
> Bigger ones will line up, just not on the far right side of the
> terminal. I guess we ought to support smaller terminals, though).

I don't see why.  80 columns has been the standard layout for
something like 40 or 50 years or so.  It is the standard punch card
width and required to display Fortran code fitted to this width
(column 73 to 80 are ignored in non-free-format Fortran and used for
line identification).

All people using smaller terminals are used to wrapping trouble.  We
really don't need to go overboard supporting Commodore 64 users with
git.

-- 
David Kastrup
