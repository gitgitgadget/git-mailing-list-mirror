From: David Kastrup <dak@gnu.org>
Subject: Re: [RFC] Convert builin-mailinfo.c to use The Better String Library.
Date: Tue, 25 Sep 2007 21:55:31 +0200
Message-ID: <86wsue34gc.fsf@lola.quinscape.zz>
References: <46DDC500.5000606@etek.chalmers.se> <1189004090.20311.12.camel@hinata.boston.redhat.com> <vpq642pkoln.fsf@bauges.imag.fr> <4AFD7EAD1AAC4E54A416BA3F6E6A9E52@ntdev.corp.microsoft.com>  =?ISO-8859-1?Q?=20<?=
	=?ISO-8859-1?Q?alpine.LFD.0.999?= =?ISO-8859-1?Q?.0709061839510.5?=
	=?ISO-8859-1?Q?626@evo.linux-fo?= =?ISO-8859-1?Q?undation.or=04g>?= <loom.20070924T134013-959@post.gmane.org> <86odfstbc6.fsf@lola.quinscape.zz> <fdbmve$8lj$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 25 21:56:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IaGWN-0006m5-IB
	for gcvg-git-2@gmane.org; Tue, 25 Sep 2007 21:56:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754732AbXIYT4E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Sep 2007 15:56:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753804AbXIYT4B
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Sep 2007 15:56:01 -0400
Received: from main.gmane.org ([80.91.229.2]:41730 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752095AbXIYT4A (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Sep 2007 15:56:00 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IaGVT-0006XM-44
	for git@vger.kernel.org; Tue, 25 Sep 2007 19:55:44 +0000
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 25 Sep 2007 19:55:43 +0000
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 25 Sep 2007 19:55:43 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.50 (gnu/linux)
Cancel-Lock: sha1:VR/H7L5p9F1zwn38YOnJmWkC3lY=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59165>

"Steven Burns" <royalstream@hotmail.com> writes:

> The C++ community in general suffers a lot from the NIH Syndrome.
> Matrixes, Strings, Vectors, everybody creates their own which are always, or 
> course, superior to what's already available.
>
> Again, is not the language's fault, a language is just a language.
> It's the way it has been driven.

Having loose wires instead of a brake pedal in a car because the user
might prefer to brake with his teeth or by wiggling his backside or
building any other contraption of his own invention is a design
mistake.  Especially when we are talking about public transportation
with changing drivers.

Making a language huge and bloated in order to be able to use the
language itself for defining a set of basic data types is just
masturbation.  C++ has the most complicated set of implicit
conversions from any language in the world, and what for?  It is
modeled for being able to create a user-defined "complex" type which
behaves almost as well as Fortran's.  Too bad that this mostly means
everybody will define his own type (well, at least we have seen two or
three different library "standards" by now), and that the implicit
conversion rules and chains are appallingly wrong for a number of
other possible user-defined arithmetic types.

-- 
David Kastrup
