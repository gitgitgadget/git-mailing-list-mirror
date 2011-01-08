From: Tomas Carnecky <tom@dbservice.com>
Subject: Re: Creating CVS-style patch headers with git-diff
Date: Sat, 08 Jan 2011 16:51:32 +0100
Message-ID: <4D288804.2050204@dbservice.com>
References: <AANLkTinmq=3kJmtSVutf7dHAQ0QL3fr9_E3hZ7gDe1JY@mail.gmail.com>	<4D284F57.2000808@dbservice.com>	<AANLkTinx9qM=fjH53UodY0G870Ne3wpFiFEgEGNXxOY7@mail.gmail.com>	<m2vd1za0af.fsf@igel.home> <AANLkTi=_YdTsvFboQAj447SUtcxrVhM18QkvSVdpvdMJ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Andreas Schwab <schwab@linux-m68k.org>, git@vger.kernel.org
To: David Chanters <david.chanters@googlemail.com>
X-From: git-owner@vger.kernel.org Sat Jan 08 16:52:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pbb5Q-0007dS-Ej
	for gcvg-git-2@lo.gmane.org; Sat, 08 Jan 2011 16:52:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753141Ab1AHPvl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Jan 2011 10:51:41 -0500
Received: from office.neopsis.com ([78.46.209.98]:45771 "EHLO
	office.neopsis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753012Ab1AHPvl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Jan 2011 10:51:41 -0500
X-Spam-Status: No, hits=0.0 required=5.0
	tests=AWL: 0.079,BAYES_00: -1.665,TOTAL_SCORE: -1.586,autolearn=ham
X-Spam-Level: 
Received: from calvin.local ([62.65.141.13])
	(authenticated user tom@dbservice.com)
	by office.neopsis.com
	(using TLSv1/SSLv3 with cipher AES256-SHA (256 bits));
	Sat, 8 Jan 2011 16:51:32 +0100
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; en-US; rv:1.9.2.8) Gecko/20100802 Thunderbird/3.1.2
In-Reply-To: <AANLkTi=_YdTsvFboQAj447SUtcxrVhM18QkvSVdpvdMJ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164826>

  On 1/8/11 4:35 PM, David Chanters wrote:
> Sorry about that, that's poor wording on my part.  I don't mean "CVS
> won't barf" -- I meant that GNU Patch can still apply the patch
> without the meta-data referencing git still.  I think though this
> "--no-prefix" option might just do it.

Update your gnu patch. Never versions know how to handle the git 
specific metadata (gnu patch simply ignores it).

And the a/, b/ prefix is *not* git specific. Pretty much all versions of 
a patch program know how to deal with that, you just need to use -p1 on 
the commandline.

tom
