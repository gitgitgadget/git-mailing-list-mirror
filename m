From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: git status: small difference between stating whole repository and small subdirectory
Date: Mon, 20 Feb 2012 20:59:55 +0100
Message-ID: <87wr7hz35w.fsf@thomas.inf.ethz.ch>
References: <8762f9k5sg.fsf@thomas.inf.ethz.ch>
	<CAA01Cso_8=159UDMFUHiYz1X=gYtpbqRO4h3TMw7N=4YMV8YNg@mail.gmail.com>
	<20120215190318.GA5992@sigill.intra.peff.net>
	<CAA01Cso5y23UMguEe0vwOc6kR3-DjuC8-LTMDsMeeOKU4rVGvg@mail.gmail.com>
	<20120216192001.GB4348@sigill.intra.peff.net>
	<CAA01Csq6vSekW=Fa236bB0H3LVtN43Gb2aLMVE+A1wVyUqYJ7A@mail.gmail.com>
	<20120217203755.GA30114@sigill.intra.peff.net>
	<7vaa4hrtbe.fsf@alter.siamese.dyndns.org>
	<20120217222912.GC31830@sigill.intra.peff.net>
	<CAA01CsozANwtox06iihKBL8iii175FHAhChmNhG1B0ofGKWcEA@mail.gmail.com>
	<20120220140653.GC5131@sigill.intra.peff.net>
	<87ty2l38ay.fsf@thomas.inf.ethz.ch>
	<7vmx8dl1ln.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: Jeff King <peff@peff.net>,
	Piotr Krukowiecki <piotr.krukowiecki@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 20 21:00:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RzZP0-00029f-PJ
	for gcvg-git-2@plane.gmane.org; Mon, 20 Feb 2012 21:00:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752879Ab2BTT76 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Feb 2012 14:59:58 -0500
Received: from edge20.ethz.ch ([82.130.99.26]:46736 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752134Ab2BTT75 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Feb 2012 14:59:57 -0500
Received: from CAS20.d.ethz.ch (172.31.51.110) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.355.2; Mon, 20 Feb
 2012 20:59:54 +0100
Received: from thomas.inf.ethz.ch.ethz.ch (129.132.153.233) by CAS20.d.ethz.ch
 (172.31.51.110) with Microsoft SMTP Server (TLS) id 14.1.355.2; Mon, 20 Feb
 2012 20:59:55 +0100
In-Reply-To: <7vmx8dl1ln.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Mon, 20 Feb 2012 11:57:24 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191095>

Junio C Hamano <gitster@pobox.com> writes:

> Thomas Rast <trast@inf.ethz.ch> writes:
>
>> test_expect_failure 'checkout gives cache-tree' '
>> 	git checkout HEAD^ &&
>> 	test_shallow_cache_tree
>> '
>
> Depending on what state you start the checkout from, that is not a valid
> test.  Some form of "git reset" before the checkout to ensure the initial
> state is needed.

Oh, I was just quoting what we already had at the end of t0090 since
4eb0346f.  The test preceding it runs 'git reset --hard'.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
