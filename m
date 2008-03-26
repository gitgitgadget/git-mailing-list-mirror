From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [PATCH] mktag.c: improve verification of tagger field and tests
Date: Wed, 26 Mar 2008 11:37:46 -0500
Message-ID: <47EA7BDA.9070109@nrlssc.navy.mil>
References: <1206490795-13247-1-git-send-email-casey@nrlssc.navy.mil>	 <47E99B98.1060506@nrlssc.navy.mil> <1b46aba20803260421t4db4987gc6fc8b2e556032e0@mail.gmail.com> <47EA7927.9060201@nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Carlos Rica <jasampler@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 26 17:40:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JeYe3-0007t4-97
	for gcvg-git-2@gmane.org; Wed, 26 Mar 2008 17:38:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759012AbYCZQhv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Mar 2008 12:37:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758946AbYCZQhv
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Mar 2008 12:37:51 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:39231 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758550AbYCZQhu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Mar 2008 12:37:50 -0400
Received: from starfish.gems.nrlssc.navy.mil (localhost [127.0.0.1])
	by mail.nrlssc.navy.mil (8.13.7/8.13.7) with ESMTP id m2QGbkNE004989;
	Wed, 26 Mar 2008 11:37:47 -0500
Received: from tick.nrlssc.navy.mil ([128.160.25.48]) by starfish.gems.nrlssc.navy.mil with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 26 Mar 2008 11:37:46 -0500
User-Agent: Thunderbird 2.0.0.9 (X11/20071031)
In-Reply-To: <47EA7927.9060201@nrlssc.navy.mil>
X-OriginalArrivalTime: 26 Mar 2008 16:37:46.0692 (UTC) FILETIME=[B8E7C040:01C88F5F]
X-TM-AS-Product-Ver: : ISVW-6.0.0.2339-5.0.0.1023-15806001
X-TM-AS-Result: : Yes--15.644600-0-31-1
X-TM-AS-Category-Info: : 31:0.000000
X-TM-AS-MatchedID: : =?us-ascii?B?MTUwNTY3LTcwMDA3NS0xMzkw?=
	=?us-ascii?B?MTAtODMwOTQwLTcwMDE2MC03MDE2MDQtNzA1MTc4LTcwMTIwMi03?=
	=?us-ascii?B?MDY4OTEtNzAzMTU3LTcwNjE1OS03MDI3OTEtNzAwNjMwLTcwMDYw?=
	=?us-ascii?B?Ni03MDE0NTUtNzAxMjk4LTE4NzA2Ny03MDA3NTYtMTM2MDcwLTcx?=
	=?us-ascii?B?MDk4OS03MDA2OTMtNzA0OTI3LTcwMzc4OC0xNDgwMzktMTQ4MDUx?=
	=?us-ascii?B?LTIwMDQw?=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78290>

Brandon Casey wrote:
> Carlos Rica wrote:
>> On Wed, Mar 26, 2008 at 1:40 AM, Brandon Casey <casey@nrlssc.navy.mil> wrote:
>>>  Well, since I looked at this code and used it in filter-branch, I figured I
>>>  should fix the verification code for the tagger field (even though it's
>>>  probably dieing soon).
>>>
>>>  I'm thinking this utility should be fairly strict about the format it accepts.
>> Why not using git-tag to make tags in filter-branch?

I replied, and then I thought, maybe you didn't notice that patch I submitted
for filter-branch.

So, to clarify, I am not using mktag at a user-level. i.e. I am not using it in a
script that I supplied _to_ filter-branch. I added a call to it from _within_
filter-branch so that the "object" part of tag objects can be retained when filtering.

-brandon
