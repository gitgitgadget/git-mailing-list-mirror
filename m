From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: Specifying revisions in the future
Date: Mon, 06 Feb 2012 00:08:37 +0100
Message-ID: <m2obtcx4i2.fsf@igel.home>
References: <jgjkk0$qrg$1@dough.gmane.org>
	<m3ehu9kknw.fsf@localhost.localdomain> <m2wr81vsdv.fsf@igel.home>
	<201202052324.59941.jnareb@gmail.com>
	<178AA8FDB02246D9AA9416C0D54E51A8@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "Jakub Narebski" <jnareb@gmail.com>,
	"Matthieu Moy" <Matthieu.Moy@grenoble-inp.fr>, <jpaugh@gmx.us>,
	<git@vger.kernel.org>
To: "Philip Oakley" <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Mon Feb 06 00:08:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RuBCS-0000AJ-6z
	for gcvg-git-2@plane.gmane.org; Mon, 06 Feb 2012 00:08:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754542Ab2BEXIl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Feb 2012 18:08:41 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:53030 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754201Ab2BEXIi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Feb 2012 18:08:38 -0500
Received: from frontend1.mail.m-online.net (unknown [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 01CB71C1D9E3;
	Mon,  6 Feb 2012 00:08:38 +0100 (CET)
X-Auth-Info: 0W77CrBhY88jRobsdIgjnH7y2YRXt68zISFMt9ulPdk=
Received: from igel.home (ppp-88-217-114-0.dynamic.mnet-online.de [88.217.114.0])
	by mail.mnet-online.de (Postfix) with ESMTPA id E7CF51C00040;
	Mon,  6 Feb 2012 00:08:37 +0100 (CET)
Received: by igel.home (Postfix, from userid 501)
	id AA2B3CA29F; Mon,  6 Feb 2012 00:08:37 +0100 (CET)
X-Yow: RHAPSODY in Glue!
In-Reply-To: <178AA8FDB02246D9AA9416C0D54E51A8@PhilipOakley> (Philip Oakley's
	message of "Sun, 5 Feb 2012 22:58:43 -0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189984>

"Philip Oakley" <philipoakley@iee.org> writes:

> Is there also a rule missing for X+2, viewed from D, in this example
>
>X<---Y<---Z<---
>          \          \
>A<----B<----C<----D

This is difficult to interpret since it has some extra indent, let's
assume that Z is the second parent of D and Y the second parent of B.

> as to which order the first parent rule should _not_ be applied when D's
> first parent chain doesn't reach X (it reaches A).
> Using 'oldest' first for alternate parent testing would make X+2 = B,
> whilst 'newest' first would make X+2=Z. I have used the chain order for
> newest/oldest', rather than commit date.

The rule should be to follow the leftmost parent as far as possible.
That means that X+2->D is B.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
