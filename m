From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH] git-web--browse: recognize iTerm as a GUI terminal on OS X
Date: Mon, 25 Mar 2013 21:13:01 +0100
Message-ID: <CAP8UFD21BChC-KF+HWWS9_q_GtpGm+Uh_L60qcJt=b3mQt_jBw@mail.gmail.com>
References: <CAMxBVSs6dJFnK78E2Da7t4V9ndJFRVDZEd1fR5QuCFz=u2Bnpw@mail.gmail.com>
	<CAMxBVStw-b3J_Fm9x=h3==9ebdLUkpjBSQ9-W4+zJ9N20ojfxg@mail.gmail.com>
	<CAP8UFD2oR5tnYuw7Nbe-CzGx7fw-OpAFW+reN+1Nroh1jXjfsQ@mail.gmail.com>
	<CAMxBVStVXZGGrjHzN7kukVP6_ZGo0miyJaE2FVYPVV4Jb5U82w@mail.gmail.com>
	<CAEBDL5VNodcTGBOvQjyL30qiXhshxhnUH-Vd9xy9=RxZQgH-Yw@mail.gmail.com>
	<CAP8UFD2m8n5RHN-CgyDP1ir_AorpJGnWwNhXuRxDa=DbHfsdiw@mail.gmail.com>
	<20130325101318.GA31409@yoda.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Timo Sand <timo.j.sand@gmail.com>, git <git@vger.kernel.org>
To: John Szakmeister <john@szakmeister.net>
X-From: git-owner@vger.kernel.org Mon Mar 25 21:13:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKDlt-0001vS-8v
	for gcvg-git-2@plane.gmane.org; Mon, 25 Mar 2013 21:13:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933117Ab3CYUNE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Mar 2013 16:13:04 -0400
Received: from mail-ve0-f169.google.com ([209.85.128.169]:43641 "EHLO
	mail-ve0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932801Ab3CYUND (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Mar 2013 16:13:03 -0400
Received: by mail-ve0-f169.google.com with SMTP id d10so1781974vea.28
        for <git@vger.kernel.org>; Mon, 25 Mar 2013 13:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=sJC6SjVJ4SNvzy0D7DrjkYqXuA2Es5gMBnOEDQxXDUQ=;
        b=Cxq1H8aF9sZfUDI/ibxV4K7nlJydYgUKfgpL7vsWV7MDdq8sUcoB9S13dCgTEiziPT
         LY5sBqZn0tFLutSlyxJYeMNEIYsQUtgtL7FDeQKSb8cdSkGWtfFU4fKcmFtI4oi6gx+A
         zmdUg9IpX38ihZiTw31wuI8xNQ1LYGRz9AgsBjJiQIvJCt7VpHWcMmRxEgRKLmmlNqGx
         WnRqKJyTeHXICtgE9+ZLSCqEoh0yPkFMNAt0vFe35vaVVtY2ImF+dcdCkIWoUfJvlWd5
         P2IhPwMnGtVo29yj9B2HKENMx65Gljfn3mnmONAFN/ilTJlEkv/24YieUSCsi943cnGG
         mAEw==
X-Received: by 10.220.248.200 with SMTP id mh8mr2983340vcb.51.1364242382140;
 Mon, 25 Mar 2013 13:13:02 -0700 (PDT)
Received: by 10.58.120.97 with HTTP; Mon, 25 Mar 2013 13:13:01 -0700 (PDT)
In-Reply-To: <20130325101318.GA31409@yoda.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219076>

On Mon, Mar 25, 2013 at 11:13 AM, John Szakmeister <john@szakmeister.net> wrote:
>
> Here's an updated patch.

Thank you for it. For what it's worth:

Acked-by: Christian Couder <chriscool@tuxfamily.org>

> I also noticed that git-bisect.sh is
> also trying to determine if a GUI is present by looking for
> SECURITYSESSIONID as well.  I wonder if it would be better to
> create a shell function in git-sh-setup.sh that the two scripts
> could use?

Yeah, it might be a good idea to have some common functions to
determine if a GUI is present.
Maybe you could start with an os_x_gui_present() function in another
patch on top of this one.

Thanks,
Christian.
