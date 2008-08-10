From: "Gustavo Sverzut Barbieri" <barbieri@profusion.mobi>
Subject: Re: [PATCH 0/2] gitweb use sections
Date: Sun, 10 Aug 2008 16:45:14 -0300
Message-ID: <b1f2b8c40808101245j2942dc70sa429cca05c1bb5c7@mail.gmail.com>
References: <1217298868-16513-1-git-send-email-barbieri@profusion.mobi>
	 <b1f2b8c40807311243i5689683avcc3c3c91e4e6a900@mail.gmail.com>
	 <20080731203250.GO10151@machine.or.cz>
	 <b1f2b8c40807311358k4132ba8bw931279d7a6a7bcb5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Jakub Narebski" <jnareb@gmail.com>
To: "Petr Baudis" <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Sun Aug 10 21:46:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSGrt-0006Bu-2U
	for gcvg-git-2@gmane.org; Sun, 10 Aug 2008 21:46:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753532AbYHJTpR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Aug 2008 15:45:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753502AbYHJTpR
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Aug 2008 15:45:17 -0400
Received: from fg-out-1718.google.com ([72.14.220.156]:30279 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753436AbYHJTpQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Aug 2008 15:45:16 -0400
Received: by fg-out-1718.google.com with SMTP id 19so888289fgg.17
        for <git@vger.kernel.org>; Sun, 10 Aug 2008 12:45:14 -0700 (PDT)
Received: by 10.86.60.15 with SMTP id i15mr6696100fga.43.1218397514235;
        Sun, 10 Aug 2008 12:45:14 -0700 (PDT)
Received: by 10.86.86.16 with HTTP; Sun, 10 Aug 2008 12:45:14 -0700 (PDT)
In-Reply-To: <b1f2b8c40807311358k4132ba8bw931279d7a6a7bcb5@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91880>

Yet another "ping" on this topic, news?

On Thu, Jul 31, 2008 at 5:58 PM, Gustavo Sverzut Barbieri
<barbieri@profusion.mobi> wrote:
> On Thu, Jul 31, 2008 at 5:32 PM, Petr Baudis <pasky@suse.cz> wrote:
>>  Hi,
>>
>> On Thu, Jul 31, 2008 at 04:43:35PM -0300, Gustavo Sverzut Barbieri wrote:
>>> Since nobody replied and I missed some gitweb guys in CC, I'm adding
>>> Petr and Jakub, as some guys said on IRC.
>>>
>>> Have anyone tried this patch, any problems?
>>
>>  sorry, I have it in my review queue. At first pass it was looking
>> good, but I wanted to look at it better before commenting.
>
> no problem, just to see it was noticed or not :-)
>
>
>>  One thing I'm wondering about is how to make this stuff configurable,
>> since I'm not very comfortable with adding more "unbound" configuration
>> variables and would rather prefer stuff to be added to the $features
>> array... I'm not at all sure about my own sentiment here, however.
>
> Path comparison (first patch), Sections (second), both?
>
> I know path comparison can be a performance hit on large listings on
> sites with heavy traffic. However, I don't see many people accessing
> the projects page at the same time for long periods, it's not like
> slashdot... people mostly use it to know about repositories and then
> use git to track it.
>    The slowness is due O(n^2) worst case of sort and each step is not
> a bit heavier since it need to split path into components and walk
> these. Maybe cache the split?
>
> --
> Gustavo Sverzut Barbieri
> http://profusion.mobi embedded systems
> --------------------------------------
> MSN: barbieri@gmail.com
> Skype: gsbarbieri
> Mobile: +55 (19) 9225-2202
>



-- 
Gustavo Sverzut Barbieri
http://profusion.mobi embedded systems
--------------------------------------
MSN: barbieri@gmail.com
Skype: gsbarbieri
Mobile: +55 (19) 9225-2202
