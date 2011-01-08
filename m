From: Tomas Carnecky <tom@dbservice.com>
Subject: Re: Creating CVS-style patch headers with git-diff
Date: Sat, 08 Jan 2011 16:26:09 +0100
Message-ID: <4D288211.3040806@dbservice.com>
References: <AANLkTinmq=3kJmtSVutf7dHAQ0QL3fr9_E3hZ7gDe1JY@mail.gmail.com>	<4D284F57.2000808@dbservice.com> <AANLkTinx9qM=fjH53UodY0G870Ne3wpFiFEgEGNXxOY7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: David Chanters <david.chanters@googlemail.com>
X-From: git-owner@vger.kernel.org Sat Jan 08 16:26:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PbagT-0002Au-1G
	for gcvg-git-2@lo.gmane.org; Sat, 08 Jan 2011 16:26:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752886Ab1AHP0U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Jan 2011 10:26:20 -0500
Received: from office.neopsis.com ([78.46.209.98]:50893 "EHLO
	office.neopsis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752850Ab1AHP0U (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Jan 2011 10:26:20 -0500
X-Spam-Status: No, hits=0.0 required=5.0
	tests=AWL: 0.080,BAYES_00: -1.665,TOTAL_SCORE: -1.585,autolearn=ham
X-Spam-Level: 
Received: from calvin.local ([62.65.141.13])
	(authenticated user tom@dbservice.com)
	by office.neopsis.com
	(using TLSv1/SSLv3 with cipher AES256-SHA (256 bits));
	Sat, 8 Jan 2011 16:26:10 +0100
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; en-US; rv:1.9.2.8) Gecko/20100802 Thunderbird/3.1.2
In-Reply-To: <AANLkTinx9qM=fjH53UodY0G870Ne3wpFiFEgEGNXxOY7@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164824>

  On 1/8/11 2:43 PM, David Chanters wrote:
> Would the presense of the other meta-data, such as the "diff --git"
> line as well as the "Index" line cause any problems when applying this
> patch in CVS (I suppose now, my question doesn't have to apply to CVS

I don't know, you tell me. I've never used CVS.

> at all, more likely it will apply to any file sets)?  I am not sure
> how GNU Patch uses this meta information, and I assume "git diff" adds
> it for a good reason.

gnu patch most likely doesn't use the index line and ignores all the git 
specific additions to the diff format.

tom
