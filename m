From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [PATCH v2] Add Documentation/CodingStyle
Date: Wed, 7 Nov 2007 22:43:20 +0100
Message-ID: <200711072243.21086.robin.rosenberg.lists@dewire.com>
References: <20071106201518.GA6361@ins.uni-bonn.de> <47317CD7.5040506@op5.se> <Pine.LNX.4.64.0711071456440.4362@racer.site>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Andreas Ericsson <ae@op5.se>, Junio C Hamano <gitster@pobox.com>,
	Ralf Wildenhues <Ralf.Wildenhues@gmx.de>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Nov 07 22:41:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpseH-0008Sl-AS
	for gcvg-git-2@gmane.org; Wed, 07 Nov 2007 22:41:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754252AbXKGVlG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Nov 2007 16:41:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754304AbXKGVlF
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Nov 2007 16:41:05 -0500
Received: from [83.140.172.130] ([83.140.172.130]:18143 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1754252AbXKGVlE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Nov 2007 16:41:04 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 09D7C802679;
	Wed,  7 Nov 2007 22:32:04 +0100 (CET)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 17738-05; Wed,  7 Nov 2007 22:32:03 +0100 (CET)
Received: from [10.9.0.2] (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id 87CF6802659;
	Wed,  7 Nov 2007 22:32:03 +0100 (CET)
User-Agent: KMail/1.9.7
In-Reply-To: <Pine.LNX.4.64.0711071456440.4362@racer.site>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63864>

onsdag 07 november 2007 skrev Johannes Schindelin:
> diff --git a/Documentation/CodingStyle b/Documentation/CodingStyle
> new file mode 100644
> index 0000000..38a3d9f
> --- /dev/null
> +++ b/Documentation/CodingStyle
> @@ -0,0 +1,103 @@
> +As a popular project, we also have some guidelines to keep to the
> +code.  For git in general, two rough rules are:
> +
> + - Most importantly, we never say "It's in POSIX; we'll happily
> +   screw your system that does not conform."  We live in the
> +   real world.

Can we use less offensive wording in documentation than we do on the list or IRC?
I'm not hurt by it but it doesn't look serious.

> + - Try to keep to 80 characters per line
less than?

> +
> + - When declaring pointers, the star sides with the variable name, i.e.
> +   "char *string", not "char* string" or "char * string".  This makes
> +   it easier to understand "char *string, c;"

Rationale: The C syntax is defined the way it is. C programmers should
understand it.

I'd amend: Don't mix different types in declarations.

Write:
	char *string;
	char c;

Rather than:

	char *string,c;

> + - Do not use curly brackets unnecessarily.  I.e.
> +
> +	if (bla) {
> +		x = 1;
> +	}
> +
> +   is frowned upon.  A gray area is when the statement extends over a
> +   few lines, and/or you have a lengthy comment atop of it.

Avoid unnecessary curly brackets but use them if unsure. (This is less 
strict than "do not". There are cases where we do want "unnecessary"
brackets.

-- robin
