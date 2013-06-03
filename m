From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [RFC v2] reflog: show committer date in verbose mode
Date: Mon, 3 Jun 2013 17:37:15 +0700
Message-ID: <CACsJy8AOEhETjoM9a2qFbc=md_9aELervzvRMamDE35sCpPVqw@mail.gmail.com>
References: <517a09251fbbc81073fbd53f04a3f4b58cb8b3f7.1370224175.git.worldhello.net@gmail.com>
 <CALkWK0k-cikpwue4iQDGJgP4NrGdkCw2r=dzzP78+QbsA5BiMA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jiang Xin <worldhello.net@gmail.com>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 03 12:37:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UjS98-0007Fa-Nf
	for gcvg-git-2@plane.gmane.org; Mon, 03 Jun 2013 12:37:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753676Ab3FCKhr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Jun 2013 06:37:47 -0400
Received: from mail-ob0-f181.google.com ([209.85.214.181]:49537 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753061Ab3FCKhp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Jun 2013 06:37:45 -0400
Received: by mail-ob0-f181.google.com with SMTP id 16so6737641obc.40
        for <git@vger.kernel.org>; Mon, 03 Jun 2013 03:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=TA1aEJqWscx/Lci78msuGDXDDXtKkHfNkaR1F1Wl9yE=;
        b=SfAYl2kdKJXEd2JvnZC1K/Wc9gkUSinAfj3M6Z1UsiFmTKIEM+xlkz+KvEVbLh2bWo
         UFJVx6vcnC2vs78TMvEZPT7N9JxzvGeEKgAxaiI6R20uxF+QUXUzXFrTdtr5bbmd8n4h
         kqmVRO2ZM0PnAbVW1uUP5kprvoNriOTKzY3Ogt16l5PxX96BsTI/z3NLYJ6M0b1MfLUY
         JbwrBgSEBx5OVqRqmzaW47iEZ2H2As9afpQ/F8K15qnKx7tpP4iTl/hm8pEM+HpiaUGo
         mjBiqAhsoEdgKt2TMyK0cr6tCapj80OsbP6u3lz9MnV5OLOYx/IDYVtbaxzuzM0Vm2Xv
         pVlA==
X-Received: by 10.60.150.146 with SMTP id ui18mr9541659oeb.101.1370255865092;
 Mon, 03 Jun 2013 03:37:45 -0700 (PDT)
Received: by 10.76.171.199 with HTTP; Mon, 3 Jun 2013 03:37:15 -0700 (PDT)
In-Reply-To: <CALkWK0k-cikpwue4iQDGJgP4NrGdkCw2r=dzzP78+QbsA5BiMA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226212>

On Mon, Jun 3, 2013 at 5:00 PM, Ramkumar Ramachandra <artagnon@gmail.com> wrote:
> Jiang Xin wrote:
>> It will be nice to add this pretty formatter automatically when run
>> `git reflog` in verbose mode. And in order to support verbose mode, add
>> new flag "verbose" in struct rev_info.
>
> Sorry I missed earlier revisions of this patch.  Generally speaking,
> "verbose" is a bad way to control format-specifiers.  Why not add to
> the list of pretty-format specifiers (like oneline, short, medium,
> full)?

I think allowing to override the default format (e.g. via config key
reflog.format or something) and even format of -v(s) may be more
useful. People can define how "reflog show", "reflog show -v", "reflog
show -vv".. will display.
--
Duy
