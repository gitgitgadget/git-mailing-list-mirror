From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: Bug: Problem with CRLF line ending in git-diff with coloring
Date: Sun, 09 Feb 2014 19:30:46 +0100
Message-ID: <52F7C956.5040604@kdbg.org>
References: <20140209110155.GB16189@scotty.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: "Stefan-W. Hahn" <stefan.hahn@s-hahn.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 09 19:31:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WCZ9s-0000um-2h
	for gcvg-git-2@plane.gmane.org; Sun, 09 Feb 2014 19:31:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752060AbaBISbG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Feb 2014 13:31:06 -0500
Received: from bsmtp4.bon.at ([195.3.86.186]:21072 "EHLO lbmfmo03.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751961AbaBISbF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Feb 2014 13:31:05 -0500
Received: from bsmtp.bon.at (unknown [192.168.181.102])
	by lbmfmo03.bon.at (Postfix) with ESMTP id 4E773CE448
	for <git@vger.kernel.org>; Sun,  9 Feb 2014 19:31:03 +0100 (CET)
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 447C2A7EBD;
	Sun,  9 Feb 2014 19:30:47 +0100 (CET)
Received: from dx.sixt.local (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id D2DC919F683;
	Sun,  9 Feb 2014 19:30:46 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
In-Reply-To: <20140209110155.GB16189@scotty.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241883>

Am 09.02.2014 12:01, schrieb Stefan-W. Hahn:
> Good morning,
> 
> when diffing output where files have CRLF line ending, the coloring
> seems wrong, because in changed lines the CR (^M) is highlighted,
> even if the line ending has not changed.
...
> If WS_CR_AT_EOL is set in ecbdata->ws_rule, it works correctly, but this seems
> not the right solutions.

It's the right solution. IOW, you should place something like this in
your .gitattributes:

  *.html whitespace=cr-at-eol

-- Hannes
