From: shawn wilson <ag4ve.us@gmail.com>
Subject: Re: Move commits not in origin to a branch
Date: Mon, 2 Mar 2015 10:43:32 -0500
Message-ID: <CAH_OBicLoSvnKx=2Y1oHCbXK+mUsKpg-TNwMfiaYs816kfsrwA@mail.gmail.com>
References: <CAH_OBicENXL967L4LubDzrqq2qxuZSqye3o6SPAq6oKM0=94Og@mail.gmail.com>
 <54F479A1.300@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Mar 02 16:43:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YSSVi-0000U2-6Q
	for gcvg-git-2@plane.gmane.org; Mon, 02 Mar 2015 16:43:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754124AbbCBPny (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Mar 2015 10:43:54 -0500
Received: from mail-yh0-f54.google.com ([209.85.213.54]:41811 "EHLO
	mail-yh0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753910AbbCBPnx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Mar 2015 10:43:53 -0500
Received: by yhaf10 with SMTP id f10so14966339yha.8
        for <git@vger.kernel.org>; Mon, 02 Mar 2015 07:43:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=cAGKVaE/JGAzIsCOmiK0byYbLdc7hFkUCIQK5ORm+B4=;
        b=eVruIg6bMsgJV7esE6QkoMPv6QDhd5DNz9czafEBRyDjHp4z6m5yZOaN6EvBwAjVUo
         QdciQYHKhRTTC76VDM249BOemot5qzYQ3UKpTm+tyiXf9xHQMhoj2OSxv7xr2f/0/iBw
         sPyhoOONMmFw6IBkJQH8eIOeWHEVGow+iAO7SBfSdAXJx5EOXirGEgZCHjIG/JeA0VIz
         wtvDjKkti32fi6kCqP45ukoRGP55HOjsFISV2RVEGetz7rad5mt7yQ9KXSjf571YqoR0
         fMGTC5Lo9d5iI6CaouXX6+3LSFbTaNM7XpQjI7KEnLlzQyFctS4n2QHlHYooWeW1aAfQ
         RKqw==
X-Received: by 10.236.66.33 with SMTP id g21mr27148475yhd.72.1425311032949;
 Mon, 02 Mar 2015 07:43:52 -0800 (PST)
Received: by 10.170.205.210 with HTTP; Mon, 2 Mar 2015 07:43:32 -0800 (PST)
In-Reply-To: <54F479A1.300@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264604>

On Mon, Mar 2, 2015 at 9:54 AM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> shawn wilson venit, vidit, dixit 02.03.2015 14:25:
>> How do I move commits I haven't pushed into a new branch?
>>
>>  % git log origin..master --pretty=format:'%h'
>> f7d3a19
>> 1f186c9
>> 66d99f6
>>
>> Which I'd like to be in a new branch.
>>
>
> Do you want them to be on the new branch as they are, i.e. as commits
> built on top of master? Then
>
> git branch mybranch master
>

Oh cool, I think that's what I wanted. I didn't realize it was that
easy - I said screw it and went and pushed them, but... for next time
(or I'll stop being stupid and work in a branch from now on).

Thanks
