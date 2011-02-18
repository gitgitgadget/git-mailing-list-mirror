From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH] git-checkout.txt: improve detached HEAD documentation
Date: Thu, 17 Feb 2011 19:14:25 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1102171909412.14920@xanadu.home>
References: <1297971966-58500-1-git-send-email-jaysoffian@gmail.com>
 <7v7hcy9vrk.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 18 01:14:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqDzd-0007hH-Qt
	for gcvg-git-2@lo.gmane.org; Fri, 18 Feb 2011 01:14:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757010Ab1BRAOg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Feb 2011 19:14:36 -0500
Received: from relais.videotron.ca ([24.201.245.36]:40244 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756628Ab1BRAOe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Feb 2011 19:14:34 -0500
Received: from xanadu.home ([66.130.28.92]) by VL-MR-MRZ22.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0LGS0051LE01DE30@VL-MR-MRZ22.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 17 Feb 2011 19:14:25 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <7v7hcy9vrk.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167136>

On Thu, 17 Feb 2011, Junio C Hamano wrote:

> Jay Soffian <jaysoffian@gmail.com> writes:
> 
> > +It is sometimes useful to be able to checkout a commit that is not at
> > +the tip of any named branch, or even to create a new commit that is not
> > +referenced by a named branch. Let's look at what happens when we
> > +checkout commit b:
> 
> I think it is a regression from the original text to omit mention of tags
> and replace the first example of the section with a more advanced use case
> of jumping to the middle of a branch; it is far more likely that a user
> would want to detach at a specific release point.
> 
> You can rectify it by tagging 'c' as a release point and detaching the
> HEAD at that tag without losing the clarity of the following description.
> While doing so, it would be better to update the labels in the
> illustration with s/master/master branch/ and s/[abcde]/commit &/ as well,
> e.g.
> 
> 
>                    HEAD (refers to branch 'master')
>                     |
>                     V
>   a---b---c---d  branch 'master' (refers to commit 'd')
>           ^
>           |
>      tag 'v2.0' (refers to commit 'c')

While I agree with the above, I think this is still a good idea to keep 
this example using a non-tagged commit as well.  Perhaps not the first 
one as you say.


Nicolas
