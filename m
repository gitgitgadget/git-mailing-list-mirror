From: "C. Scott Ananian" <cscott@cscott.net>
Subject: Re: SHA1 hash safety
Date: Mon, 18 Apr 2005 13:04:44 -0400 (EDT)
Message-ID: <Pine.LNX.4.61.0504181252590.1039@cag.csail.mit.edu>
References: <Pine.LNX.4.62.0504160519330.21837@qynat.qvtvafvgr.pbz>
 <20050416123155.GA19908@elte.hu> <Pine.LNX.4.62.0504160542190.21837@qynat.qvtvafvgr.pbz>
 <4261132A.3090907@khandalf.com> <Pine.LNX.4.61.0504161040310.29343@cag.csail.mit.edu>
 <4261852B.6090507@khandalf.com> <20050418074323.GA29765@hexapodia.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: omb@bluewin.ch, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 18 19:02:23 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNZcm-0002u3-EX
	for gcvg-git@gmane.org; Mon, 18 Apr 2005 19:01:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262137AbVDRRFY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Apr 2005 13:05:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262138AbVDRRFY
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Apr 2005 13:05:24 -0400
Received: from sincerity-forever.csail.mit.edu ([128.30.67.31]:59029 "EHLO
	sincerity-forever.csail.mit.edu") by vger.kernel.org with ESMTP
	id S262137AbVDRRFR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Apr 2005 13:05:17 -0400
Received: from catfish.lcs.mit.edu ([128.30.67.25] helo=cag.csail.mit.edu)
	by sincerity-forever.csail.mit.edu with esmtp (Exim 3.36 #1 (Debian))
	id 1DNZg6-0004Iy-00; Mon, 18 Apr 2005 13:04:54 -0400
To: Andy Isaacson <adi@hexapodia.org>
In-Reply-To: <20050418074323.GA29765@hexapodia.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Mon, 18 Apr 2005, Andy Isaacson wrote:

> If you had actual evidence of a collision, I'd love to see it - even if
> it's just the equivalent of
> % md5 foo
> d3b07384d113edec49eaa6238ad5ff00 foo
> % md5 bar
> d3b07384d113edec49eaa6238ad5ff00 bar
> % cmp foo bar
> foo bar differ: byte 25, line 1
> %
>
> But in the absence of actual evidence, we have to assume (just based on
> the probabilities) that there was some error in your testing.

I've already had a long correspondence with this poster.  He claims that 
"this happened 7 years ago", involved a "commercial contract covered by 
Swiss Banking Law" (with caps!) and that, of course, he "certainly doesn't 
retain [his] client's documents", and even if he *did*, he wouldn't show 
them to *me*.

And then he was unable to comprehend that I couldn't accept his word alone 
as prima facie evidence that the laws of probability did not apply to him or 
his clients.

I've been a coder far too long to attribute to "The Mysterious Hand Of 
God" what can adequately be described by subtle programmer error.

The most reasonable explanation, given the (lack of) evidence, is that 
the programmer involved quickly took refuge in a (wildly improbable, but 
his clients'll never know) "MD5 collision" instead of buckling down and 
finding the bug in his code.
  --scott

ODOATH Ortega FBI SGUAT AEBARMAN India Peking ODACID operation RYBAT 
[Hello to all my fans in domestic surveillance] for Dummies KUCLUB
                          ( http://cscott.net/ )
