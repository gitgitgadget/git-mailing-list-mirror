From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH] t/README: tests can use perl even with NO_PERL
Date: Mon, 28 Oct 2013 20:46:17 +0100
Message-ID: <526EBF09.8070200@kdbg.org>
References: <CAP30j17OCrYjsVK+W_TR-g99YmzY3d9TnYfwHXK7+6vPrVjDaQ@mail.gmail.com> <1382951633-6456-1-git-send-email-bdwalton@gmail.com> <526EA7C8.2020607@kdbg.org> <20131028182718.GA4242@google.com> <xmqqk3gxfc20.fsf@gitster.dls.corp.google.com> <20131028192216.GB4242@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Ben Walton <bdwalton@gmail.com>, git@vger.kernel.org,
	=?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 28 20:46:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vasld-0004DX-3y
	for gcvg-git-2@plane.gmane.org; Mon, 28 Oct 2013 20:46:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756252Ab3J1TqV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Oct 2013 15:46:21 -0400
Received: from bsmtp5.bon.at ([195.3.86.187]:36920 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755323Ab3J1TqU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Oct 2013 15:46:20 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 535D2130050;
	Mon, 28 Oct 2013 20:46:18 +0100 (CET)
Received: from dx.sixt.local (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id C121E19F626;
	Mon, 28 Oct 2013 20:46:17 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.0
In-Reply-To: <20131028192216.GB4242@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236854>

Am 28.10.2013 20:22, schrieb Jonathan Nieder:
> The git build system supports a NO_PERL switch to avoid installing
> perl bindings or other features (like "git add --patch") that rely on
> perl on runtime, but even with NO_PERL it has not been possible for a
> long time to run tests without perl.  Helpers such as
> 
> 	nul_to_q () {
> 		"$PERL_PATH" -pe 'y/\000/Q/'
> 	}
> 
> use perl as a better tr or sed and are regularly used in tests without
> worrying to add a PERL prerequisite.
> 
> Perl is portable enough that it seems fine to keep relying on it for
> this kind of thing in tests (and more readable than the alternative of
> trying to find POSIXy equivalents).  Update the test documentation to
> clarify this.

Thank you for the clarification!

-- Hannes
