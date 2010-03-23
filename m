From: Eli Barzilay <eli@barzilay.org>
Subject: Re: git rev-list formatting
Date: Tue, 23 Mar 2010 08:59:04 -0400
Message-ID: <m3fx3rnqhz.fsf@winooski.ccs.neu.edu>
References: <m3iq8opp8u.fsf@winooski.ccs.neu.edu>
	<4BA7A75A.6060909@lsrfire.ath.cx>
	<m31vfbpzol.fsf@winooski.ccs.neu.edu>
	<4BA89D88.7080803@drmicha.warpmail.net>
	<m3ocifnvpd.fsf@winooski.ccs.neu.edu>
	<20100323122603.GA2053@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 23 13:59:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nu3hc-0001oe-WF
	for gcvg-git-2@lo.gmane.org; Tue, 23 Mar 2010 13:59:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752943Ab0CWM7T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Mar 2010 08:59:19 -0400
Received: from lo.gmane.org ([80.91.229.12]:33294 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752826Ab0CWM7S (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Mar 2010 08:59:18 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Nu3hV-0001mb-4L
	for git@vger.kernel.org; Tue, 23 Mar 2010 13:59:17 +0100
Received: from winooski.ccs.neu.edu ([129.10.115.117])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 23 Mar 2010 13:59:17 +0100
Received: from eli by winooski.ccs.neu.edu with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 23 Mar 2010 13:59:17 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: winooski.ccs.neu.edu
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
Cancel-Lock: sha1:eQPnbiPL/YYS1O7fhEFNR7gzk/k=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143013>

Jeff King <peff@peff.net> writes:

> On Tue, Mar 23, 2010 at 07:06:38AM -0400, Eli Barzilay wrote:
>
>> > [...]
>> 
>> I've made a copy of the repository at
>> 
>>   http://tmp.barzilay.org/testing.git.tgz
>> 
>> which shows what I said when I run
>> 
>>   git rev-list --pretty="%b" 267d60518
>>   git rev-list --pretty="%b" 84482
>
> The problem is that most of those commits don't _have_ bodies.
> Remember that "%b" is about everything in the commit message after
> the first first paragraph.

*Ugh*...  Yes, I've seen that a lot, yet somehow I managed to
completely miss it.  Sorry about the noise.


> Now one might argue that rev-list should still put in the extra
> newline separator in this case. I haven't been paying attention, but
> hasn't that been discussed in another thread recently?

(That might have made it more confusing, but I should still have
guessed what's wrong...)

-- 
          ((lambda (x) (x x)) (lambda (x) (x x)))          Eli Barzilay:
                    http://barzilay.org/                   Maze is Life!
