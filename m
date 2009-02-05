From: Ed Cashin <ecashin@coraid.com>
Subject: Re: What is not in git.git
Date: Thu, 5 Feb 2009 09:02:15 -0500
Message-ID: <20090205140215.GB20348@coraid.com>
References: <20090205054918.6117@nanako3.lavabit.com> <7vy6wllswz.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nanako Shiraishi <nanako3@lavabit.com>, git@vger.kernel.org,
	arjen@yaph.org, joey@kitenet.net, benny.kra@googlemail.com,
	pw@padd.com, simon@lst.de, jidanni@jidanni.org, dirker@gmail.com,
	hoxu@users.sf.net
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 05 15:03:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LV4oY-0003yu-5r
	for gcvg-git-2@gmane.org; Thu, 05 Feb 2009 15:02:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755284AbZBEOBT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Feb 2009 09:01:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754343AbZBEOBT
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Feb 2009 09:01:19 -0500
Received: from ns1.co-raid.com ([12.51.113.4]:51176 "EHLO coraid.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754260AbZBEOBS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Feb 2009 09:01:18 -0500
Received: from kokone.coraid.com ([68.16.104.79]) by coraid.com; Thu Feb  5 09:01:06 EST 2009
Content-Disposition: inline
In-Reply-To: <7vy6wllswz.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.16 (2007-06-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108564>

On Wed, Feb 04, 2009 at 02:49:00PM -0800, Junio C Hamano wrote:
> Nanako Shiraishi <nanako3@lavabit.com> writes:
...
> >  1. From: ecashin@coraid.com
> >     Subject: [PATCH] git-describe documentation: --match pattern is glob
> >     Date: Thu, 22 Jan 2009 11:21:53 -0500
> >     Message-ID: <dfa634dbd8def9e205bbe219217179ca@coraid.com>
> >
> >     I thought this was correct, but was missing a sign-off. Perhaps it was
> >     dropped on the floor because it was sent in a wrong format that is
> >     harder to apply?
> 
> Mostly correct, but because we consider refnames like filesystem paths and
> the use of globs when matching them is shared as the same basic design
> across commands, I do not think the manual page for each individual
> command is the right place to say it.

I can add a sign-off if that would help, but it sounds like it was the
wrong fix.  I didn't know the right place to say it, but I figure: If
there is a right place, then what is it?  If there isn't one, saying
it in the git-describe manpage is probably a good step for now.

-- 
  Ed Cashin <ecashin@coraid.com>
