From: Victor Engmark <victor.engmark@terreactive.ch>
Subject: Re: [PATCH] git-gui: give more advice when detaching HEAD
Date: Wed, 16 Feb 2011 17:11:01 +0100
Organization: terreActive AG
Message-ID: <4D5BF715.40502@terreactive.ch>
References: <20110212070538.GA2459@sigill.intra.peff.net> <20110213123151.GA31375@book.hvoigt.net> <20110215063903.GA28634@sigill.intra.peff.net> <5828845.77740.1297797387140.JavaMail.trustmail@mail1.terreactive.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 16 17:11:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PpjyM-0001O4-RS
	for gcvg-git-2@lo.gmane.org; Wed, 16 Feb 2011 17:11:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752663Ab1BPQLQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Feb 2011 11:11:16 -0500
Received: from gate.terreactive.ch ([212.90.202.121]:34846 "EHLO
	mail.terreactive.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752606Ab1BPQLO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Feb 2011 11:11:14 -0500
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.13) Gecko/20101208 Thunderbird/3.1.7
Followup-To: git@vger.kernel.org
In-Reply-To: <5828845.77740.1297797387140.JavaMail.trustmail@mail1.terreactive.ch>
X-terreActive-From: victor.engmark@terreactive.ch
X-Spam-Status: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166971>

On 02/15/2011 08:16 PM, Heiko Voigt wrote:
> Hi,
> 
> On Tue, Feb 15, 2011 at 01:39:03AM -0500, Jeff King wrote:
>> On Sun, Feb 13, 2011 at 01:31:52PM +0100, Heiko Voigt wrote:
>>
>>> On Sat, Feb 12, 2011 at 02:05:38AM -0500, Jeff King wrote:
>>>>   1. Give some indication or warning during commit that you're in a
>>>>      detached state. The CLI template says "You are not on any branch"
>>>>      when editing the commit message, and mentions "detached HEAD" as
>>>>      the branch in the post-commit summary. As far as I can tell,
>>>>      git-gui says nothing at all.
>>>
>>> How about something like this:
>>> [...]
>>> Subject: [PATCH] git-gui: warn when trying to commit on a detached head
>>>
>>> The commandline is already warning when checking out a detached head.
>>> Since the only thing thats potentially dangerous is to create commits
>>> on a detached head lets warn in case the user is about to do that.
>>
>> It seems a little heavy-handed to have a dialog pop up for each commit.
>> It's not actually dangerous to create a commit on a detached HEAD; it's
>> just dangerous to _leave_ without referencing your new commits.
> 
> Hmm, how about adding a checkbox:
> 
>   [ ] Do not ask again
> 
> In my experience anything other than a popup will be overseen so I would
> suggest doing it at least once to prepare the user for the possible
> consequences.

That would be useful. However, there is only so much space in a dialog
box (and only so much users will read in one), so to make sure users
understand what is going on (and perhaps advocate some self-learning)
there should be a link to more information.

2c,
-- 
Victor
