From: shawn wilson <ag4ve.us@gmail.com>
Subject: Re: Repo with only one file
Date: Fri, 9 Aug 2013 02:33:53 -0400
Message-ID: <CAH_OBicF3xn8+MsKH0nTg-HnPg58T-TWHW20r7GqXOm3Nbutfg@mail.gmail.com>
References: <CAH_OBid8SO3ydpjhRHa68s+54CScLh=jactxTQhwQPo-jcnAvA@mail.gmail.com>
 <520224E0.5060206@viscovery.net> <CAH_OBicysTTu9YdHsHz0H6x3umU5va68J3nT1qHA9-CJY9+E=A@mail.gmail.com>
 <CABURp0o_07HdB2o0knPABtAiiuHQ6-fYgemvdCYOsdSghO7v1w@mail.gmail.com> <52048B5B.5060009@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Phil Hord <phil.hord@gmail.com>, Git List <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Aug 09 08:34:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V7gHD-0005oC-97
	for gcvg-git-2@plane.gmane.org; Fri, 09 Aug 2013 08:34:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030322Ab3HIGeP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Aug 2013 02:34:15 -0400
Received: from mail-vb0-f52.google.com ([209.85.212.52]:38040 "EHLO
	mail-vb0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967243Ab3HIGeO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Aug 2013 02:34:14 -0400
Received: by mail-vb0-f52.google.com with SMTP id f12so3794776vbg.25
        for <git@vger.kernel.org>; Thu, 08 Aug 2013 23:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=oTs4kTIDKQEyXWOGOPeP6MWbO8ghVlC65PdzgNKVuss=;
        b=IdHbGTmuD5PttVSsraThFbqFYxNN8rtL9fXPPoRmaJ/nT0Rligllc24F7QbrhNTQtE
         3Tp8NKZAQH1leS52fLdQ7/Npl5TXrlXrccablto0jUeXihI8bHP2w6Th079Y+FmJEcN1
         yegyFh5WyVviuQyAvoiFMR4+6NsZzNIcT5bc7FAJd2HjrtME2qV13U4mSYwBvV7gcaEC
         s2kYK8BTWApNjJSZGO6AaAJr5QUp3kTUnz9zW1CJml8rEIlWW9xFIJUm31D6eI3mbQBb
         uWeiq/0dABMU1Ov99YatD5LiSdOccMYPJAoi+Wfx3p1PcGWB8gpxRNhcwIlcXjT9qYIA
         TMEw==
X-Received: by 10.220.238.81 with SMTP id kr17mr4841570vcb.61.1376030053936;
 Thu, 08 Aug 2013 23:34:13 -0700 (PDT)
Received: by 10.52.186.37 with HTTP; Thu, 8 Aug 2013 23:33:53 -0700 (PDT)
In-Reply-To: <52048B5B.5060009@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231959>

On Fri, Aug 9, 2013 at 2:25 AM, Johannes Sixt <j.sixt@viscovery.net> wrote:
> Am 8/8/2013 23:11, schrieb Phil Hord:
>> On Wed, Aug 7, 2013 at 5:07 PM, shawn wilson <ag4ve.us@gmail.com> wrote:
>>> On Wed, Aug 7, 2013 at 6:43 AM, Johannes Sixt <j.sixt@viscovery.net> wrote:
>>>> Am 8/7/2013 8:24, schrieb shawn wilson:> ... create a repo for one of
>>>>> these scripts and I'd like to keep the commit history.
>>>>>
>>>>> Ok, so:
>>>>> % find -type f ! -iname "webban.pl" | while read f; do git
>>>>> filter-branch -f --index-filter "git rm --cached --ignore-unmatch $f"
>>>>> HEAD ; done
>>>>>

> I'm not sure. On second thought, my suggested command is not sufficient.
> It does remove the empty commits, but it does not remove the other files.
> So, Shawn's original filter-branch invocations are still needed.
>

Yeah, I have tried this and haven't gotten any closer. I can either
remove all of the history or that one commit that has nothing to do
with my file is there. This is also reproducable in a new repo.

Is this a bug with filter-branch or git? This doesn't seem like a
feature (or how things should act).
