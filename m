From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: Python extension commands in git - request for policy change
Date: Sun, 25 Nov 2012 09:57:28 +0100
Message-ID: <50B1DD78.5040907@kdbg.org>
References: <20121125024451.1ADD14065F@snark.thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Eric S. Raymond" <esr@thyrsus.com>
X-From: git-owner@vger.kernel.org Sun Nov 25 09:57:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TcY28-00072K-MU
	for gcvg-git-2@plane.gmane.org; Sun, 25 Nov 2012 09:57:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752269Ab2KYI5d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Nov 2012 03:57:33 -0500
Received: from bsmtp.bon.at ([213.33.87.14]:21456 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751729Ab2KYI5d (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Nov 2012 03:57:33 -0500
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id DFB9B10011;
	Sun, 25 Nov 2012 09:57:29 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 0D7C619F434;
	Sun, 25 Nov 2012 09:57:28 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:16.0) Gecko/20121025 Thunderbird/16.0.2
In-Reply-To: <20121125024451.1ADD14065F@snark.thyrsus.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210339>

Am 25.11.2012 03:44, schrieb Eric S. Raymond:
> That, among other things, means up-to-date versions of Python are
> ubiquitous unless we're looking at Windows - in which case Perl and
> shell actually become much bigger portability problems.

You seem to ignore that more than a quater of users are on Windows[1].
This is not negligible.

Therefore, we *are* looking at Windows. But where is there a portability
problem? There is a POSIX shell available in all git installations on
Windows. So is Perl. Python is not.

[1]
https://git.wiki.kernel.org/index.php/GitSurvey2011#10._On_which_operating_system.28s.29_do_you_use_Git.3F

> 4) We should be encouraging C code to move to Python, too.

Absolutely not. To achieve best portability, all code should move to C
instead.

-- Hannes
