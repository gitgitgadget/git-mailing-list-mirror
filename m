From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: send-email sending shallow threads by default
Date: Thu, 19 Feb 2009 19:03:27 -0800
Message-ID: <m1bpsxq074.fsf@fess.ebiederm.org>
References: <7vk57ridyx.fsf@gitster.siamese.dyndns.org>
	<alpine.DEB.1.10.0902151544510.14911@asgard.lang.hm>
	<20090216000732.GC3503@coredump.intra.peff.net>
	<mj+md-20090216.103512.5791.nikam@ucw.cz> <499A769B.2080308@op5.se>
	<mj+md-20090217.090514.32275.nikam@ucw.cz>
	<20090217192855.GB15625@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin Mares <mj@ucw.cz>, Andreas Ericsson <ae@op5.se>,
	david@lang.hm, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Feb 20 04:04:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LaLh1-0001LA-Gg
	for gcvg-git-2@gmane.org; Fri, 20 Feb 2009 04:04:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754633AbZBTDDO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Feb 2009 22:03:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754247AbZBTDDN
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Feb 2009 22:03:13 -0500
Received: from out02.mta.xmission.com ([166.70.13.232]:39682 "EHLO
	out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753743AbZBTDDM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Feb 2009 22:03:12 -0500
Received: from in01.mta.xmission.com ([166.70.13.51])
	by out02.mta.xmission.com with esmtp (Exim 4.62)
	(envelope-from <ebiederm@xmission.com>)
	id 1LaLfR-0005cA-Qv; Thu, 19 Feb 2009 20:03:09 -0700
Received: from c-67-169-126-145.hsd1.ca.comcast.net ([67.169.126.145] helo=fess.ebiederm.org)
	by in01.mta.xmission.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69)
	(envelope-from <ebiederm@xmission.com>)
	id 1LaLfR-0003TQ-Cy; Thu, 19 Feb 2009 20:03:09 -0700
Received: from fess.ebiederm.org (localhost [127.0.0.1])
	by fess.ebiederm.org (8.14.3/8.14.3/Debian-4) with ESMTP id n1K33Wwd005943;
	Thu, 19 Feb 2009 19:03:32 -0800
Received: (from eric@localhost)
	by fess.ebiederm.org (8.14.3/8.14.3/Submit) id n1K33Rap005942;
	Thu, 19 Feb 2009 19:03:27 -0800
X-Authentication-Warning: fess.ebiederm.org: eric set sender to ebiederm@xmission.com using -f
In-Reply-To: <20090217192855.GB15625@coredump.intra.peff.net> (Jeff King's message of "Tue\, 17 Feb 2009 14\:28\:55 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-XM-SPF: eid=;;;mid=;;;hst=in01.mta.xmission.com;;;ip=67.169.126.145;;;frm=ebiederm@xmission.com;;;spf=neutral
X-SA-Exim-Connect-IP: 67.169.126.145
X-SA-Exim-Rcpt-To: peff@peff.net, git@vger.kernel.org, gitster@pobox.com, david@lang.hm, ae@op5.se, mj@ucw.cz
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-DCC: XMission; sa03 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on sa03.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=8.0 tests=ALL_TRUSTED,BAYES_40,
	DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,XMReplyNow,XM_SPF_Neutral
	autolearn=disabled version=3.2.5
X-Spam-Combo: ;Jeff King <peff@peff.net>
X-Spam-Relay-Country: 
X-Spam-Report: * -1.8 ALL_TRUSTED Passed through trusted hosts only via SMTP
	*  0.0 T_TM2_M_HEADER_IN_MSG BODY: T_TM2_M_HEADER_IN_MSG
	* -0.2 BAYES_40 BODY: Bayesian spam probability is 20 to 40%
	*      [score: 0.2298]
	* -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
	*      [sa03 1397; Body=1 Fuz1=1 Fuz2=1]
	*  1.5 XMReplyNow Urgent/immediate reply
	*  0.0 XM_SPF_Neutral SPF-Neutral
X-SA-Exim-Version: 4.2.1 (built Thu, 25 Oct 2007 00:26:12 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110784>

Jeff King <peff@peff.net> writes:

> On Tue, Feb 17, 2009 at 10:06:18AM +0100, Martin Mares wrote:
>
>> > There's no need to have the date field be set to the time the mails
>> > were actually sent though. AFAIR, they get the AUTHOR_DATE now, and
>> > I doubt more than one commit can be authored every second.
>> 
>> Is it really so?  Last time I have used git send-email, they got the
>> current date. It was in Git 1.5.5, though, so it is possible that it
>> has changed since then.
>
> send-email does write a new date header. Which is actually desirable,
> IMHO, because otherwise rebased patches would get sent with their
> original date, which might very well long in the past (and not only is
> that confusing, but it would probably trip spam filters).

Can we ensure that all of the messages sent differ in date by 1 second?
Keeping them in order for anyone who looks at the transmit date.

I know at one point I started using --change-reply-to because of the problem
of threads showing up in the wrong order, and making it hard to read.

Eric
