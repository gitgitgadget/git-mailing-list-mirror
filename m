From: David Kastrup <dak@gnu.org>
Subject: Re: On Tabs and Spaces
Date: Wed, 17 Oct 2007 18:08:14 +0200
Message-ID: <86sl49g1w1.fsf@lola.quinscape.zz>
References: <634393B0-734A-4884-93E3-42F7D3CB157F@mit.edu> <471476B7.5050105@users.sourceforge.net> <8c5c35580710160204s5a4f9fb3j68c0a86c4d080cb7@mail.gmail.com> <47148F72.1090602@users.sourceforge.net> <1192548367.3821.4.camel@lt21223.campus.dmacc.edu>  =?ISO-8859-1?Q?=20=04?=
	=?ISO-8859-1?Q?<B2F6DB0C-4EFE-4?= =?ISO-8859-1?Q?C56-8E7A-3182032?=
	=?ISO-8859-1?Q?0CA02@mit.edu>?= <3awb7zw6.fsf@blue.sea.net> <alpine.LFD.0.999.0710161214530.6887@woody.linux-foundation.org> <1192565900.6430.16.camel@athena> <alpine.LFD.0.999.0710161559150.6887@woody.linux-foundation.org>  =?ISO-8859-1?Q?=20<?=
	=?ISO-8859-1?Q?20071017015109=04.?= =?ISO-8859-1?Q?303760cc@localho?=
	=?ISO-8859-1?Q?st.localdomain>?= <alpine.LFD.0.999.0710161722320.26902@woody.linux-foundation.org> <3A9408D5-2667-43A6-A0CE-C0720B3A3987@vicaya.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 17 18:14:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IiBXn-0000kp-Sd
	for gcvg-git-2@gmane.org; Wed, 17 Oct 2007 18:14:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933663AbXJQQOn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Oct 2007 12:14:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936205AbXJQQOm
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Oct 2007 12:14:42 -0400
Received: from main.gmane.org ([80.91.229.2]:50599 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S936185AbXJQQOk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Oct 2007 12:14:40 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IiBV8-0008AS-0C
	for git@vger.kernel.org; Wed, 17 Oct 2007 16:12:06 +0000
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 17 Oct 2007 16:12:05 +0000
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 17 Oct 2007 16:12:05 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.50 (gnu/linux)
Cancel-Lock: sha1:e+lS7FmmlnGva9F9Cn9t2DeEBAo=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61389>

Luke Lu <git@vicaya.com> writes:

> But I still haven't seen any compelling arguments against the "all
> space" case, other than "people will screw it up into mixed spaces",
> which is really a straw man, as many multi-platform projects
> enforced the all-space policy easily by using a pre-commit hook in
> maintainers' repository.

All-space indentation renders the binary delta algorithm git uses for
compression of packs slow and partly inoperative (all sequences of 16
spaces share the same finger print, and the number of identical finger
prints for which the file information is kept is reduced to 64).

> The only downside of all-space is a moderate space bloat in source,
> which is insignificant, all things considered.

It will also slow down git's packing and make it produce worse
results.

> I agree that "8-character tabs are the gold standard", only for the
> tabstop==8 part but not the indent==tab part. For me the question
> is: is it really so unreasonable to just say "all-space is the holy
> grail"?

Yes.

-- 
David Kastrup
