From: aleksi.aalto@iki.fi
Subject: Re: What's cooking in git.git (Dec 2010, #01; Sat, 4)
Date: Mon, 6 Dec 2010 02:54:27 +0200 (EET)
Message-ID: <alpine.SOC.2.00.1012060235180.18993@kekkonen.cs.hut.fi>
References: <7voc90wx36.fsf@alter.siamese.dyndns.org> <20101205073938.GB15233@sigill.intra.peff.net> <7v8w04vvvr.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 06 01:54:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PPPLi-0000o6-6f
	for gcvg-git-2@lo.gmane.org; Mon, 06 Dec 2010 01:54:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752845Ab0LFAyb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Dec 2010 19:54:31 -0500
Received: from dusk.niksula.hut.fi ([130.233.40.6]:42736 "EHLO
	mail.niksula.hut.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752421Ab0LFAyb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Dec 2010 19:54:31 -0500
Received: by mail.niksula.hut.fi (Postfix, from userid 60001)
	id AB94C74CAD; Mon,  6 Dec 2010 02:54:29 +0200 (EET)
X-Spam-Checker-Version: SpamAssassin 3.3.1-niksula20080612 (2010-03-16) on dusk
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=5.0 tests=none autolearn=disabled
	version=3.3.1-niksula20080612
X-Spam-Niksula: No
Received: from kekkonen.cs.hut.fi (kekkonen.cs.hut.fi [130.233.41.50])
	by mail.niksula.hut.fi (Postfix) with ESMTP id 45DDC74CAB;
	Mon,  6 Dec 2010 02:54:28 +0200 (EET)
Received: from localhost (ajaalto@localhost)
	by kekkonen.cs.hut.fi (8.14.3+Sun/8.14.3/Submit) with ESMTP id oB60sRGo016818;
	Mon, 6 Dec 2010 02:54:27 +0200 (EET)
X-Authentication-Warning: kekkonen.cs.hut.fi: ajaalto owned process doing -bs
X-X-Sender: ajaalto@kekkonen.cs.hut.fi
In-Reply-To: <7v8w04vvvr.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.00 (SOC 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162969>

On Sun, 5 Dec 2010, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
>
>> On Sat, Dec 04, 2010 at 10:30:21PM -0800, Junio C Hamano wrote:
>>
>>> * aa/status-hilite-branch (2010-11-18) 1 commit
>>>  - status: show branchname with a configurable color
>>>
>>> I am indifferent/uninterested; I don't see anything wrong with it, but I
>>> do not find coloring the field particularly useful myself.
>>
>> I am not particularly interested, either, but FWIW, the gitcommit syntax
>> highlighting that ships with vim does highlight this, so there are at
>> least other people who think this is a good idea.
>
> As you already know, when I say "'Meh' personally", I am not saying "I
> want to forbid others to want it".
>
> How does vim highlight the other parts of that particular line?  Does it
> keep them intact, or paint them in some other color?

The default colorscheme results in the branchname being colored with a 
different color than the rest of the header. Also the texts "Changes to be 
committed:" and "Untracked files" are colored with the same color. However 
with some other colorschemes, these texts have a different color from the 
branchname.

> I had this suspicion that the class of people who choose a non default
> status.header color and the class of people who choose plain there (or
> have been happy with the default) expect different things.  The former
> prefer louder output, different pieces of information painted in different
> colors to help them chromatically distinguish them.  The latter (including
> myself) favor subdued output, without too many colors distacting them
> while reading the output.
>
> This suspicion further led me to think that the former would want this new
> feature to paint the branch name in a color different from status.header
> color, while the latter would want it in plain.  So the default of "plain"
> would be a win for both audiences.

This reasoning sounds good to me.

:Aga
