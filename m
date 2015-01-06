From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH 2/2] gettext.h: add parentheses around N_ expansion
Date: Tue, 06 Jan 2015 16:16:19 +0100
Message-ID: <87tx04rlbw.fsf@igel.home>
References: <ecb18f9d6ac56da0a61c3b98f8f2236@74d39fa044aa309eaea14b9f57fe79c>
	<f67db70c63f8dcbfc58d7ffda86ff10@74d39fa044aa309eaea14b9f57fe79c>
	<54ABE205.70801@ramsay1.demon.co.uk>
	<694DC462-40E3-4081-8616-64483FCD0D77@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Junio C Hamano <gitster@pobox.com>,
	Git mailing list <git@vger.kernel.org>
To: "Kyle J. McKay" <mackyle@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 06 16:23:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y8Vrx-0007RY-MR
	for gcvg-git-2@plane.gmane.org; Tue, 06 Jan 2015 16:16:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755453AbbAFPQZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jan 2015 10:16:25 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:33054 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754388AbbAFPQY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jan 2015 10:16:24 -0500
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
	by mail-out.m-online.net (Postfix) with ESMTP id 3kGy384Bvvz3hjR4;
	Tue,  6 Jan 2015 16:16:20 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 3kGy381JnTzvh29;
	Tue,  6 Jan 2015 16:16:19 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
	by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavisd-new, port 10024)
	with ESMTP id WM60DcD_Bitr; Tue,  6 Jan 2015 16:16:19 +0100 (CET)
X-Auth-Info: Lg7AUpaEB8GDziIbXRc+wjeffziSBwYF93RHGNeZuvawe9PzZX3P5xQ53j0qfZ6r
Received: from igel.home (host-188-174-214-65.customer.m-online.net [188.174.214.65])
	by mail.mnet-online.de (Postfix) with ESMTPA;
	Tue,  6 Jan 2015 16:16:19 +0100 (CET)
Received: by igel.home (Postfix, from userid 1000)
	id 0EED32C1C2C; Tue,  6 Jan 2015 16:16:19 +0100 (CET)
X-Yow: Yow!  It's some people inside the wall!  This is better than mopping!
In-Reply-To: <694DC462-40E3-4081-8616-64483FCD0D77@gmail.com> (Kyle J. McKay's
	message of "Tue, 6 Jan 2015 06:38:58 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262069>

"Kyle J. McKay" <mackyle@gmail.com> writes:

> Even clang -ansi -pedantic doesn't seem to complain about this.  And ("a")
> is just as much a constant expression as "a".  Are you sure it's not just
> a tcc bug?

The C standard asks for a string literal as the initializer, not an
expression.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
