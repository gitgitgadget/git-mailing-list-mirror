From: greened@obbligato.org (David A. Greene)
Subject: Re: git-subtree
Date: Thu, 05 Jan 2012 09:03:38 -0600
Message-ID: <87ipkq199w.fsf@smith.obbligato.org>
References: <nngaa638nwf.fsf@transit.us.cray.com>
	<CALkWK0nU9iO_6CCbWw8c_Fz=xodkaAW4300Jpc7M7D+kBP=QRg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Greene <dag@cray.com>, git@vger.kernel.org
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 05 16:24:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RipB4-0004Tm-4x
	for gcvg-git-2@lo.gmane.org; Thu, 05 Jan 2012 16:24:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755753Ab2AEPYV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jan 2012 10:24:21 -0500
Received: from dsl001-154-008.msp1.dsl.speakeasy.net ([72.1.154.8]:43164 "EHLO
	smith.obbligato.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754284Ab2AEPYV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jan 2012 10:24:21 -0500
X-Greylist: delayed 1166 seconds by postgrey-1.27 at vger.kernel.org; Thu, 05 Jan 2012 10:24:21 EST
Received: from greened by smith.obbligato.org with local (Exim 4.77)
	(envelope-from <greened@obbligato.org>)
	id 1Rioqx-0000Tw-Ke; Thu, 05 Jan 2012 09:03:39 -0600
In-Reply-To: <CALkWK0nU9iO_6CCbWw8c_Fz=xodkaAW4300Jpc7M7D+kBP=QRg@mail.gmail.com>
	(Ramkumar Ramachandra's message of "Thu, 5 Jan 2012 16:58:22 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187980>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Hi David,
>
> David Greene wrote:
>> I have a patch ready.
>> How does the git community want the patch presented?
>
> Please read and follow the guidelines listed in
> Documentation/SubmittingPatches.  The TL;DR version is: break it up
> into logical reviewable commits based on the current `master` and use
> git format-patch/ git send-email to send those commits to this mailing
> list.

I've read that document.  The issue is that I didn't develop the code,
Avery did.  This is a completely new tool for git and I don't have the
first idea of what "logical" chunks would look like.  I assume, for
example, that we'd want the first "chunk" to actually work and do
something interesting.  I can go spend a bunch of time to see if I can
grok enough to create these chunks but I wanted to check first and make
sure that would be absolutely necessary.  It's a lot of time to learn a
completely new codebase.  I was hoping to submit something soon and then
learn the codebase gradually during maintenance/further development.

How have completely new tools be introduced into the git mainline in the
past?

Thanks!

                              -Dave
