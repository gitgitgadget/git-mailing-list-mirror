From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2] worktree: add: introduce --checkout option
Date: Fri, 25 Mar 2016 08:49:29 +0700
Message-ID: <CACsJy8Bs0WFJxGnVOBUnzipZYty-K4D9NkAQdODYqPUw2VAAiw@mail.gmail.com>
References: <01020153a40588f3-5401ea3e-ece8-435c-a046-a5c1c1f92cd6-000000@eu-west-1.amazonses.com>
 <01020153a73bbb70-11a8482f-1a90-49e4-a56c-b311e12a85a2-000000@eu-west-1.amazonses.com>
 <CACsJy8DxcqYKrRi7_ERS3xLWfbbq3bNx-u2NWiXYoNw4yD+0dg@mail.gmail.com>
 <CABEEbiBM-CTJdmOukLjfrmnmsSTwNzx+ELfO=BtgApT__QZu-g@mail.gmail.com>
 <CAPig+cTtRgMz_6oEXmBN2MHG65arq51JsoBL9QeWBFNLgFnCmw@mail.gmail.com> <CAPig+cS2qMZyUkf9Nekp+QaVkjc1oHXb4QF3wFDnBdF3WMU3iQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Zhang Lei <zhanglei002@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Fri Mar 25 02:50:07 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ajGt4-0004QG-8M
	for gcvg-git-2@plane.gmane.org; Fri, 25 Mar 2016 02:50:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751403AbcCYBuC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Mar 2016 21:50:02 -0400
Received: from mail-lb0-f182.google.com ([209.85.217.182]:35415 "EHLO
	mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751247AbcCYBuA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Mar 2016 21:50:00 -0400
Received: by mail-lb0-f182.google.com with SMTP id bc4so41420340lbc.2
        for <git@vger.kernel.org>; Thu, 24 Mar 2016 18:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=dQFX3F1dVNGqumN2jVEepOmZ53GoNKEbBcBQiXDxwIc=;
        b=e6A7KK06olkNdAcwsxEh9A/R4NlPN7IEly6XoqCjrHLTlpa3W6CiGda9Dlz4eZjArV
         gEhMvoT5aaHuG6bYjzpEOnzapxeL5oilSo2SZNFaRUQxXFM3yIsf2oLp2/PCLrAQGW0P
         bZNUQCYJa4rkYw3cYq+rMbtQoYrjniVXRbfaqb9DyJTuY/iit8vUcokIUPylRmwzgd5z
         SuENxAh2j0Vl0osilKYpNmk19mJfAry7wCSD5/iNxmCSTZpr8PbcQVlTByXhyjSyYmTt
         TEzaTKP6P9lZIOycAGLWP6MA1ycgOSY15EzftcgrivmwLGkXsSIXTeYthy41c7YL3z9Y
         AJqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=dQFX3F1dVNGqumN2jVEepOmZ53GoNKEbBcBQiXDxwIc=;
        b=JUf1Nf5iVVetHrJ4maVsmLW9xrj/iOKX5Q3iKDi5opnww/Oy7UCl49vpaK0gBOOpd4
         uLJpuvtVt+yARpTDGIeBlx2boVpOwrEWX9FwsllYF+1+bQ9e1XFjpbYqdJOcRom87PmD
         FmdGNTN0ds/xAUYJHyj0I49Ux2Z8o5rzIBlyGZE6zz2SrmSWrrld6cV29l7pCyssqRZY
         v+kwKuBueeIO0i73Z0M9iRY14/gWTLpRwUVbg6b2wh6THJK9Y77dTkeZNebheEF1xGg8
         sGwvLnfQD+GzCz+NHk/baB4B9BNwzG0o6DRQxPmnYVwhf1FfCkcOk4KoCQt9fZx4TiiX
         u+aQ==
X-Gm-Message-State: AD7BkJKhFH35IbsFfph5H1un9Y0O/e9HyRXRHI6g2JoHQrq1BgWThbYiJE44rLu70W2Mz+2Tj5/yPDfXJ2JJqA==
X-Received: by 10.112.209.99 with SMTP id ml3mr4522853lbc.26.1458870598783;
 Thu, 24 Mar 2016 18:49:58 -0700 (PDT)
Received: by 10.112.167.10 with HTTP; Thu, 24 Mar 2016 18:49:29 -0700 (PDT)
In-Reply-To: <CAPig+cS2qMZyUkf9Nekp+QaVkjc1oHXb4QF3wFDnBdF3WMU3iQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289843>

On Fri, Mar 25, 2016 at 8:29 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Thu, Mar 24, 2016 at 9:22 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> On Thu, Mar 24, 2016 at 5:52 AM, Zhang Lei <zhanglei002@gmail.com> wrote:
>>> 2016-03-24 17:16 GMT+08:00 Duy Nguyen <pclouds@gmail.com>:
>>>> I think we can follow git-clone and use '-n' for this. [...]
>>>
>>> My PATCH v1 did follow git-clone -n, however, Junio C Hamano and Eric Sunshine
>>> suggested that we should avoid doing so , as --no-no-checkout could be
>>> confusing.
>>
>> My impression was that Duy was suggesting only that -n be recognized
>> as shorthand for --no-checkout, however, git-worktree already
>> recognizes -n as shorthand for --dry-run (as a consequence of using
>> OPT__DRY_RUN), so -n as shorthand for --no-checkout is a no-go.
>
> Ignore this. It's only 'prune' which recognizes -n, so it's possible
> that 'add' could recognize it for an alternate meaning (though the
> documentation would want to make this very clear).

To make it clear, I don't feel strongly about '-n'. Yes muscle memory
may count. But if '-n' may become a new confusion source in
git-worktree then perhaps we should avoid it and go with
--[no-]checkout
-- 
Duy
