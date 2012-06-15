From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [GSoC] Designing a faster index format - Progress Report week 8
Date: Fri, 15 Jun 2012 15:39:45 +0200
Message-ID: <878vfo1you.fsf@thomas.inf.ethz.ch>
References: <20120611205312.GB18686@tgummerer>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: <git@vger.kernel.org>, <gitster@pobox.com>, <mhagger@alum.mit.edu>,
	<pclouds@gmail.com>
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 15 15:40:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SfWki-0004Aw-Vz
	for gcvg-git-2@plane.gmane.org; Fri, 15 Jun 2012 15:39:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754693Ab2FONjt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jun 2012 09:39:49 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:14368 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751151Ab2FONjs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jun 2012 09:39:48 -0400
Received: from CAS22.d.ethz.ch (172.31.51.112) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Fri, 15 Jun
 2012 15:39:45 +0200
Received: from thomas.inf.ethz.ch.ethz.ch (129.132.153.233) by CAS22.d.ethz.ch
 (172.31.51.112) with Microsoft SMTP Server (TLS) id 14.2.298.4; Fri, 15 Jun
 2012 15:39:45 +0200
In-Reply-To: <20120611205312.GB18686@tgummerer> (Thomas Gummerer's message of
	"Mon, 11 Jun 2012 22:53:12 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thomas Gummerer <t.gummerer@gmail.com> writes:

> == Outlook for the next week ==
>
> - Continue implementing the API as discussed on [5].
>
> [5] http://thread.gmane.org/gmane.comp.version-control.git/198283/focus=198474

Sorry for being rather slow this week!  I still intend to do another
review of the github code RSN, however I felt I should point out some
more IRC conclusions to the list.

I talked Thomas out of going forward with the API as the next step, and
instead work towards having a writer side for the current format.

This should have some benefits:

* The code becomes more easily testable, and hopefully able to run the
  test suite.

* Spelling the writer in code should shake down any unforeseen
  deficiencies of the format.

  Until update-index or similar learn to use the partial writing
  facilities, we should have a little extra tool here that allows poking
  at a single entry for testing.

* The API will need to have an updating and a writing side, and what
  that should look like will become clearer.

That does mean that the API-demo in git-ls-files (suggested by Duy) will
likely have to wait until after midterms.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
