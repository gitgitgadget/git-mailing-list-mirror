From: Fedor Sergeev <Fedor.Sergeev@Sun.COM>
Subject: Re: why is git destructive by default? (i suggest it not be!)
Date: Tue, 24 Jun 2008 14:01:18 +0400 (Russian Standard Time)
Message-ID: <alpine.WNT.1.10.0806241343170.3824@theodor>
References: <20080624081601.GA2692@sigill.intra.peff.net>
 <willow-jeske-01l5PFjPFEDjCfzf-01l5kv6TFEDjCj8S@brm-avmta-1.central.sun.com>
 <willow-jeske-01l5lTEoFEDjCVta@brm-avmta-1.central.sun.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: David Jeske <jeske@google.com>
X-From: git-owner@vger.kernel.org Tue Jun 24 12:48:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KB64B-0005HS-5M
	for gcvg-git-2@gmane.org; Tue, 24 Jun 2008 12:48:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752812AbYFXKrH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2008 06:47:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752578AbYFXKrF
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jun 2008 06:47:05 -0400
Received: from brmea-mail-4.Sun.COM ([192.18.98.36]:34445 "EHLO
	brmea-mail-4.sun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752479AbYFXKrE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2008 06:47:04 -0400
X-Greylist: delayed 2503 seconds by postgrey-1.27 at vger.kernel.org; Tue, 24 Jun 2008 06:47:04 EDT
Received: from fe-amer-10.sun.com ([192.18.109.80])
	by brmea-mail-4.sun.com (8.13.6+Sun/8.12.9) with ESMTP id m5OA5J8S009594
	for <git@vger.kernel.org>; Tue, 24 Jun 2008 10:05:19 GMT
Received: from conversion-daemon.mail-amer.sun.com by mail-amer.sun.com
 (Sun Java System Messaging Server 6.2-8.04 (built Feb 28 2007))
 id <0K2Y00101PBQIP00@mail-amer.sun.com>
 (original mail from Fedor.Sergeev@Sun.COM) for git@vger.kernel.org; Tue,
 24 Jun 2008 04:05:19 -0600 (MDT)
Received: from localhost ([92.255.85.22])
 by mail-amer.sun.com (Sun Java System Messaging Server 6.2-8.04 (built Feb 28
 2007)) with ESMTPSA id <0K2Y007VCPCINW60@mail-amer.sun.com>; Tue,
 24 Jun 2008 04:05:19 -0600 (MDT)
In-reply-to: <willow-jeske-01l5lTEoFEDjCVta@brm-avmta-1.central.sun.com>
X-X-Sender: fs77888@mail-amer.sun.com
User-Agent: Alpine 1.10 (WNT 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86031>


On Tue, 24 Jun 2008, David Jeske wrote:
> This is mostly moot since I've understood that it's easy to set git to never
> GC. I guess I'm curious about why those GC fields would ever be set to anything
> other than never?

On Tue, 24 Jun 2008, David Jeske wrote:
> My philosophy is simple, I never never
> never want to throw away changes, you shouldn't either. Disks are cheaper than
> programmer hours. I can understand wanting to keep things tidy, so I can
> understand ways to correct the 'easily visible changes', and also avoid pushing
> them to other trees, but I don't understand why git needs to delete things.

It looks like you are severely restricting your own way of thinking about
a source code management as a source code backup system only.

While this might be a valid mindset for a gatekeeper on a public 
repository it way way restrictive for a developer that wants to have a 
system that helps him doing a job.
And, say, for me, for my own job, ability to experiment *safely* and 
effectively, ability to try out different histories is the most valuable
asset that git brings to the world of SCMs.

My collegues that were forced to use Mercurial for their job are really 
unhappy about Mercurial's habbit of not modifying history at all.
After a certain amount of time just looking at the history of an actively 
developed project causes a headache.


When you speak about allowing/disallowing destructive actions you actually
speak about policies.
Different organizations, different repositories have different policies.
And git is very flexible in allowing you to implement all those different
policies as you wish it.

And whether default policy should allow people to experiment freely or not
is a very delicate question, which I would not really have enough courage
to speculate on.

regards,
   Fedor.

P.S. Saying all that, I would really like to have an easy way to tie non-default
policies to repositories so it propagates on clones. It is really helpful
in big organizations. But thats another story.
