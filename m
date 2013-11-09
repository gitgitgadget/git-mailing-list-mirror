From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 2/4] Emphasize options and force ASCIIDOC escaping of
 "--"
Date: Sat, 09 Nov 2013 09:13:14 +0100
Message-ID: <527DEE9A.2090503@kdbg.org>
References: <1383958133-4207-1-git-send-email-jstjohn@purdue.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
To: "Jason St. John" <jstjohn@purdue.edu>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 09 09:13:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vf3fm-0001El-Dp
	for gcvg-git-2@plane.gmane.org; Sat, 09 Nov 2013 09:13:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754017Ab3KIINS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Nov 2013 03:13:18 -0500
Received: from bsmtp5.bon.at ([195.3.86.187]:65052 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753432Ab3KIINS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Nov 2013 03:13:18 -0500
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id D3FBCCDF84;
	Sat,  9 Nov 2013 09:13:14 +0100 (CET)
Received: from dx.sixt.local (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 4E91519F5EC;
	Sat,  9 Nov 2013 09:13:14 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.1.0
In-Reply-To: <1383958133-4207-1-git-send-email-jstjohn@purdue.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237570>

Am 09.11.2013 01:48, schrieb Jason St. John:
> -`--since=<date1>` limits to commits newer than `<date1>`, and using it
> -with `--grep=<pattern>` further limits to commits whose log message
> +'\--since=<date1>' limits to commits newer than `<date1>`, and using it
> +with '\--grep=<pattern>' further limits to commits whose log message

I don't think this kind of change goes in the right direction.
Currently, the general style seems to be that options are typeset in
monospaced font. I looked at git-merge and git-rebase (and git-log, of
course). But after your change, they are typeset in italics, in the HTML
version of the manual pages.

I did not find an advice on the preferred formatting, though, except for
the last sentence in Documentation/CodingGuidelines.

-- Hannes
