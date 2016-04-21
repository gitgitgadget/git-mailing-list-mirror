From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: git rebase -i without altering the committer date
Date: Thu, 21 Apr 2016 07:23:26 +0200
Message-ID: <571863CE.6090002@kdbg.org>
References: <etPan.5717e605.4004d424.12d1@sjackman03-imac.phage.bcgsc.ca>
 <87ega0eyvy.fsf@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Andreas Schwab <schwab@linux-m68k.org>,
	Shaun Jackman <sjackman@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 21 07:23:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1at75R-0007WH-9N
	for gcvg-git-2@plane.gmane.org; Thu, 21 Apr 2016 07:23:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751565AbcDUFX3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Apr 2016 01:23:29 -0400
Received: from bsmtp1.bon.at ([213.33.87.15]:42539 "EHLO bsmtp1.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751282AbcDUFX2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Apr 2016 01:23:28 -0400
Received: from dx.site (unknown [93.83.142.38])
	by bsmtp1.bon.at (Postfix) with ESMTPSA id 3qr6bf60ysz5tlM;
	Thu, 21 Apr 2016 07:23:26 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.site (Postfix) with ESMTP id 7CFBE5232;
	Thu, 21 Apr 2016 07:23:26 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.0
In-Reply-To: <87ega0eyvy.fsf@linux-m68k.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292095>

Am 20.04.2016 um 23:47 schrieb Andreas Schwab:
> Shaun Jackman <sjackman@gmail.com> writes:
>
>> I'd like to insert a commit between two commits without changing
>> the committer date or author date of that commit or the subsequent
>> commits.
>
> The easiest way to implement that is to add a graft to redirect the
> parent of the second commit to the inserted commit, then use git
> filter-branch to make the graft permanent.

This only inserts a new project state, but does not propagate the 
changes brought in by the new commit to the subsequent commits. This 
propagation of changes could also be done with filter-branch, but it may 
be difficult depending on circumstances.

-- Hannes
