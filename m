From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: send-email sending shallow threads by default
Date: Thu, 19 Feb 2009 20:13:39 -0800
Message-ID: <m1bpsxlp8s.fsf@fess.ebiederm.org>
References: <7vk57ridyx.fsf@gitster.siamese.dyndns.org>
	<alpine.DEB.1.10.0902151544510.14911@asgard.lang.hm>
	<20090216000732.GC3503@coredump.intra.peff.net>
	<mj+md-20090216.103512.5791.nikam@ucw.cz> <499A769B.2080308@op5.se>
	<mj+md-20090217.090514.32275.nikam@ucw.cz>
	<20090217192855.GB15625@coredump.intra.peff.net>
	<m1bpsxq074.fsf@fess.ebiederm.org>
	<20090220032607.GE22419@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin Mares <mj@ucw.cz>, Andreas Ericsson <ae@op5.se>,
	david@lang.hm, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Feb 20 05:15:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LaMna-0007WZ-IA
	for gcvg-git-2@gmane.org; Fri, 20 Feb 2009 05:15:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752925AbZBTENY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Feb 2009 23:13:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752787AbZBTENY
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Feb 2009 23:13:24 -0500
Received: from out01.mta.xmission.com ([166.70.13.231]:44995 "EHLO
	out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752608AbZBTENX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Feb 2009 23:13:23 -0500
Received: from in01.mta.xmission.com ([166.70.13.51])
	by out01.mta.xmission.com with esmtp (Exim 4.62)
	(envelope-from <ebiederm@xmission.com>)
	id 1LaMlW-0002f8-N1; Thu, 19 Feb 2009 21:13:30 -0700
Received: from c-67-169-126-145.hsd1.ca.comcast.net ([67.169.126.145] helo=fess.ebiederm.org)
	by in01.mta.xmission.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69)
	(envelope-from <ebiederm@xmission.com>)
	id 1LaMlK-0006Id-9a; Thu, 19 Feb 2009 21:13:18 -0700
Received: from fess.ebiederm.org (localhost [127.0.0.1])
	by fess.ebiederm.org (8.14.3/8.14.3/Debian-4) with ESMTP id n1K4DfE6009429;
	Thu, 19 Feb 2009 20:13:41 -0800
Received: (from eric@localhost)
	by fess.ebiederm.org (8.14.3/8.14.3/Submit) id n1K4Dd7t009428;
	Thu, 19 Feb 2009 20:13:39 -0800
X-Authentication-Warning: fess.ebiederm.org: eric set sender to ebiederm@xmission.com using -f
In-Reply-To: <20090220032607.GE22419@coredump.intra.peff.net> (Jeff King's message of "Thu\, 19 Feb 2009 22\:26\:07 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-XM-SPF: eid=;;;mid=;;;hst=in01.mta.xmission.com;;;ip=67.169.126.145;;;frm=ebiederm@xmission.com;;;spf=neutral
X-SA-Exim-Connect-IP: 67.169.126.145
X-SA-Exim-Rcpt-To: peff@peff.net, git@vger.kernel.org, gitster@pobox.com, david@lang.hm, ae@op5.se, mj@ucw.cz
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-DCC: XMission; sa02 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on sa02.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=8.0 tests=ALL_TRUSTED,BAYES_00,
	DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,XM_SPF_Neutral autolearn=disabled
	version=3.2.5
X-Spam-Combo: ;Jeff King <peff@peff.net>
X-Spam-Relay-Country: 
X-Spam-Report: * -1.8 ALL_TRUSTED Passed through trusted hosts only via SMTP
	*  0.0 T_TM2_M_HEADER_IN_MSG BODY: T_TM2_M_HEADER_IN_MSG
	* -2.6 BAYES_00 BODY: Bayesian spam probability is 0 to 1%
	*      [score: 0.0043]
	* -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
	*      [sa02 1397; Body=1 Fuz1=1 Fuz2=1]
	*  0.0 XM_SPF_Neutral SPF-Neutral
X-SA-Exim-Version: 4.2.1 (built Thu, 25 Oct 2007 00:26:12 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110788>

Jeff King <peff@peff.net> writes:

> On Thu, Feb 19, 2009 at 07:03:27PM -0800, Eric W. Biederman wrote:
>
>> > send-email does write a new date header. Which is actually desirable,
>> > IMHO, because otherwise rebased patches would get sent with their
>> > original date, which might very well long in the past (and not only is
>> > that confusing, but it would probably trip spam filters).
>> 
>> Can we ensure that all of the messages sent differ in date by 1 second?
>> Keeping them in order for anyone who looks at the transmit date.
>
> I think it already does:
>
>   $ git show a5370b16
>   commit a5370b16c34993c1d0f65171d5704244901e005b
>   Author: Eric Wong <normalperson@yhbt.net>
>   Date:   Sat Mar 25 03:01:01 2006 -0800
>
>       send-email: try to order messages in email clients more correctly
>
>       If --no-chain-reply-to is set, patches may not always be ordered
>       correctly in email clients.  This patch makes sure each email
>       sent from a different second.

Well that date's my experiments with git-send-email.  And yes looking at the
code the transmit date still appears to be computed that way.

$time = time - scalar $#files;
my $date = format_2822_time($time++);

So it appears that problem has been solved if a person simply sorts by
transmit date.

So it sounds like a good change in defaults to me.

Eric
