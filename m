From: Stefan Beller <sbeller@google.com>
Subject: Re: About my git workflow; maybe it's useful for others
Date: Wed, 22 Apr 2015 13:38:31 -0700
Message-ID: <CAGZ79kb2z+CbHhqrB9xW85n_33V8=iYV3jGf9pCNDX181tm3JA@mail.gmail.com>
References: <CAGZ79kaK-uRAE9-rH=-5t8djAw5e9rwkPjZuw=+XWEq+V6R5Yg@mail.gmail.com>
	<CACnwZYf6-Fh0JZeJZ4j3QOyqRF_2-NKJB06Wh20ipsRmrRN+qw@mail.gmail.com>
	<CAGZ79ka1U8SP-7b_Jbm--1j1sz0iHKd+v-WNCASAXH+kystefA@mail.gmail.com>
	<CACnwZYcD7ryJqM+85wxka+ViqOfy51bOgyetUEdgY1pcQPJv=A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Thiago Farina <tfransosi@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 22 22:38:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yl1Pq-0001z2-15
	for gcvg-git-2@plane.gmane.org; Wed, 22 Apr 2015 22:38:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753830AbbDVUid (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Apr 2015 16:38:33 -0400
Received: from mail-ie0-f172.google.com ([209.85.223.172]:33229 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753505AbbDVUic (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Apr 2015 16:38:32 -0400
Received: by iecrt8 with SMTP id rt8so46842092iec.0
        for <git@vger.kernel.org>; Wed, 22 Apr 2015 13:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=MmZGVB44Hv4JbIpB1CB84UUfueXHuMhWz5/P6+YEe+Q=;
        b=gd9kC+4zocX/x+p7pi8TH6KEi6f0IzxsqIHkDFk37gv4tcbfnDXR72Cum+/RDDgUsw
         wahRBxjyTsgMSPaTtyK0HK8ObkAmuMvNQYNGj+ekG9zMhQ3p586Z6KsS700KK7lnYtxz
         7cDdKLm+yrapgPzVaKfPysQgmYiTO8VJWzwWjndBw8iRt2ellBGidQv2TWKtnpIl2pdI
         idYHFWzuD6WY7pWL+mVCN9ylVrrgNYXtmjVQVPqFM5tTlgZIRYYJoISDabM0Z2NANP0y
         RtP2iTEwF4ROlVZiyOGGJ+c0lsG75yBEY8d+pd+g/zgJ7qUEtUYFimh15rRQgrEQoJzS
         gabw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=MmZGVB44Hv4JbIpB1CB84UUfueXHuMhWz5/P6+YEe+Q=;
        b=ErTN7wI5L0K2xEyXm90tuHAPnsYMomfpLl1RshGJ0HcuHKqVw+11nc8AzJWhKOKGKD
         ebuDJrFoS5AqQqzxUGS/Zk+e4OQujeyxq/29W5vx0YdDrHfcNLHx1chwcTvJ9jEi03HG
         eXsYtHgQIBZQy9uC65+3iumkad0LIsXPxryRfqvrZmVf4Jb68bvWmLiYxs6BDK6sdwbN
         d9ZC4hehw/xGA+EFSjxmr70ksG/LBYNOYBP1WeDIxc9Zw4l+me3P0LkSU0e1TuBUqi/7
         SJ5WGYIyp28oIJN+L6pJC2WrOw4/UjxCx3ZNVjzcKeJ5fsa3YB9SMra5/kOTignWr1hU
         VndA==
X-Gm-Message-State: ALoCoQmG0IepoMwqQ92D4JFCYOCauyFM/nluGDPft0SfL0otLw9FwUbaM3o5UehDCLatU5p/wdAq
X-Received: by 10.50.117.4 with SMTP id ka4mr7199607igb.10.1429735111729; Wed,
 22 Apr 2015 13:38:31 -0700 (PDT)
Received: by 10.107.46.22 with HTTP; Wed, 22 Apr 2015 13:38:31 -0700 (PDT)
In-Reply-To: <CACnwZYcD7ryJqM+85wxka+ViqOfy51bOgyetUEdgY1pcQPJv=A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267639>

On Wed, Apr 22, 2015 at 12:57 PM, Thiago Farina <tfransosi@gmail.com> wrote:
> On Wed, Apr 22, 2015 at 4:50 PM, Stefan Beller <sbeller@google.com> wrote:
>> On Wed, Apr 22, 2015 at 12:38 PM, Thiago Farina <tfransosi@gmail.com> wrote:
>>>>
>>> IMO, sending email is the easiest part.
>>>
>>> The hard begins when you have to edit your patch and resend with the
>>> reviewers' feedback incorporated. For me that is the most tricky and
>>> hard part to get right, specially when using GMail as an email client.
>>>
>>> How do you handle that part of the process?
>>
>> I try to have as much in git as possible.
>>
>> So when the reviews trickle in, I change my commits (in git) accordingly
>> via rebase and edit and lots of fixup commits. I use git notes
>> to keep track of changes from one version to another.
>>
>> Having the "changes of the changes" in the git notes, I am (in theory)
>> always able to kick out a new version of the patch series with
>>
>>    rm 00* # delete old patches
>>    git format-patch --notes --coverletter somebranch...HEAD
>>    edit 0000-cover-letter.patch
>>    git send-email 00* --to=mailing list --to=John@doe.org --cc=Max@Mustermann.de
>>
> Is that capable of keeping the next patch set in the same thread that
> started when you sent the initial patch? Otherwise things get
> disconnected.

When typing it out quickly I forgot the --in-reply-to=<identifier>
option for the git send-email
command. The identifier needs to be looked u0p manually, which is
still a pain point in my workflow.

>
> --
> Thiago Farina
