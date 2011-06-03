From: Neal Kreitzinger <nkreitzinger@gmail.com>
Subject: Re: pre-commit hook to reject whitespace
Date: Fri, 03 Jun 2011 18:58:31 -0500
Message-ID: <isbsf8$6id$1@dough.gmane.org>
References: <isbqsf$vh8$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 04 01:58:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QSeGQ-0000Vj-Uw
	for gcvg-git-2@lo.gmane.org; Sat, 04 Jun 2011 01:58:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753571Ab1FCX6q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jun 2011 19:58:46 -0400
Received: from lo.gmane.org ([80.91.229.12]:47522 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752311Ab1FCX6q (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jun 2011 19:58:46 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1QSeGJ-0000Ul-TT
	for git@vger.kernel.org; Sat, 04 Jun 2011 01:58:43 +0200
Received: from 67.63.162.200 ([67.63.162.200])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 04 Jun 2011 01:58:43 +0200
Received: from nkreitzinger by 67.63.162.200 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 04 Jun 2011 01:58:43 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: 67.63.162.200
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.15) Gecko/20110303 Thunderbird/3.1.9
In-Reply-To: <isbqsf$vh8$1@dough.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175044>

On 6/3/2011 6:31 PM, Neal Kreitzinger wrote:
> The reference manuals state in the hooks documentation that the pre-commit
> hook sample will reject whitespace only changes.  However, the
> pre-commit.sample in the 1.7.1 and 1.7.5.4 downloads do not appear to do
> this (I'm new to linux scripts).  The appear to only reject non-ascii
> filenames.  Does someone have a pre-commit hook example I can use to reject
> whitespace-only changes?  Thanks!
>
As someone kindly pointed out, the documentation actually says:
"The default 'pre-commit' hook, when enabled, catches introduction of 
lines with trailing whitespaces and aborts the commit when such a line 
is found."

I'm not seeing this functionality in the pre-commit.sample for 1.7.1 or 
1.7.5.4.

v/r,
neal
