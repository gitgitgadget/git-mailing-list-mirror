From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: Specifying revisions in the future
Date: Mon, 06 Feb 2012 13:27:46 +0100
Message-ID: <m2y5sg6ta5.fsf@igel.home>
References: <jgjkk0$qrg$1@dough.gmane.org>
	<m3ehu9kknw.fsf@localhost.localdomain> <m2wr81vsdv.fsf@igel.home>
	<201202052324.59941.jnareb@gmail.com>
	<178AA8FDB02246D9AA9416C0D54E51A8@PhilipOakley>
	<m2obtcx4i2.fsf@igel.home> <vpq62fk89x1.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "Philip Oakley" <philipoakley@iee.org>,
	"Jakub Narebski" <jnareb@gmail.com>, <jpaugh@gmx.us>,
	<git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Feb 06 13:27:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RuNfm-0004PP-Bl
	for gcvg-git-2@plane.gmane.org; Mon, 06 Feb 2012 13:27:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754889Ab2BFM1u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Feb 2012 07:27:50 -0500
Received: from mail-out.m-online.net ([212.18.0.10]:37017 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754831Ab2BFM1t (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Feb 2012 07:27:49 -0500
Received: from frontend1.mail.m-online.net (frontend1.mail.intern.m-online.net [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 216F21800081;
	Mon,  6 Feb 2012 13:27:47 +0100 (CET)
X-Auth-Info: P0QMkjwSVVm/cjY4Tt9TADgr+2FZnod1AoRt44aEsdo=
Received: from igel.home (ppp-93-104-129-172.dynamic.mnet-online.de [93.104.129.172])
	by mail.mnet-online.de (Postfix) with ESMTPA id 596661C001A8;
	Mon,  6 Feb 2012 13:27:47 +0100 (CET)
Received: by igel.home (Postfix, from userid 501)
	id 16405CA29F; Mon,  6 Feb 2012 13:27:47 +0100 (CET)
X-Yow: MMM-MM!!  So THIS is BIO-NEBULATION!
In-Reply-To: <vpq62fk89x1.fsf@bauges.imag.fr> (Matthieu Moy's message of "Mon,
	06 Feb 2012 12:43:06 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190069>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Andreas Schwab <schwab@linux-m68k.org> writes:
>
>> The rule should be to follow the leftmost parent as far as possible.
>
> But then, if --first-parent doesn't reach the commit you want, there may
> be several paths not following --first-parent that reach it. And you'll
> have to invent some more rules to order them.

The leftmost parent is not necessarily the first parent, but the
leftmost parent that still reaches the commit.  It's a depth-first
search: if following the first parent doesn't reach the commit any more,
try again with the second parent.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
