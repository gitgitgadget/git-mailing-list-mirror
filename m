From: FusionX86 <fusionx86@gmail.com>
Subject: Re: git p4 clone - HEAD + partial history
Date: Tue, 12 May 2015 14:23:20 -0600
Message-ID: <CAFcBi89+FuvB=VF3nCDy7_xrwz=Of_omkCn35MdXBwhy6VckjQ@mail.gmail.com>
References: <CAFcBi8_sARUkD2iDeto2CXr1vOm473aOSbj9dCiERTj51ot59A@mail.gmail.com>
	<55525A99.9070702@diamand.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Users <git@vger.kernel.org>
To: Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Tue May 12 22:23:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YsGi6-0005LW-AH
	for gcvg-git-2@plane.gmane.org; Tue, 12 May 2015 22:23:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753866AbbELUXW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 May 2015 16:23:22 -0400
Received: from mail-qc0-f176.google.com ([209.85.216.176]:34363 "EHLO
	mail-qc0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753633AbbELUXV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 May 2015 16:23:21 -0400
Received: by qcyk17 with SMTP id k17so11395008qcy.1
        for <git@vger.kernel.org>; Tue, 12 May 2015 13:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Cud2iZuihtjDQ7DX2I/Nwz9R5DsPsYArt+f+fKUz2Fc=;
        b=zQZkc7q9d8AO+dLpRh7vv82q7XTgwgFjNQIR1HZCMEnTa9pMwSiaQ5ZVuB5l7Wh3dM
         NI8hcLQX8257t+b7UGt4IprXWB+lBTmrS2LkQPZ6biBEZI18Mx3jZInuISAvDLdo55pL
         IvlKnm5P6bkk9sb5A0xMSB517THwM+80565IJEX6afxe/a3ZSn297QgdLfVhxAH31Tvr
         0lVqAxdfwbROt+WlYQf/USdofpLc9FDdTSTKIdimPbsZfJnjtPPybCzTYPndtIsDjV3v
         wFgkl+t8ZvlV8nRuJNqYsi9HFmdAJ3/DBZVrc942dJ4wjPAMjXfgwX1Ss5AUmu7KEoEb
         Hrsg==
X-Received: by 10.55.16.146 with SMTP id 18mr2668954qkq.39.1431462200653; Tue,
 12 May 2015 13:23:20 -0700 (PDT)
Received: by 10.140.93.4 with HTTP; Tue, 12 May 2015 13:23:20 -0700 (PDT)
In-Reply-To: <55525A99.9070702@diamand.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268880>

Thanks Luke! I'll give that a shot.

On Tue, May 12, 2015 at 1:55 PM, Luke Diamand <luke@diamand.org> wrote:
> On 12/05/15 20:31, FusionX86 wrote:
>>
>> Hello,
>>
>> I'm migrating my company from Perforce to Git. There is history in
>> Perforce that goes back to 2006 and I'd like to migrate it with some,
>> but not all of the history. I'm not having luck so far.
>>
>>  From what I see, a simple git p4 clone grabs HEAD only. Using @all
>> grabs all history and is way too much to migrate. I have tried using
>> //depot/folder@2015/01/01,@all when cloning, but it doesn't grab the
>> current stuff in HEAD.
>>
>> Is it possible to grab what is currently in HEAD and the last few
>> months of history only?
>
>
> What I've done in the past is just find a commit that's about the right
> date, and clone from there.
>
> i.e.
>
> $ git p4 clone //depot/folder/...@12345
> $ git p4 sync
>
> The usual problem I have after that is that P4 repos can get very large, and
> the process can quite time consuming....
>
>> --
>> To unsubscribe from this list: send the line "unsubscribe git" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
