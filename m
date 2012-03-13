From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH] git-am: error out when seeing -b/--binary
Date: Tue, 13 Mar 2012 16:31:00 +0100
Message-ID: <87fwdcldqj.fsf@thomas.inf.ethz.ch>
References: <20120312064855.GB16820@burratino> <20120312085820.GA11569@1wt.eu>
	<20120312152004.GB9380@kroah.com> <20120312152453.GB12405@1wt.eu>
	<87aa3l4vqq.fsf@thomas.inf.ethz.ch> <20120312165703.GB18791@burratino>
	<7vvcm9snko.fsf@alter.siamese.dyndns.org>
	<87399dpk48.fsf@thomas.inf.ethz.ch> <20120312215607.GB11362@burratino>
	<874ntto4t8.fsf@thomas.inf.ethz.ch> <20120312222227.GC11362@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: Junio C Hamano <gitster@pobox.com>, Willy Tarreau <w@1wt.eu>,
	Greg KH <greg@kroah.com>, Ben Hutchings <ben@decadent.org.uk>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>,
	<git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: linux-kernel-owner@vger.kernel.org Tue Mar 13 16:31:23 2012
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1S7Th3-0001Bu-JF
	for glk-linux-kernel-3@plane.gmane.org; Tue, 13 Mar 2012 16:31:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756073Ab2CMPbG (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Tue, 13 Mar 2012 11:31:06 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:7803 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751340Ab2CMPbE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Mar 2012 11:31:04 -0400
Received: from CAS10.d.ethz.ch (172.31.38.210) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.355.2; Tue, 13 Mar
 2012 16:31:01 +0100
Received: from thomas.inf.ethz.ch.ethz.ch (129.132.153.233) by cas10.d.ethz.ch
 (172.31.38.210) with Microsoft SMTP Server (TLS) id 14.1.355.2; Tue, 13 Mar
 2012 16:31:00 +0100
In-Reply-To: <20120312222227.GC11362@burratino> (Jonathan Nieder's message of
	"Mon, 12 Mar 2012 17:22:27 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193035>

Jonathan Nieder <jrnieder@gmail.com> writes:

> 	--binary)
> 		: ;;
> 	-b)
> 		gettextln >&2 "The -b option (a no-op short for --binary) was removed in 1.7.10."
> 		die "$(gettext "Please adjust your scripts.")"
> 		;;
>
> Mentioning deprecation in 1.6.0 in the message left me uneasy because
> we never actually did anything to actively deprecate the option; it
> just has not been needed since 1.4.3 and we stopped advertising it in
> the manpage in 1.6.0.  So I don't like the implication of "this is all
> right because we told you so" --- on the contrary, it is "in practice
> nobody seems to be using this option and we hope nobody will notice
> when we take it away".

Hmm, I had an alternate patch ready in the morning, but Junio beat us to
it and applied the old one to master.

I don't really think it matters enough to apply *another*, so I'll leave
it at that.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
