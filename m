From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-merge: add option --no-ff
Date: Mon, 17 Sep 2007 23:53:26 -0700
Message-ID: <7v4phsxy55.fsf@gitster.siamese.dyndns.org>
References: <8c5c35580709170817s467fa7dv375952f872bba0e3@mail.gmail.com>
	<11900461843997-git-send-email-hjemli@gmail.com>
	<20070918005013.GA6368@muzzle>
	<8c5c35580709172312w55613a1bw8cc58b200c526fab@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Eric Wong" <normalperson@yhbt.net>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Andreas Ericsson" <ae@op5.se>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Chris Shoemaker" <c.shoemaker@cox.net>, git@vger.kernel.org
To: "Lars Hjemli" <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 18 08:53:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXWxx-0000dA-MS
	for gcvg-git-2@gmane.org; Tue, 18 Sep 2007 08:53:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754443AbXIRGxp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2007 02:53:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754432AbXIRGxp
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Sep 2007 02:53:45 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:50019 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754373AbXIRGxo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Sep 2007 02:53:44 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 9C237135867;
	Tue, 18 Sep 2007 02:53:52 -0400 (EDT)
In-Reply-To: <8c5c35580709172312w55613a1bw8cc58b200c526fab@mail.gmail.com>
	(Lars Hjemli's message of "Tue, 18 Sep 2007 08:12:42 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58529>

"Lars Hjemli" <hjemli@gmail.com> writes:

> On 9/18/07, Eric Wong <normalperson@yhbt.net> wrote:
>> Would automatically enabling --no-ff when it detects merging of two (or
>> more) SVN branches be a good thing?
>
> I'd say 'git-svn merge' as a wrapper for 'git merge --no-ff' would be cleaner.

That unfortunately does not solve the problem.
