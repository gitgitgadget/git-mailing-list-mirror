From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: Question about your git habits
Date: Sat, 23 Feb 2008 05:39:27 +0100
Message-ID: <47BFA37F.10806@keyaccess.nl>
References: <200802221837.37680.chase.venters@clientec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org, git@vger.kernel.org
To: Chase Venters <chase.venters@clientec.com>
X-From: git-owner@vger.kernel.org Sat Feb 23 05:37:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JSm8c-0008Qa-3I
	for gcvg-git-2@gmane.org; Sat, 23 Feb 2008 05:37:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752667AbYBWEgx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Feb 2008 23:36:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752267AbYBWEgw
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Feb 2008 23:36:52 -0500
Received: from smtpq1.groni1.gr.home.nl ([213.51.130.200]:36805 "EHLO
	smtpq1.groni1.gr.home.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751802AbYBWEgv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Feb 2008 23:36:51 -0500
Received: from [213.51.130.190] (port=60376 helo=smtp1.groni1.gr.home.nl)
	by smtpq1.groni1.gr.home.nl with esmtp (Exim 4.60)
	(envelope-from <rene.herman@keyaccess.nl>)
	id 1JSm81-0005MP-LQ; Sat, 23 Feb 2008 05:36:49 +0100
Received: from cc334381-b.groni1.gr.home.nl ([82.73.12.33]:47613 helo=[192.168.0.3])
	by smtp1.groni1.gr.home.nl with esmtp (Exim 4.60)
	(envelope-from <rene.herman@keyaccess.nl>)
	id 1JSm81-0006Fi-9e; Sat, 23 Feb 2008 05:36:49 +0100
User-Agent: Thunderbird 2.0.0.9 (X11/20071031)
In-Reply-To: <200802221837.37680.chase.venters@clientec.com>
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74795>

On 23-02-08 01:37, Chase Venters wrote:

> Or perhaps you create a temporary topical branch for each thing you are 
> working on, and commit arbitrary changes then checkout another branch
> when you need to change gears, finally --squashing the intermediate
> commits when a particular piece of work is done?

No very specific advice to give but this is what I do and then pull all 
(compilable) topic branches into a "local" branch for complation. Just 
wanted to remark that a definite downside is that switching branches a lot 
also touches the tree a lot and hence tends to trigger quite unwelcome 
amounts of recompiles. Using ccache would proably be effective in this 
situation but I keep neglecting to check it out...

Rene
