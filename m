From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: Managing topic branches
Date: Sun, 5 Mar 2006 22:35:33 +1300
Message-ID: <46a038f90603050135j41eaf935kd48ab68212218836@mail.gmail.com>
References: <7vzmk5lkmo.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 05 10:35:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FFpeV-0001qP-DU
	for gcvg-git@gmane.org; Sun, 05 Mar 2006 10:35:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750822AbWCEJfe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Mar 2006 04:35:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752151AbWCEJfe
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Mar 2006 04:35:34 -0500
Received: from wproxy.gmail.com ([64.233.184.198]:44767 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750822AbWCEJfe convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Sun, 5 Mar 2006 04:35:34 -0500
Received: by wproxy.gmail.com with SMTP id 68so944320wri
        for <git@vger.kernel.org>; Sun, 05 Mar 2006 01:35:33 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Dv+1e2B4sd4240oElx3gI43dNbN9Lix7fl/0GAt3grwY5axBhBXqfl5nLaq30uTOr25FydprIirYDSh+SgsnMIokW4dP6X15N2MLx7caYmbZBQSBf8kB5c7w6VTgJpH9u5ZSCLhQZfhEXQi4dwnoevkVrvEBt8HlCsSGWd7kmh0=
Received: by 10.54.116.18 with SMTP id o18mr180819wrc;
        Sun, 05 Mar 2006 01:35:33 -0800 (PST)
Received: by 10.54.71.5 with HTTP; Sun, 5 Mar 2006 01:35:33 -0800 (PST)
To: "Junio C Hamano" <junkio@cox.net>
In-Reply-To: <7vzmk5lkmo.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17210>

On 3/5/06, Junio C Hamano <junkio@cox.net> wrote:
> I could have done without the "questionable octopus leg", but I
> did so that when Martin pulled my "next" into his cvsserver
...
> The moral of the story is not to try to be nice to others
> without thinking about its concequences ;-).  I should have just
> done without the "questionable octopus leg", and asked Martin to
> discard and rebase his tip of the development to my "next" after
> this merge.

No good deed goes unpunished as they say ;-)

In any case, this was perhaps based on a misunderstanding/error on my
side. To start off, I didn't understand how you were managing next.

I assumed next would be a 'rewind often' branch, a volatile thing that
I shouldn't build upon. But as I was in the awkward situation of
depending on something in next, I had to, and didn't think of the
consequences. As the branch I published for you to pull was based on
next, which meant you couldn't merge my stuff into master.

So it was a thinko on my side. I just though -- damn, I'll have to
work based on next, with the downside of having to be alert for
rewinds. Didn't think of the implications for you.

It's sorted now, but at great pains for you. I guess all I can suggest
is to put something in the name of the branch that means both "rewinds
often" and "don't base real work on this". I guess that would be
anything but master/maint, but the rules around pu are sometimes
tricky too (rewinds often, but some people have no option but to build
against it, unless you are treating it same as you treat next).

Anyway -- sorry to have caused so much trouble. My work "pending" is
at the most a patch or two, easy to extract and reapply. If something
like this comes up again, just do whatever is easiest and tell me to
rewind/rebase/cherrypick at my end.

cheers,


martin
