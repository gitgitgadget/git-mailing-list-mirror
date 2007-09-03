From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Buffer overflows
Date: Sun, 02 Sep 2007 17:31:14 -0700
Message-ID: <7v642soai5.fsf@gitster.siamese.dyndns.org>
References: <1188502009.29782.874.camel@hurina>
	<3f4fd2640708301435s7067137cp5db6334af844158a@mail.gmail.com>
	<7vtzqg7jrn.fsf@gitster.siamese.dyndns.org>
	<200709021542.31100.johan@herland.net>
	<3f4fd2640709020811r4ea8f01fw775257859e26af29@mail.gmail.com>
	<85veatqelm.fsf@lola.goethe.zz> <fbfju8$7gh$2@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 03 02:31:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IRzr4-0004GV-3V
	for gcvg-git@gmane.org; Mon, 03 Sep 2007 02:31:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752741AbXICAbS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 2 Sep 2007 20:31:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753022AbXICAbS
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Sep 2007 20:31:18 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:43371 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752327AbXICAbR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Sep 2007 20:31:17 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id A2A1612D191;
	Sun,  2 Sep 2007 20:31:37 -0400 (EDT)
In-Reply-To: <fbfju8$7gh$2@sea.gmane.org> (Jakub Narebski's message of "Mon,
	03 Sep 2007 02:19:24 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57417>

Jakub Narebski <jnareb@gmail.com> writes:

> David Kastrup wrote:
> ...
>> Remember git's history.
>
> On the other hand instead of doing binary diffs from a scratch, git uses
> [customized] LibXDiff library. The same might be done with bstring library,
> I think.

I am very much in favor of reusing code that aleady proved
itself in the field outside git's context.
