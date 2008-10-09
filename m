From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: [PATCH] guilt: add git commit level versioning
Date: Thu, 09 Oct 2008 12:13:14 -0400
Message-ID: <48EE2D9A.20205@windriver.com>
References: <1223431722-12259-1-git-send-email-paul.gortmaker@windriver.com> <20081009155445.GF27647@josefsipek.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Josef 'Jeff' Sipek" <jeffpc@josefsipek.net>
X-From: git-owner@vger.kernel.org Thu Oct 09 18:15:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kny9p-0004Yr-TS
	for gcvg-git-2@gmane.org; Thu, 09 Oct 2008 18:14:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752985AbYJIQNX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Oct 2008 12:13:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753080AbYJIQNX
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Oct 2008 12:13:23 -0400
Received: from mail.windriver.com ([147.11.1.11]:36306 "EHLO mail.wrs.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752939AbYJIQNX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Oct 2008 12:13:23 -0400
Received: from ALA-MAIL03.corp.ad.wrs.com (ala-mail03 [147.11.57.144])
	by mail.wrs.com (8.13.6/8.13.6) with ESMTP id m99GDF9I000144;
	Thu, 9 Oct 2008 09:13:15 -0700 (PDT)
Received: from ala-mail06.corp.ad.wrs.com ([147.11.57.147]) by ALA-MAIL03.corp.ad.wrs.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Thu, 9 Oct 2008 09:13:15 -0700
Received: from [128.224.146.65] ([128.224.146.65]) by ala-mail06.corp.ad.wrs.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Thu, 9 Oct 2008 09:13:15 -0700
User-Agent: Thunderbird 2.0.0.17 (X11/20080925)
In-Reply-To: <20081009155445.GF27647@josefsipek.net>
X-OriginalArrivalTime: 09 Oct 2008 16:13:15.0530 (UTC) FILETIME=[EF66FEA0:01C92A29]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97868>

Josef 'Jeff' Sipek wrote:
> On Tue, Oct 07, 2008 at 10:08:42PM -0400, Paul Gortmaker wrote:
>   
>> Shamelessly steal the dynamic versioning goodies from git
>> itself.  Now when you do "guilt --version" you can expect to
>> see things like:
>>
>> 	Guilt version 0.31.2.14.gece1.dirty
>>
>> assuming you've 14 commits since 0.31.2 and also some changes
>> that you've not committed yet.
>>     
>
> Good idea. I've been pondering how to do this a while back, but never got
> around to actually do it.
>
> One comment: Why not keep the default version in guilt? You're running sed
> on it anyway.  This makes releasing identical to what it was before the
> patch:
> 	<edit guilt to reflect new version, commit>
> 	git tag -u abcdef v0.xy
> 	git archive --tar v0.xy | gzip -9 > guilt-0.xy.tar.gz
>
> Additionally, things won't "break" for folks running right out of the git
> repo - I just add the git repo dir to my $PATH.
>   

Sounds reasonable to me.  I'm about to disappear for a 4 day weekend
(Cdn Thanksgiving) so I won't be able to do that until next Tuesday at
the earliest though.

P.

> Josef 'Jeff' Sipek.
>
>   
