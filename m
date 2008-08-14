From: "Stephen R. van den Berg" <srb@cuci.nl>
Subject: Re: [RFC] Adding a challenge-response authentication method to git://
Date: Thu, 14 Aug 2008 14:14:12 +0200
Message-ID: <20080814121412.GA25791@cuci.nl>
References: <20080813162644.GC12200@cuci.nl> <20080813163646.GO32184@machine.or.cz> <20080814074805.GA21577@linode.davidb.org> <20080814082345.GQ10151@machine.or.cz> <20080814110739.GI9680@cuci.nl> <20080814113901.GR10151@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Brown <git@davidb.org>, git <git@vger.kernel.org>
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Thu Aug 14 14:15:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTbjZ-0002G5-9o
	for gcvg-git-2@gmane.org; Thu, 14 Aug 2008 14:15:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752029AbYHNMOO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Aug 2008 08:14:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751903AbYHNMON
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Aug 2008 08:14:13 -0400
Received: from aristoteles.cuci.nl ([212.125.128.18]:38269 "EHLO
	aristoteles.cuci.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751886AbYHNMON (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Aug 2008 08:14:13 -0400
Received: by aristoteles.cuci.nl (Postfix, from userid 500)
	id 59AA45465; Thu, 14 Aug 2008 14:14:12 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080814113901.GR10151@machine.or.cz>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92354>

Petr Baudis wrote:
>On Thu, Aug 14, 2008 at 01:07:39PM +0200, Stephen R. van den Berg wrote:
>> Well, I looked into gitosis, and it solves part of the problem, it has a
>> few downsides though:

>> - It depends on Python for no particular reason (it might as well have
>>   been built using shellscripts only, or if need be Perl, since git
>>   already uses that); yet any extra dependency is creating an extra
>>   hurdle for portability and adoption.

>Is this concern really any kind of practical one? To me it appears that
>Python and Perl are both so extremely wide-spread that this might be
>issue only on embedded systems, exotic systems with very low proportion
>of git users, and users with strong ideological opinions about the
>system (probably low proportion of git users too).

I agree that in general it shouldn't be a major problem to get it on the
systems you want to use it on; but it does increase the difficulty of
auditing the solution before deploying it.

>> Other than that, gitosis looks fairly good if you want to use public
>> keys.

>This doesn't seem to be convincing reason for _reimplementing_ the
>solution. (Of course, I don't prevent you from doing that, I'm just
>wondering about the feasibility.)

I'm not going to reimplement gitosis.  I'm going to do *less* than
gitosis for situations where gitosis is undesirable (for whatever
reason, not necessarily the critisisms I mentioned before).
-- 
Sincerely,
           Stephen R. van den Berg.

"Hold still, while I inject you with SQL."
