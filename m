From: Ted Zlatanov <tzz@lifelogs.com>
Subject: Re: [PATCH 10/14] http: use hostname in credential description
Date: Fri, 26 Aug 2011 10:29:50 -0500
Organization: =?utf-8?B?0KLQtdC+0LTQvtGAINCX0LvQsNGC0LDQvdC+0LI=?= @
 Cienfuegos
Message-ID: <87ei08nqc1.fsf@lifelogs.com>
References: <20110718074642.GA11678@sigill.intra.peff.net>
	<20110718075232.GJ12341@sigill.intra.peff.net>
	<7vr55k4mxn.fsf@alter.siamese.dyndns.org>
	<20110722204749.GC11922@sigill.intra.peff.net>
	<7vbowmx9da.fsf@alter.siamese.dyndns.org>
	<20110722221337.GA15753@sigill.intra.peff.net>
	<87d3g1k3u6.fsf@lifelogs.com>
	<20110825202326.GC6165@sigill.intra.peff.net>
Reply-To: git@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 26 17:30:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QwyMN-0002lU-1t
	for gcvg-git-2@lo.gmane.org; Fri, 26 Aug 2011 17:30:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753981Ab1HZPaN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Aug 2011 11:30:13 -0400
Received: from lo.gmane.org ([80.91.229.12]:41433 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753693Ab1HZPaM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Aug 2011 11:30:12 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1QwyMB-0002cN-Rd
	for git@vger.kernel.org; Fri, 26 Aug 2011 17:30:07 +0200
Received: from 38.98.147.133 ([38.98.147.133])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 26 Aug 2011 17:30:07 +0200
Received: from tzz by 38.98.147.133 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 26 Aug 2011 17:30:07 +0200
X-Injected-Via-Gmane: http://gmane.org/
Mail-Followup-To: git@vger.kernel.org
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: 38.98.147.133
X-Face: bd.DQ~'29fIs`T_%O%C\g%6jW)yi[zuz6;d4V0`@y-~$#3P_Ng{@m+e4o<4P'#(_GJQ%TT= D}[Ep*b!\e,fBZ'j_+#"Ps?s2!4H2-Y"sx"
Mail-Copies-To: never
User-Agent: Gnus/5.110018 (No Gnus v0.18) Emacs/24.0.50 (gnu/linux)
Cancel-Lock: sha1:he1O+eHFvk9IYpWLgImnqnzottc=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180173>

On Thu, 25 Aug 2011 16:23:26 -0400 Jeff King <peff@peff.net> wrote: 

JK> On Fri, Aug 19, 2011 at 07:01:21AM -0500, Ted Zlatanov wrote:
>> I see some info in "What's Cooking" about this patch but it's unclear to
>> me whether the hostname issue (where it's hard to have multiple
>> identities on a single server, which I think is all right) is blocking
>> the inclusion of the patch into the next release, or if it will be
>> included eventually if no one complains about that issue, or something
>> else...

JK> Junio and I discussed it a bit in another thread. I think the ability to
JK> use "user@hostname" to disambiguate means the problem is dealt with at a
JK> high level. And the "cache" helper handles that just fine. But the
JK> "store" helper will conflate two entries for the same host. I'll see if
JK> I can work on a patch for that.

Cool, I hope this is the last wrinkle on the bundled helpers.

JK> It looks like Junio is planning to hold the series off until 1.7.8. Have
JK> you been working on a Secrets API helper? If so, I'd love to get
JK> feedback on how well the interface is serving your needs.

Work and Real Life have interfered with coding for fun, but I will have
time next week to try writing a few helpers.  This is high priority for
me because of various projects that require it; sorry for taking so long
to start using it.

Ted
