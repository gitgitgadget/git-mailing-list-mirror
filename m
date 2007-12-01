From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Move all dashed form git commands to libexecdir
Date: Sat, 01 Dec 2007 11:32:27 -0800
Message-ID: <7vve7i43ec.fsf@gitster.siamese.dyndns.org>
References: <20071129231444.GA9616@coredump.intra.peff.net>
	<20071130003512.GB11683@coredump.intra.peff.net>
	<7vzlwwsgkp.fsf@gitster.siamese.dyndns.org>
	<20071130005852.GA12224@coredump.intra.peff.net>
	<alpine.LFD.0.9999.0711291821220.8458@woody.linux-foundation.org>
	<5E2A9E2B-8B9A-46B0-99D0-DB3798F10119@zib.de>
	<20071130151223.GB22095@coredump.intra.peff.net>
	<8aa486160711300728x70f591f1hf8884a78f2b15806@mail.gmail.com>
	<20071130152942.GA22489@coredump.intra.peff.net>
	<alpine.LFD.0.9999.0711300745330.8458@woody.linux-foundation.org>
	<fcaeb9bf0711302234l32460a1fqbf9825fc8055f99d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>,
	"Jeff King" <peff@peff.net>, "Santi B?jar" <sbejar@gmail.com>,
	"Steffen Prohaska" <prohaska@zib.de>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Jan Hudec" <bulb@ucw.cz>, git@vger.kernel.org
To: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 01 20:33:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IyY5D-0002so-RE
	for gcvg-git-2@gmane.org; Sat, 01 Dec 2007 20:33:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753051AbXLATck (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Dec 2007 14:32:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753034AbXLATck
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Dec 2007 14:32:40 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:40805 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752956AbXLATcj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Dec 2007 14:32:39 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 857482F2;
	Sat,  1 Dec 2007 14:33:00 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id A76C19BB33;
	Sat,  1 Dec 2007 14:32:50 -0500 (EST)
In-Reply-To: <fcaeb9bf0711302234l32460a1fqbf9825fc8055f99d@mail.gmail.com>
	(Nguyen Thai Ngoc Duy's message of "Sat, 1 Dec 2007 13:34:30 +0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66733>

"Nguyen Thai Ngoc Duy" <pclouds@gmail.com> writes:

> On Nov 30, 2007 10:50 PM, Linus Torvalds <torvalds@linux-foundation.org> wrote:
>
>> Well, different people will want different viewers *anyway* (ie some will
>> prefer qgit etc), so how about making "git view" be something that
>> literally acts as a built-in alias that just defaults to running gitk (if
>> for no other reason than the fact that gitk is the one that ships with
>> git, and simply has most users).
>
> We already have "git show", now we gonna get "git view", git trainers
> may have hard time explaining this one shows you a particular object
> while the other one shows you history. How about "git lshistory" (from
> clearcase land) or git show --history?

Heh, we have "bisect visualize".  How about "git visualize"?
