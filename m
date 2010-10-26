From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: [PATCH/RFC] Make git-completion Bash 4 compatible.
Date: Tue, 26 Oct 2010 10:14:33 -0400
Message-ID: <4CC6E249.7040204@xiplink.com>
References: <20101026095319.669c0d69@montecarlo.grandprix.int>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	=?ISO-8859-1?Q?SZEDER_G=E1bor?= <szeder@ira.uka.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Brian Gernhardt <brian@gernhardtsoftware.com>,
	Kevin Ballard <kevin@sb.org>,
	Mathias Lafeldt <misfire@debugon.org>
To: Peter van der Does <peter@avirtualhome.com>
X-From: git-owner@vger.kernel.org Tue Oct 26 16:14:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PAkIQ-0000Ep-Ju
	for gcvg-git-2@lo.gmane.org; Tue, 26 Oct 2010 16:14:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753262Ab0JZOOc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Oct 2010 10:14:32 -0400
Received: from smtp162.iad.emailsrvr.com ([207.97.245.162]:58244 "EHLO
	smtp162.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751018Ab0JZOOc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Oct 2010 10:14:32 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp46.relay.iad1a.emailsrvr.com (SMTP Server) with ESMTP id 5EFC1E8D19;
	Tue, 26 Oct 2010 10:14:31 -0400 (EDT)
X-Virus-Scanned: OK
Received: by smtp46.relay.iad1a.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id EA8F1E82B7;
	Tue, 26 Oct 2010 10:14:30 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.11) Gecko/20101006 Thunderbird/3.1.5
In-Reply-To: <20101026095319.669c0d69@montecarlo.grandprix.int>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159992>

On 10-10-26 09:53 AM, Peter van der Does wrote:
> 
> The completion script does not work as expected under Bash 4.
> Bash: 3
> output:
> $ git log --pretty=<tab><tab>
> email     full      medium    raw
> format:   fuller    oneline   short
> 
> Bash: 4
> output:
> $ git log --pretty=<tab><tab>
> .bash_logout         .local/
> .bash_profile        Music/
> --More--

This patch also fixes my remote-refs issue.

"git push origin HEAD:ba<tab><tab>" does the Right Thing (with bash 3 & 4).

Thanks!

		M.
