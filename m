From: Ismail Donmez <ismail@uludag.org.tr>
Subject: Re: Rss produced by git is not valid xml?
Date: Fri, 18 Nov 2005 23:22:36 +0200
Organization: =?utf-8?q?T=C3=9CB=C4=B0TAK/UEKAE?=
Message-ID: <200511182322.37050.ismail@uludag.org.tr>
References: <200511181833.40048.ismail@uludag.org.tr> <200511182245.01713.ismail@uludag.org.tr> <Pine.LNX.4.64.0511181301320.13959@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri Nov 18 22:23:27 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by deer.gmane.org with esmtp (Exim 3.35 #1 (Debian))
	id 1EdDhe-0001Wt-00
	for <gcvg-git@gmane.org>; Fri, 18 Nov 2005 22:23:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750961AbVKRVXX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 Nov 2005 16:23:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750967AbVKRVXX
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Nov 2005 16:23:23 -0500
Received: from ns2.uludag.org.tr ([193.140.100.220]:39605 "EHLO uludag.org.tr")
	by vger.kernel.org with ESMTP id S1750961AbVKRVXW (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Nov 2005 16:23:22 -0500
Received: from dsl.dynamic8599158195.ttnet.net.tr (unknown [85.99.158.195])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by uludag.org.tr (Postfix) with ESMTP id 991EBAB471
	for <git@vger.kernel.org>; Fri, 18 Nov 2005 23:23:15 +0200 (EET)
To: git@vger.kernel.org
User-Agent: KMail/1.9
In-Reply-To: <Pine.LNX.4.64.0511181301320.13959@g5.osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12264>

On Friday 18 November 2005 23:13, you wrote:
> On Fri, 18 Nov 2005, Ismail Donmez wrote:
> > Maybe you could officially require all commit messages to be UTF-8 then
> > the problem would be just solved for future commits at least.
>
> Just think about what that would mean for a second.
>
> What do people put in commit messages? They put things like filenames, to
> indicate that they changed file so-and-so because of issue so-and-so, or
> they needed to include header file so-and-so to fix a problem.
>
> So by virtue of forcing all commit messages to be in UTF-8, you've
> suddenly forced all filesystems to do UTF-8 too.
>
> Take that one step further: you've also forced all the file _contents_
> you talk about to be in UTF-8, since the commit message might quote part
> of the file ("'xyzzy' was misspelled, it should be 'abcde'").
>
> Or alternatively, you've forced the commit message to no longer match the
> reality that it tries to explain.
>
> See the problem?
>
> And that's ignoring the fact that you've unilaterally forced probably 50%
> of asian users to use an environment that they don't normally use.
>
> Remember: it's actually pretty _easy_ for most of the western world to
> move to UTF-8, because 99% of what we do doesn't really care one whit, and
> the remaining 1% isn't usually even a huge problem (ie it's such a small
> percentage that even if you show the wrong character for it, people
> understand what it said).

These days you can just open kwrite, select encoding and voila you don't have 
to change anything on the filesystem you can still use whatever $LANG you 
use. We would just force them to use a working editor imho. Nothing else. And 
thats not much to ask is it? Even joe(1) can edit utf-8 these days that must 
tell something.

Regards,
ismail
