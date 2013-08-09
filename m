From: shawn wilson <ag4ve.us@gmail.com>
Subject: Re: Repo with only one file
Date: Fri, 9 Aug 2013 17:54:36 -0400
Message-ID: <CAH_OBievQ72gid7OQwCwij3ApjStFScGSQsV_w2Oap24GsHobg@mail.gmail.com>
References: <CAH_OBid8SO3ydpjhRHa68s+54CScLh=jactxTQhwQPo-jcnAvA@mail.gmail.com>
 <520224E0.5060206@viscovery.net> <CAH_OBicysTTu9YdHsHz0H6x3umU5va68J3nT1qHA9-CJY9+E=A@mail.gmail.com>
 <CABURp0o_07HdB2o0knPABtAiiuHQ6-fYgemvdCYOsdSghO7v1w@mail.gmail.com>
 <52048B5B.5060009@viscovery.net> <CAH_OBicF3xn8+MsKH0nTg-HnPg58T-TWHW20r7GqXOm3Nbutfg@mail.gmail.com>
 <52049121.2080604@viscovery.net> <CAH_OBifYFyVVo_OEfniWJE=0peX+UPLkRznqyQzvO4gGGLu_tQ@mail.gmail.com>
 <5204C546.1030502@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Phil Hord <phil.hord@gmail.com>, Git List <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Aug 09 23:55:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V7ueJ-0000Md-O4
	for gcvg-git-2@plane.gmane.org; Fri, 09 Aug 2013 23:55:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031284Ab3HIVy7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Aug 2013 17:54:59 -0400
Received: from mail-vb0-f54.google.com ([209.85.212.54]:64876 "EHLO
	mail-vb0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031243Ab3HIVy5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Aug 2013 17:54:57 -0400
Received: by mail-vb0-f54.google.com with SMTP id q14so3574951vbe.13
        for <git@vger.kernel.org>; Fri, 09 Aug 2013 14:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=sJtRfvhFt3PD5o16m5oTnnvoqgO7BC1bzrFbwu6HxE0=;
        b=Pl/zr9sBOq+wuH+R58LJHULETiZByQBdC9h/EeJZqhN7lyMuxWizekWlAWZ+kSUZAW
         oh3qarIPYrtthepovLjjbipt3TOQ41zIWsYl0YzOdQTfNVuB7GzxOFIQIhuXGx+waEm6
         bLcxqqjiHvsUY/uRi43cZ4Olyh6nbyIFguYNEYwdPOOF5KBuatB57sRtshCtQE+hWjAO
         ZgDkyfsPoIcBYdhS7lTgNbSq39R8Bijo71lXt3w795M6haSqwy+jKlsbvIceDkr9hVKt
         /ozYHtDHdmbI5UzcvDVX5U+8QsbqhdEi/kB7mghoaZhzd2mD8k2lxCTNwU7W4H/pDpX0
         eBDw==
X-Received: by 10.59.9.69 with SMTP id dq5mr6795387ved.87.1376085296328; Fri,
 09 Aug 2013 14:54:56 -0700 (PDT)
Received: by 10.52.186.37 with HTTP; Fri, 9 Aug 2013 14:54:36 -0700 (PDT)
In-Reply-To: <5204C546.1030502@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232040>

On Fri, Aug 9, 2013 at 6:32 AM, Johannes Sixt <j.sixt@viscovery.net> wrote:
> Am 8/9/2013 12:03, schrieb shawn wilson:
>> The question still stands though - why is that unassociated commit left there?
>
> Because your command did not remove it. filter-branch does not know that
> it is "unassociated" when you ask it to follow all commits beginning at
> HEAD. But when you say 'HEAD -- webban.pl', you ask it to follow only
> commits that touch webban.pl, which automatically skips that commit.
>

I can go with that. However, I don't think that's the end of the story either:
 % du -sh .
192M    .

Something has been left behind. What? Or how do I figure that out and remove it?
