From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: [RFC/PATCH] rebase -i: add run command to launch a shell command
Date: Fri, 30 Jul 2010 10:51:13 -0400
Message-ID: <4C52E6E1.20101@xiplink.com>
References: <1280323784-27462-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Fri Jul 30 16:51:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OeqvQ-0000Pw-AM
	for gcvg-git-2@lo.gmane.org; Fri, 30 Jul 2010 16:51:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932233Ab0G3Oum (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Jul 2010 10:50:42 -0400
Received: from smtp132.iad.emailsrvr.com ([207.97.245.132]:53626 "EHLO
	smtp132.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932228Ab0G3Ouk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jul 2010 10:50:40 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp33.relay.iad1a.emailsrvr.com (SMTP Server) with ESMTP id 67A5D30251;
	Fri, 30 Jul 2010 10:50:39 -0400 (EDT)
X-Virus-Scanned: OK
Received: from [192.168.1.136] (unknown [208.85.112.101])
	(Authenticated sender: mbranchaud@xiplink.com)
	by smtp33.relay.iad1a.emailsrvr.com (SMTP Server) with ESMTPSA id 342E730162;
	Fri, 30 Jul 2010 10:50:39 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.11) Gecko/20100713 Thunderbird/3.0.6
In-Reply-To: <1280323784-27462-1-git-send-email-Matthieu.Moy@imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152245>

On 10-07-28 09:29 AM, Matthieu Moy wrote:
> The typical usage pattern would be to run a test (or simply a compilation
> command) at given points in history.
> 
> The shell command is ran, and the rebase is stopped when the command
> fails, to give the user an opportunity to fix the problem before
> continuing with "git rebase --continue".
> 
> Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
> ---
> 
> The name of the command may be subject to discussions. I've chosen
> "run", but maybe "shell" would be OK too. In both cases, it doesn't
> allow the one-letter version since both "r" and "s" are already used.

"exec" with one-letter "x"?

		M.
