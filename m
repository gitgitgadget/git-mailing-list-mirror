From: greened@obbligato.org (David A. Greene)
Subject: Re: git-subtree
Date: Thu, 05 Jan 2012 16:18:02 -0600
Message-ID: <871urdyesl.fsf@smith.obbligato.org>
References: <nngaa638nwf.fsf@transit.us.cray.com>
	<CALkWK0nU9iO_6CCbWw8c_Fz=xodkaAW4300Jpc7M7D+kBP=QRg@mail.gmail.com>
	<87ipkq199w.fsf@smith.obbligato.org>
	<CALkWK0k+AwCsizZFwbKKxuz0B4xLoyC4hAy3WRD=sLCq-HvvCw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Greene <dag@cray.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 05 23:24:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rivjb-0001sx-89
	for gcvg-git-2@lo.gmane.org; Thu, 05 Jan 2012 23:24:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964785Ab2AEWY1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jan 2012 17:24:27 -0500
Received: from dsl001-154-008.msp1.dsl.speakeasy.net ([72.1.154.8]:45713 "EHLO
	smith.obbligato.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932905Ab2AEWYZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jan 2012 17:24:25 -0500
Received: from greened by smith.obbligato.org with local (Exim 4.77)
	(envelope-from <greened@obbligato.org>)
	id 1RivdL-0000u7-0J; Thu, 05 Jan 2012 16:18:03 -0600
In-Reply-To: <CALkWK0k+AwCsizZFwbKKxuz0B4xLoyC4hAy3WRD=sLCq-HvvCw@mail.gmail.com>
	(Ramkumar Ramachandra's message of "Thu, 5 Jan 2012 21:02:16 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188002>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Hi again,
>
> [+CC: Junio Hamano, our maintainer]
>
> David A. Greene wrote:
>> I've read that document. The issue is that I didn't develop the code,
>> Avery did.
>
> Not an issue as long as you have Avery's signoff.

As in a signed-off-by log entry on the commit?  I did a commit -s to add
my own signed-off-by tag and added a "From:" line in accordance with the
SubmittingPatches document:

  "If you are forwarding a patch from somebody else, optionally, at the
   beginning of the e-mail message just before the commit message starts,
   you can put a "From: " line to name that person."

I have not used signoffs before in my day-to-day git flow.  How do I go
about getting one from Avery and incorporating it into the history in an
autheticated way?  I'm assuming you don't want me to forge his sign-off.
:)

>> It's a lot of time to learn a completely new codebase. I was hoping
>> to submit something soon and then learn the codebase gradually during
>> maintenance/further development.
>
> We certainly don't want badly reviewed code that nobody understands
> floating around in the codebase

Certainly, I'm not trying to avoid review, just trying to figure out the
most efficient mechanics.

> so, I'd suggest sending out whatever you think is appropriate for the
> first round of reviews, and see how things shape up from there.

Fair enough.  I think I will take Jeff's suggested route and see where
that goes.

>> How have completely new tools be introduced into the git mainline in the
>> past?
>
> Yes.  For an example of something I was involved with but didn't
> author, see vcs-svn/.

Ok, I'll look into that.  Thanks for the pointer.

                             -Dave
