From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [PATCH] t/t3903-stash: improve testing of git-stash show
Date: Fri, 24 Sep 2010 15:50:19 -0500
Message-ID: <UNSmPBO95_JSGKkZEyMl028XH9fmWCis39YCV_49wZs7FghyXRqw2Q@cipher.nrlssc.navy.mil>
References: <00400143-1A23-4245-9D7C-4AC9093785F5@gernhardtsoftware.com> <BVPnfVXRBMtK-9WPRRt3RH05x0aSmoFQsrb6lVp2uyULwHxOV-DnAXrmucCvrGrPQX_-AdS0fnA@cipher.nrlssc.navy.mil> <47BAA71F-CF5C-4A98-BBB9-C502C81E3230@silverinsanity.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: jon.seymour@gmail.com, robbat2@gentoo.org, git@vger.kernel.org,
	Brandon Casey <drafnel@gmail.com>
To: Brian Gernhardt <benji@silverinsanity.com>
X-From: git-owner@vger.kernel.org Fri Sep 24 22:50:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OzFEH-0000DJ-G1
	for gcvg-git-2@lo.gmane.org; Fri, 24 Sep 2010 22:50:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754731Ab0IXUui (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Sep 2010 16:50:38 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:40426 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752313Ab0IXUuh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Sep 2010 16:50:37 -0400
Received: by mail.nrlssc.navy.mil id o8OKoKWE019743; Fri, 24 Sep 2010 15:50:20 -0500
In-Reply-To: <47BAA71F-CF5C-4A98-BBB9-C502C81E3230@silverinsanity.com>
X-OriginalArrivalTime: 24 Sep 2010 20:50:20.0217 (UTC) FILETIME=[19D82A90:01CB5C2A]
X-Virus-Scanned: clamav-milter 0.95.3 at mail1
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157058>

On 09/24/2010 03:43 PM, Brian Gernhardt wrote:

>> On 09/24/2010 03:27 PM, Brian Gernhardt wrote:
>>> I bisected the issue to a9bf09e (detached-stash: simplify git stash show),
>>> which is when "git stash show" started using parse_flags_and_rev (via
>>> assert_stash_like()).
>>>
>>> More worrying to me is that the tests for "git stash show" don't bother
>>> to test the output.  I'll be working on that now.
>>
>> I was preparing these tests when your email came in.
> 
> I spent longer finding the source of the problem than you did.  I was just
> putting the finishing touches on it when I got this.  Yours is more through
> than mine, so I won't bother finishing.

I hope you're just abandoning the tests you were creating, and _not_
abandoning the search for a fix.  The "solution" I offered is flawed
and breaks some of the other tests. :)

-Brandon
