From: Zhang Lei <zhanglei002@gmail.com>
Subject: Re: [PATCH v2] worktree: add: introduce --checkout option
Date: Thu, 24 Mar 2016 17:52:58 +0800
Message-ID: <CABEEbiBM-CTJdmOukLjfrmnmsSTwNzx+ELfO=BtgApT__QZu-g@mail.gmail.com>
References: <01020153a40588f3-5401ea3e-ece8-435c-a046-a5c1c1f92cd6-000000@eu-west-1.amazonses.com>
	<01020153a73bbb70-11a8482f-1a90-49e4-a56c-b311e12a85a2-000000@eu-west-1.amazonses.com>
	<CACsJy8DxcqYKrRi7_ERS3xLWfbbq3bNx-u2NWiXYoNw4yD+0dg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 24 10:53:07 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aj1wv-0002DZ-Sr
	for gcvg-git-2@plane.gmane.org; Thu, 24 Mar 2016 10:53:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755233AbcCXJxA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Mar 2016 05:53:00 -0400
Received: from mail-ob0-f196.google.com ([209.85.214.196]:35945 "EHLO
	mail-ob0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755180AbcCXJw7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Mar 2016 05:52:59 -0400
Received: by mail-ob0-f196.google.com with SMTP id cf7so2971157obc.3
        for <git@vger.kernel.org>; Thu, 24 Mar 2016 02:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=8k2MeyxMKX9C2qMKs9HwUUnhtHqMzl2O+AZ+Ehe9ElY=;
        b=AY5K49UAzbTxJ/kSersCxEYHtkwmjZ/2M1atsw/8d64kHapKCMwc/l2jAKBQKEE0Gc
         Ht+pZtd0Omg4vp0Ht4gm2WsXuCpYU0f4KZrAyuA7UUoedUPQkngUjZRlNXUsqUSR2Fb/
         IFYVN+iT1zsuFu8l98N32G8j227N7i2WqgkDw44PhCGznh+4mi77QeTKalSPXDRUBZee
         Y18kEZiaUXgIqIcxpbTVhK33Xd61sVo5n7XDVxSKCtHx5fhdeTn9J/9cNg/3mXQQi82f
         u/KAZRYwAbtSAr4EGpmbjQCOT0cTHxwQLlVoZIyV4UZiDscVYUVKhPdFFWbt5A3zXI7+
         kkjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=8k2MeyxMKX9C2qMKs9HwUUnhtHqMzl2O+AZ+Ehe9ElY=;
        b=aD0v/D2XjPGrxee9t3umi/p0z/kJI/wkfvOKteLFbPZsssZ1xvWGfOrUreXMt8n17T
         x8XoP4Tqm8OxUA2Ib1QQa9efI5xGImef1xKTmYISzZ22k/+ov/OlhD9UBog2GQJGbsoh
         Yx5BPRMGY5xRRT4TY1q3VvqkHGNPpEhR+uZZ4j3QE2Jvw5/mtkQ/u5598dXRzNcP6dj3
         o+ZLUXyt7A/biPLsSdBpRrVTqs5OBikNw6xnFd3C1WZOPws08rR2kbmY0Ca28Nfn7dsC
         BOSH0Zd46bkY2RJWvM3Qk52VF/oQIgUIjc7EB5ZdOl4bpz1hg9N9Ti/M9h6VFvPasDUb
         XBcw==
X-Gm-Message-State: AD7BkJLPJJekukU44OH0UZVer4mv/x88T497xq9n3z498r2fQheAroPcndRwtW5lPHC8EcVdtJFtPwmROLyiUA==
X-Received: by 10.182.85.132 with SMTP id h4mr3679142obz.51.1458813178752;
 Thu, 24 Mar 2016 02:52:58 -0700 (PDT)
Received: by 10.182.38.170 with HTTP; Thu, 24 Mar 2016 02:52:58 -0700 (PDT)
In-Reply-To: <CACsJy8DxcqYKrRi7_ERS3xLWfbbq3bNx-u2NWiXYoNw4yD+0dg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289729>

hi Duy,
My PATCH v1 did follow git-clone -n, however, Junio C Hamano and Eric Sunshine
suggested that we should avoid doing so , as --no-no-checkout could be
confusing.

Yes, core.sparsecheckout is the global switch for all worktrees, but
every worktree
can have its own info/sparse-checkout.

2016-03-24 17:16 GMT+08:00 Duy Nguyen <pclouds@gmail.com>:
>
> On Thu, Mar 24, 2016 at 1:07 PM, Ray Zhang <zhanglei002@gmail.com> wrote:
> > By adding this option which defaults to true, we can use the
> > corresponding --no-checkout to make some customizations before
> > the checkout, like sparse checkout, etc.
>
> I think we can follow git-clone and use '-n' for this. But if it's
> sparse checkout that's you're after, be warned that it's not fully
> supported (you either enable sparse chekcuot for all worktrees, or
> none).
> --
> Duy
