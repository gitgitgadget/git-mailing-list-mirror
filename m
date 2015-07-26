From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v4 01/10] ref-filter: add option to align atoms to the left
Date: Sun, 26 Jul 2015 11:33:52 +0530
Message-ID: <CAOLa=ZQi-_8FOmJRCwRHutfHD=Sqk7K=Xga6gmfjfnYF7veySg@mail.gmail.com>
References: <1437764685-8633-1-git-send-email-Karthik.188@gmail.com>
 <1437764685-8633-2-git-send-email-Karthik.188@gmail.com> <CAPig+cQSy6imD_z+a9tvprJtn2-20awLJOcUQAksyv6HceVzxQ@mail.gmail.com>
 <CAOLa=ZQvMV8C6LV-+B3m74x209Fr1X7W=piaL-Eftu_PdRW64w@mail.gmail.com> <CAPig+cQD3tMmOrYFb=iWEq7CptDgwarZWW3WDGh7QGKVavgWGA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sun Jul 26 08:04:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZJF39-0000tc-Db
	for gcvg-git-2@plane.gmane.org; Sun, 26 Jul 2015 08:04:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751452AbbGZGEX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Jul 2015 02:04:23 -0400
Received: from mail-ob0-f170.google.com ([209.85.214.170]:33922 "EHLO
	mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751045AbbGZGEW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Jul 2015 02:04:22 -0400
Received: by obre1 with SMTP id e1so39923377obr.1
        for <git@vger.kernel.org>; Sat, 25 Jul 2015 23:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=5s2vFJz0bnU4ZrJm6ik67Jlk04GQ1lzyChddKs9Zbo4=;
        b=FwOfae7SBijlLCo5FRUr9p8WGmv7+wYshy4PbUAIV4oAMQyvr/NVVkc97mpA/fvef/
         KsKdnxYsedBqEflXOa31bzPiYhOw9voyNyrupsuGtx5DlqvesCTETPBOPumCDCGBhbAX
         GLfdhqo6QQadgQT5ZKysnQcJuOj8wP38pKMtt+Ie5MFVKsarXTKLumBXgZPW0stqZUEu
         JCuZbVB4CymGJ3yuxhqeBq/t4Z9so2KUO2fDcEfv7+1Gfl4xB/v3d3UYI8jbkAZ55FeI
         wiGoL/RVJZuRuqhECRE9idhuyy0jSTDtFnZurISLwPKNIM9GJPvuLth2LLd22xtgfeF4
         VjrA==
X-Received: by 10.60.58.136 with SMTP id r8mr21964415oeq.30.1437890661684;
 Sat, 25 Jul 2015 23:04:21 -0700 (PDT)
Received: by 10.182.26.73 with HTTP; Sat, 25 Jul 2015 23:03:52 -0700 (PDT)
In-Reply-To: <CAPig+cQD3tMmOrYFb=iWEq7CptDgwarZWW3WDGh7QGKVavgWGA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274638>

On Sun, Jul 26, 2015 at 11:28 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Sun, Jul 26, 2015 at 12:36 AM, Karthik Nayak <karthik.188@gmail.com> wrote:
>> On Sun, Jul 26, 2015 at 9:38 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>>> Also, it is helpful to reviewers if you include an interdiff at the
>>> bottom of your cover letter showing the changes from one version to
>>> another. You can generate an interdiff with "git diff branchname-v4
>>> branchname-v5", for instance.
>>
>> I've been working on the same branch, and that's why I didn't really
>> provide interdiff's, and I kinda worked on the same branch again,
>> so I wont be giving an interdiff for the next series either, but I'll keep this
>> in mind and follow it from the forthcoming patch series. Thanks
>
> You can still provide an interdiff. It is quite likely that you can
> find the commit corresponding to v4 in the reflog for that branch (see
> git-reflog). Failing that, an easy way to recover the state at v4 is
> to create a new branch (from the parent of your current working
> branch) and apply the v4 patches which you sent to the mailing list.
> If Junio queued v4 in his 'pu' branch, then you can also recover from
> there. Once you've recovered the state of v4 using one of the methods
> mentioned here (or some other), you can make an interdiff when sending
> out v5.
>

Haha, I was just thinking about applying my patches and doing it, will
definitely
provide an interdiff.

> Reviewers do appreciate that you provide a URL to the previous version
> and take the time to explain in your cover letter what changed (and
> why). Including an interdiff is one more way to ease the review
> process, and is also appreciated, so it may be worthwhile to put in
> the effort to recover the state of v4 so that you can include an
> interdiff with v5. Doing so does require a bit of extra work for you,
> but that's work you only need to do *once*, whereas if you don't do
> it, then you place the burden on *each* reviewer for *each* version,
> which quickly adds up to a lot more work for those reviewing your
> submissions.

Yes! definitely, I'll make sure that I provide the interdiff, I'll
look at reflog,
thanks a lot. I appreciate how reviewers take time to review code, its a
wonderful process. I will be glad to put in any time to make their process
easier

-- 
Regards,
Karthik Nayak
