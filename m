From: Jon Loeliger <jdl@freescale.com>
Subject: Re: [PATCH 4/3] bisect: use a detached HEAD to bisect
Date: Fri, 23 May 2008 10:14:49 -0500
Message-ID: <4836DF69.4060609@freescale.com>
References: <20080523012857.acce6457.chriscool@tuxfamily.org> <7v3ao9twfa.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Christian Couder <chriscool@tuxfamily.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 23 17:16:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JzZ0b-0000oU-KU
	for gcvg-git-2@gmane.org; Fri, 23 May 2008 17:16:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754991AbYEWPPt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 May 2008 11:15:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755157AbYEWPPt
	(ORCPT <rfc822;git-outgoing>); Fri, 23 May 2008 11:15:49 -0400
Received: from az33egw02.freescale.net ([192.88.158.103]:44170 "EHLO
	az33egw02.freescale.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754727AbYEWPPs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 May 2008 11:15:48 -0400
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id m4NFFPIt028522;
	Fri, 23 May 2008 08:15:26 -0700 (MST)
Received: from [10.214.73.219] (mvp-10-214-73-219.am.freescale.net [10.214.73.219])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id m4NFFLDI004196;
	Fri, 23 May 2008 10:15:22 -0500 (CDT)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <7v3ao9twfa.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82715>

Junio C Hamano wrote:
> Christian Couder <chriscool@tuxfamily.org> writes:
> 
>> When "git bisect" was first written, it was not possible to
>> checkout a detached HEAD. The detached feature appeared latter.
>> ...
>> This patch makes "git bisect" checkout revisions to be tested on
>> a detached HEAD. This simplifies the code a bit.
> 
> Yay!!
> 
> One potential worry/downside is "bisect visualize".  Because <bisect>
> branch was used for bisection, the _current_ commit has always been
> indicated with a label.  HEAD would not get any special label in gitk,
> would it?

Hrm.  This seems like a potential issue to me as I occasionally
do want to view where it is and possibly adjust it up or down a
few commits depending on context.

Perhaps a "git bisect addfoo" sort of command is needed?  The goal
would be to "add some form of {branch,label,tag}" so it could be named,
seen and possibly moved.

jdl
