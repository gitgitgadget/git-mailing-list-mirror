From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git push (mis ?)behavior
Date: Fri, 28 Sep 2007 02:44:03 -0700
Message-ID: <7vr6kjp1jw.fsf@gitster.siamese.dyndns.org>
References: <20070927130447.GH10289@artemis.corp>
	<7v3awzvrpr.fsf@gitster.siamese.dyndns.org>
	<9D61974D-E08D-49F6-9C88-6BE446D53C74@zib.de>
	<20070928065823.GB19299@artemis.corp>
	<09A90525-8B0B-4249-904C-722BCC544B4E@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pierre Habouzit <madcoder@debian.org>, git@vger.kernel.org
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Fri Sep 28 11:44:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IbCOU-0007ur-NN
	for gcvg-git-2@gmane.org; Fri, 28 Sep 2007 11:44:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755481AbXI1JoP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Sep 2007 05:44:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755278AbXI1JoP
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Sep 2007 05:44:15 -0400
Received: from rune.pobox.com ([208.210.124.79]:54123 "EHLO rune.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754678AbXI1JoO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Sep 2007 05:44:14 -0400
Received: from rune (localhost [127.0.0.1])
	by rune.pobox.com (Postfix) with ESMTP id A55A113AFE1;
	Fri, 28 Sep 2007 05:44:33 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 255B713ADC6;
	Fri, 28 Sep 2007 05:44:27 -0400 (EDT)
In-Reply-To: <09A90525-8B0B-4249-904C-722BCC544B4E@zib.de> (Steffen Prohaska's
	message of "Fri, 28 Sep 2007 11:26:25 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59384>

Steffen Prohaska <prohaska@zib.de> writes:

> On Sep 28, 2007, at 8:58 AM, Pierre Habouzit wrote:
>
>> On Fri, Sep 28, 2007 at 06:52:47AM +0000, Steffen Prohaska wrote:
>
> But I may also be interested to push only the current branch I'm working
> on. I may also have some pending fixes on another branch that should not
> be pushed now. Currently I need to do "git push origin
> <current>:<someremote>".

Sounds sensible.

> Let me put it as a question: How can I push changes from the current
> branch to all remote refs it is configured to push to via
> "remote.<name>.push"
> without pushing anything else at the same time?

Sorry, but I do not get you.  Are you talking about pushing your
'frotz' into more than one branches 'nitfol' and 'xyzzy' at the
same remote 'origin' without having to say

	$ git push origin frotz:nitfol frotz:xyzzy

???
