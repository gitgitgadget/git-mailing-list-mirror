From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rebase -i: support single-letter abbreviations for the actions
Date: Sat, 29 Sep 2007 15:08:38 -0700
Message-ID: <7vzlz5jfa1.fsf@gitster.siamese.dyndns.org>
References: <Pine.LNX.4.64.0709290231300.28395@racer.site>
	<46FE7D0B.4060806@qumranet.com>
	<Pine.LNX.4.64.0709292156090.28395@racer.site>
	<46FEC00B.7050208@qumranet.com>
	<Pine.LNX.4.64.0709292243280.28395@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Avi Kivity <avi@qumranet.com>, gitster@pobox.com,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Sep 30 00:09:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IbkUd-0005n6-D8
	for gcvg-git-2@gmane.org; Sun, 30 Sep 2007 00:08:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756341AbXI2WIu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Sep 2007 18:08:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756251AbXI2WIu
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Sep 2007 18:08:50 -0400
Received: from rune.pobox.com ([208.210.124.79]:57045 "EHLO rune.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754216AbXI2WIu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Sep 2007 18:08:50 -0400
Received: from rune (localhost [127.0.0.1])
	by rune.pobox.com (Postfix) with ESMTP id 5BF0E13E040;
	Sat, 29 Sep 2007 18:09:07 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id A6B3913DE65;
	Sat, 29 Sep 2007 18:09:02 -0400 (EDT)
In-Reply-To: <Pine.LNX.4.64.0709292243280.28395@racer.site> (Johannes
	Schindelin's message of "Sat, 29 Sep 2007 22:48:00 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59498>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Sat, 29 Sep 2007, Avi Kivity wrote:
>
>> > > Can we make "amend" like squash, except that it keeps the first 
>> > > commit's authorship instead of the second?  I often merge a commit 
>> > > with some minor fix that comes later, and usually want to keep the 
>> > > original author record.
>
> Thinking about this again... Maybe it is a better semantics anyway? What 
> do others think?

I never thought about whose commit the squashed ones become
before this thread, but making squash quack as if "commit
--amend" was done after running "cherry-pick -n" the second and
later ones feels like the most natural semantics to me.
