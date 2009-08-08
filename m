From: Teemu Likonen <tlikonen@iki.fi>
Subject: Re: [PATCH v2] push: point to 'git pull' and 'git push --force' in case of non-fast forward
Date: Sat, 08 Aug 2009 11:35:38 +0300
Message-ID: <87prb6r9d1.fsf@iki.fi>
References: <1249579933-1782-1-git-send-email-Matthieu.Moy@imag.fr>
	<1249717868-10946-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Sat Aug 08 10:35:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZhP5-0008DE-Ku
	for gcvg-git-2@gmane.org; Sat, 08 Aug 2009 10:35:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754206AbZHHIfn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Aug 2009 04:35:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753153AbZHHIfn
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Aug 2009 04:35:43 -0400
Received: from mta-out.inet.fi ([195.156.147.13]:32978 "EHLO jenni2.inet.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752437AbZHHIfm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Aug 2009 04:35:42 -0400
Received: from mithlond.arda.local (80.220.180.181) by jenni2.inet.fi (8.5.014)
        id 4A777091002A5CE0; Sat, 8 Aug 2009 11:35:40 +0300
Received: from dtw by mithlond.arda.local with local (Exim 4.69)
	(envelope-from <tlikonen@iki.fi>)
	id 1MZhOs-0006vM-Vc; Sat, 08 Aug 2009 11:35:38 +0300
In-Reply-To: <1249717868-10946-1-git-send-email-Matthieu.Moy@imag.fr>
	(Matthieu Moy's message of "Sat, 8 Aug 2009 09:51:08 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125264>

On 2009-08-08 09:51 (+0200), Matthieu Moy wrote:
> 'git push' failing because of non-fast forward is a very common situation,
> and a beginner does not necessarily understand "fast forward" immediately.

> +		if (nonfastforward) {
> +			printf("Push was rejected because it would not result in a fast forward:\n"
> +			       "Merge in the remote changes (using git pull) before pushing yours,\n"
> +			       "or use git push --force to discard the remote changes.\n"
> +			       "See 'non-fast forward' section of 'git push --help' for details.\n");
> +		}

I'd like to add that some projects that use Git in (partially)
centralized manner prefer "git pull --rebase" before "git push".
