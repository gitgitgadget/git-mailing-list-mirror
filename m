From: Bill Lear <rael@zopyra.com>
Subject: Re: [Announce] GIT v1.5.0-rc2
Date: Tue, 23 Jan 2007 15:54:40 -0600
Message-ID: <17846.33824.555296.660115@lisa.zopyra.com>
References: <7v64b04v2e.fsf@assigned-by-dhcp.cox.net>
	<eovccc$usc$1@sea.gmane.org>
	<Pine.LNX.4.63.0701211207500.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<17846.20498.635623.173653@lisa.zopyra.com>
	<Pine.LNX.4.63.0701232012120.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<17846.27694.845530.663964@lisa.zopyra.com>
	<slrnercuc4.55u.siprbaum@xp.machine.xx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 23 22:55:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H9TcS-0001rw-IC
	for gcvg-git@gmane.org; Tue, 23 Jan 2007 22:55:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965493AbXAWVzx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 Jan 2007 16:55:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965498AbXAWVzx
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Jan 2007 16:55:53 -0500
Received: from mail.zopyra.com ([65.68.225.25]:61876 "EHLO zopyra.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965493AbXAWVzw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jan 2007 16:55:52 -0500
Received: (from rael@localhost)
	by zopyra.com (8.11.6/8.11.6) id l0NLsif08790;
	Tue, 23 Jan 2007 15:54:44 -0600
To: Peter Baumann <siprbaum@stud.informatik.uni-erlangen.de>
In-Reply-To: <slrnercuc4.55u.siprbaum@xp.machine.xx>
X-Mailer: VM 7.18 under Emacs 21.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37576>

On Tuesday, January 23, 2007 at 22:09:24 (+0100) Peter Baumann writes:
>Bill Lear <rael@zopyra.com> schrieb:
>>...
>> If I do this:
>>
>> % export PAGER=less
>> % unset LESS
>> % git diff
>>
>> I get 30 lines of output in my current repository, as I should.
>>
>> If I then do this:
>>
>> % LESS=-FRS git diff
>>
>> I get nothing --- I do see a brief blink of output, but it's as if
>> less swallows it whole and I see nothing but the next prompt.
>>
>
>This is propably caused by activating "Enable Alternate Screen Switching"
>in xterm. If you have this feature enabled, you get a clean screen (no
>fragments of the displayed file are shown after quitting less). Try to
>disable it and see if it works.

Tried as instructed: I get output when I should get output.  However,
when I should get no output, it clears/scrolls all the way down to the
bottom of the screen (LESS=-FRS git diff).


Bill
