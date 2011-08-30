From: Raphael Zimmerer <killekulla@rdrz.de>
Subject: Re: [PATCH] stash: Don't paginate by default with list command
Date: Tue, 30 Aug 2011 22:19:18 +0200
Message-ID: <20110830201918.GC19715@rdrz.de>
References: <4e5d1e5c.438d9c87.bm000@wupperonline.de>
 <20110830175748.GA19715@rdrz.de>
 <7vk49u1z1n.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ingo =?iso-8859-1?Q?Br=FCckl?= <ib@wupperonline.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 30 22:19:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QyUmL-0008J9-KU
	for gcvg-git-2@lo.gmane.org; Tue, 30 Aug 2011 22:19:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756554Ab1H3UTV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Aug 2011 16:19:21 -0400
Received: from rdrz.de ([217.160.107.209]:45858 "HELO rdrz.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756234Ab1H3UTU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Aug 2011 16:19:20 -0400
Received: (qmail 12937 invoked by uid 1009); 30 Aug 2011 20:19:18 -0000
Content-Disposition: inline
In-Reply-To: <7vk49u1z1n.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180440>

On Tue, Aug 30, 2011 at 12:26:12PM -0700, Junio C Hamano wrote:
[...]
> to have while reviewing long-ish patches via "git log -p", but having a
> long line that "S" causes to be chopped counts as not being able to show
> the entire file on the first screen for the purpose of "F", and introduces
> a minor irritation of having to exit explicitly with a 'q'.

Yes, you are right. That can be annoying. Same issue when showing the
reflog, but as it has lots of entries, the automatic pager is really
handy. I seldom use 'stash clear' (stash is a nice way for storing
working copy history somewhere...), so I don't like to miss the
pager in stash list. Maybe 'pager.stash.list' as mentioned before is
the way to go.

But as Ingo has set the LESS environment variable to some value
('-c'), he always has to press 'q', what may be his problem (beside of
the annoyance that his less now displays '~' on each empty line).

Raphael
