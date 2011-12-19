From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCHv2 2/2] attr: drop C/C++ default extension mapping
Date: Mon, 19 Dec 2011 21:51:08 +0100
Message-ID: <87hb0wnv43.fsf@thomas.inf.ethz.ch>
References: <20111217033808.GA8683@elie.hsd1.il.comcast.net>
	<20111219155737.GB19829@sigill.intra.peff.net>
	<20111219181003.GB12200@elie.hsd1.il.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: Jeff King <peff@peff.net>, <git@vger.kernel.org>,
	Johannes Sixt <j6t@kdbg.org>,
	Junio C Hamano <gitster@pobox.com>,
	Brandon Casey <drafnel@gmail.com>,
	Philip Oakley <philipoakley@iee.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 19 21:51:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RckB2-0000RJ-R2
	for gcvg-git-2@lo.gmane.org; Mon, 19 Dec 2011 21:51:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752593Ab1LSUvM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Dec 2011 15:51:12 -0500
Received: from edge10.ethz.ch ([82.130.75.186]:4086 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752218Ab1LSUvL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Dec 2011 15:51:11 -0500
Received: from CAS20.d.ethz.ch (172.31.51.110) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.1.355.2; Mon, 19 Dec
 2011 21:51:05 +0100
Received: from thomas.inf.ethz.ch.ethz.ch (129.132.153.233) by CAS20.d.ethz.ch
 (172.31.51.110) with Microsoft SMTP Server (TLS) id 14.1.355.2; Mon, 19 Dec
 2011 21:51:08 +0100
In-Reply-To: <20111219181003.GB12200@elie.hsd1.il.comcast.net> (Jonathan
	Nieder's message of "Mon, 19 Dec 2011 12:10:03 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187471>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Jeff King wrote:
>
>> But when you think about it, if our funcname pattern is bad, shouldn't
>> preventing (2) be the right thing? That is, if our funcname pattern is
>> really worse than the default language-agnostic match, wouldn't we be
>> doing everybody a service to simply remove the builtin
>> diff.cpp.xfuncname pattern?
>
> I don't see why.  Anyone who has set "diff=cpp" either likes suffering
> (maybe they are hoping to improve the pattern) or is working with a
> codebase for which the current pattern works better than the default
> behavior (maybe their codebase has a lot of goto labels aligned at
> column zero).  So removing the funcname pattern can only hurt them.

FWIW, the funcname pattern is not the only feature of the diff
attributes.  I set it mainly to get the built-in --word-diff split
regexes.

I agree with Peff's patches though, until the cpp pattern improves, we
should not turn them on by default.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
