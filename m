From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [ANNOUNCE] Git 1.7.9.3
Date: Tue, 6 Mar 2012 21:31:20 +0100
Message-ID: <877gyx4gkn.fsf@thomas.inf.ethz.ch>
References: <7vliney6k7.fsf@alter.siamese.dyndns.org>
	<A518E7E7-25D5-429C-A1C1-35F94EC8F043@bjhargrave.com>
	<87y5rd4wci.fsf@thomas.inf.ethz.ch>
	<7v8vjdsdak.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: BJ Hargrave <bj@bjhargrave.com>, <git@vger.kernel.org>,
	<trast@student.ethz.ch>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 06 21:31:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S512k-0000Qw-Lh
	for gcvg-git-2@plane.gmane.org; Tue, 06 Mar 2012 21:31:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030967Ab2CFUb1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Mar 2012 15:31:27 -0500
Received: from edge10.ethz.ch ([82.130.75.186]:32317 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965276Ab2CFUb0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Mar 2012 15:31:26 -0500
Received: from CAS22.d.ethz.ch (172.31.51.112) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.1.355.2; Tue, 6 Mar
 2012 21:31:24 +0100
Received: from thomas.inf.ethz.ch.ethz.ch (129.132.210.9) by CAS22.d.ethz.ch
 (172.31.51.112) with Microsoft SMTP Server (TLS) id 14.1.355.2; Tue, 6 Mar
 2012 21:31:23 +0100
In-Reply-To: <7v8vjdsdak.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Tue, 6 Mar 2012 12:08:19 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [129.132.210.9]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192386>

Junio C Hamano <gitster@pobox.com> writes:

> Thomas Rast <trast@inf.ethz.ch> writes:
>
>> For grep, spell the "40 hex digits" explicitly in the regex, instead
>> of being lazy with the shell pattern $_x40.
>
> Actually the shell pattern $_x40 was invented so that it can be used
> in both shell, grep and sed; there is nothing *lazy* about it.
>
> I share the "are you kidding me?!" with you.  I cannot fathom which
> part of that regular expression is too big for them to swallow.
>
> In any case, thanks for a quick fix; can I consider it as signed-off?

Oh, yes!  Sorry about that.  I pulled it from the OS X machine which did
not have S-O-B appropriately configured.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
