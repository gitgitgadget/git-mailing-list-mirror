From: greened@obbligato.org (David A. Greene)
Subject: Re: git-subtree Ready #2
Date: Tue, 14 Feb 2012 23:31:30 -0600
Message-ID: <87sjicpsr1.fsf@smith.obbligato.org>
References: <877gztmfwy.fsf@smith.obbligato.org>
	<8739acra5j.fsf@smith.obbligato.org>
	<20120215050855.GB29902@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Feb 15 06:34:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RxXVY-00075h-9z
	for gcvg-git-2@plane.gmane.org; Wed, 15 Feb 2012 06:34:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751571Ab2BOFdv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Feb 2012 00:33:51 -0500
Received: from li209-253.members.linode.com ([173.255.199.253]:48064 "EHLO
	johnson.obbligato.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751502Ab2BOFdu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Feb 2012 00:33:50 -0500
Received: from c-75-73-20-8.hsd1.mn.comcast.net ([75.73.20.8] helo=smith.obbligato.org)
	by johnson.obbligato.org with esmtpsa (TLS1.2:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.77)
	(envelope-from <greened@obbligato.org>)
	id 1RxXV0-00011X-PQ; Tue, 14 Feb 2012 23:33:51 -0600
In-Reply-To: <20120215050855.GB29902@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 15 Feb 2012 00:08:55 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Filter-Spam-Score: ()
X-Filter-Spam-Report: Spam detection software, running on the system "johnson.obbligato.org", has
 identified this incoming email as possible spam.  The original message
 has been attached to this so you can view it (if it isn't spam) or label
 similar future email.  If you have any questions, see
 @@CONTACT_ADDRESS@@ for details.
 Content preview:  Jeff King <peff@peff.net> writes: > On Tue, Feb 14, 2012 at
    10:30:16PM -0600, David A. Greene wrote: > >> This is also available at:
   >> >> git clone git://sources.obbligato.org/git/git.git > > Hmm. So it seems
    like a pretty straightforward subtree merge of > git-subtree. [...] 
 Content analysis details:   (-1.0 points, 5.0 required)
  pts rule name              description
 ---- ---------------------- --------------------------------------------------
 -1.0 ALL_TRUSTED            Passed through trusted hosts only via SMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190812>

Jeff King <peff@peff.net> writes:

> On Tue, Feb 14, 2012 at 10:30:16PM -0600, David A. Greene wrote:
>
>> This is also available at:
>> 
>> git clone git://sources.obbligato.org/git/git.git
>
> Hmm. So it seems like a pretty straightforward subtree merge of
> git-subtree. 

Yep.

> I can't say I'm super excited about having copied bits like
> contrib/subtree/t/Makefile that are basically replicas of git's
> t/Makefile.  

I know, I didn't like it either but could not think of a better way.

> But there's not that much of it, the cruft lives in contrib, and
> there's really not a good solution short of actually making
> git-subtree a first-class git command.

That's the conclusion I came to.  Moving it to a first-class command
should be pretty simple when the time comes.

> But more important than the physical layout is the maintenance plan
> going forward.  Is Avery going to keep maintaining git-subtree, and we
> will just occasionally pull? Are you maintaining it? Where will patches
> go? To a github repo? To git@vger?

I am still waiting to hear from Avery on that.  I will ping him again.
My intention is to certainly participate in maintenance.  I use
git-subtree daily so it's in my interest to keep it working.

I plan to send patcher to git@vger.  I don't think a pull would be
practical given the removal of redundant files and other things.

                           -Dave
