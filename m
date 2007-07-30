From: david@lang.hm
Subject: Re: merge time
Date: Sun, 29 Jul 2007 18:27:56 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0707291823370.6331@asgard.lang.hm>
References: <241612.78983.qm@web51007.mail.re2.yahoo.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: Matthew L Foster <mfoster167@yahoo.com>
X-From: git-owner@vger.kernel.org Mon Jul 30 03:29:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFK4W-0007V7-Fx
	for gcvg-git@gmane.org; Mon, 30 Jul 2007 03:29:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965519AbXG3B3J (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 Jul 2007 21:29:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935972AbXG3B3J
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jul 2007 21:29:09 -0400
Received: from dsl081-033-126.lax1.dsl.speakeasy.net ([64.81.33.126]:35524
	"EHLO bifrost.lang.hm" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935950AbXG3B3I (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jul 2007 21:29:08 -0400
Received: from asgard (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id l6U1Sagd006898;
	Sun, 29 Jul 2007 18:28:36 -0700
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <241612.78983.qm@web51007.mail.re2.yahoo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54167>

On Sun, 29 Jul 2007, Matthew L Foster wrote:

> --- Linus Torvalds <torvalds@linux-foundation.org> wrote:
>
>> Well, there i sno "wrong" time. There are just "different" times. The only
>> thing git really tracks is not actually the time (that's purely for human
>> consumption), but the *relationship* between commits. So git really very
>> fundmanetally just tracks things like "commit X was the parent of commit
>> Y", and the time is really immaterial.
>
> Is it possible for git and/or gitweb to know that commits X and Y are descendents of merge C and
> use the time merge C happened locally for both instead of using the time commits X and Y were
> created?

git knows what's a decendent of what, but gitweb doesn't show it well. 
that's why Linus suggested you look at gitk or qgit.

by the way, you probably mean that commits X and Y are parents of merge C, 
not decendants.

but if git did what you wanted it would show every commit with the time of 
the merge, and that wouldn't help you anyway.

> It seems to me changes showing up as being made long before they really were merged is a
> very serious problem verification wise but if everyone is using git then perhaps it's not as bad
> as I think. What happens when security bug fix Z errantly seems to be in v2.6.22 but in reality
> its not?

you don't look at the dates to see if the bugfix is in 2.6.22 you look at 
the graph or ask git to tell you

remember that in git you don't have one-true-trunk of the project, you 
have a mesh of interconnected points, some of which are pointed to by tags 
that tell you that other people thought that they are particularly 
interesting.

David Lang

> Thanks for the responses,
> -Matt
>
>
>
>      ____________________________________________________________________________________
> Park yourself in front of a world of choices in alternative vehicles. Visit the Yahoo! Auto Green Center.
> http://autos.yahoo.com/green_center/
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
