From: Zhang Lei <zhanglei002@gmail.com>
Subject: Re: [PATCH v2] worktree: add: introduce --checkout option
Date: Fri, 25 Mar 2016 20:06:51 +0800
Message-ID: <CABEEbiAeMZ=PSScFJ98DkqyDBGTC1OBvTb8bLAn=whLjXJvdzA@mail.gmail.com>
References: <01020153a40588f3-5401ea3e-ece8-435c-a046-a5c1c1f92cd6-000000@eu-west-1.amazonses.com>
	<01020153a73bbb70-11a8482f-1a90-49e4-a56c-b311e12a85a2-000000@eu-west-1.amazonses.com>
	<CACsJy8DxcqYKrRi7_ERS3xLWfbbq3bNx-u2NWiXYoNw4yD+0dg@mail.gmail.com>
	<CABEEbiBM-CTJdmOukLjfrmnmsSTwNzx+ELfO=BtgApT__QZu-g@mail.gmail.com>
	<CAPig+cTtRgMz_6oEXmBN2MHG65arq51JsoBL9QeWBFNLgFnCmw@mail.gmail.com>
	<CAPig+cS2qMZyUkf9Nekp+QaVkjc1oHXb4QF3wFDnBdF3WMU3iQ@mail.gmail.com>
	<CACsJy8Bs0WFJxGnVOBUnzipZYty-K4D9NkAQdODYqPUw2VAAiw@mail.gmail.com>
	<CABEEbiDRPsL6XJrnyFv43u26hXNbBVmMhbJeZmp+zjS+-jNZ=w@mail.gmail.com>
	<CACsJy8AyMUn_AAF-DNGvjS8D+qdFLNuVBYvAjide6wA-ZnHJ5w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 25 13:07:36 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ajQWd-0003xP-KR
	for gcvg-git-2@plane.gmane.org; Fri, 25 Mar 2016 13:07:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752204AbcCYMGx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Mar 2016 08:06:53 -0400
Received: from mail-ig0-f194.google.com ([209.85.213.194]:36124 "EHLO
	mail-ig0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751475AbcCYMGw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Mar 2016 08:06:52 -0400
Received: by mail-ig0-f194.google.com with SMTP id y4so1649899igt.3
        for <git@vger.kernel.org>; Fri, 25 Mar 2016 05:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=S8PrGAVPG4qx8q7/1wT6M1t87fsJ2NL7S6G4kW9wkt0=;
        b=a4MmlgzdcBWWmG3vQSMF9duHxmc26iqRIFJq68jY7PpD4uocHmyGYfwosR5CoGb1TI
         Zk9l8yDwa7unryK4OnFAXmcKUCQKUbTtNPd6WdJik0qEIL39YWX3Dn3fctw9J4P7gv+r
         HQVbF2dxLbYFv6YFPYStIzKRNmD2G0nsLV2UknKbgnRKNfsn2VpHw4me5X439qhOoOVM
         sk1Ki2AhPNsh6IY28oq6Ks1k7k1e2LkF6aPJBqj49x2ivIr9tWpcTh7fNBRkIOl6Q+6Y
         27aYgh4jzHs0HwersiVuYB+BnkfrzGRxxcOCL7lvh6/PZ2FOKss44rqMSrS9TfZOjxcd
         SpXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=S8PrGAVPG4qx8q7/1wT6M1t87fsJ2NL7S6G4kW9wkt0=;
        b=lSiqq8WRR2eiQYEx4auBXWFXM5uCUbsSoPruamtp5UHQWz8hQd46Za8jcamHoFvby3
         0gvZ4QzNzqshqbb8cZ0yUtXC1AkdU16NEF9z/b03LreWrehry5/leTgou5pD+trUKihC
         pyS54uXGNrcipZhTAl+U8zy8QIdJZNncBAA0AZeV2yifO/y6GtzFb/WKTbH4tRdhzteE
         6GtS2d7PUpaeFQherPny4kfpKHX/gMlzih9bwAO2mxIktoMTyQC7tU/65VjtTDdDHg0v
         r+nDniuMP2afivaPpt/40cZSUuyqvHujdonqjf8WIAoAwdIodTnKt2iVgKGUWV7/MMiP
         jr7A==
X-Gm-Message-State: AD7BkJL95BHPVSmv8HRs5HBD77MRq8wdhcL2ZkciKjowipk9EGZTBfvKI9OJ4ttySRNDM3OZV22JkpzKC4sdwA==
X-Received: by 10.50.43.202 with SMTP id y10mr2524072igl.63.1458907611534;
 Fri, 25 Mar 2016 05:06:51 -0700 (PDT)
Received: by 10.107.1.72 with HTTP; Fri, 25 Mar 2016 05:06:51 -0700 (PDT)
In-Reply-To: <CACsJy8AyMUn_AAF-DNGvjS8D+qdFLNuVBYvAjide6wA-ZnHJ5w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289883>

Yes, path basename makes sense.
I am asking this question because we have some legacy code requires
that working tree
called something like 'src', as a result, multiple branch would have
src1 src2 src3 under .git/worktrees
which could not be easy to maintain.
I agreed with you, we should give users such option.


2016-03-25 19:41 GMT+08:00 Duy Nguyen <pclouds@gmail.com>:
> On Fri, Mar 25, 2016 at 6:31 PM, Zhang Lei <zhanglei002@gmail.com> wrote:
>> By the way, Duy, another unrelated question: why worktree name under
>> .git/worktrees is being named
>> after the working tree path basename? I think branch name is more
>> reasonable since we don't allow checking out
>> the same branch twice.
>
> Because branch name is not always available (e.g. detached HEAD) and
> checkout branch can be switched later on. And normally you'll get
> branch name there anyway with "git worktree add something" because the
> branch "something" is automatically created. I've been wondering if
> it's worth supporting "git worktree -b abc ./" where we create
> worktree "./abc" based on branch name too.
> --
> Duy
