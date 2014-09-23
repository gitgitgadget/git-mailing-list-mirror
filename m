From: Robert Dailey <rcdailey.lists@gmail.com>
Subject: Re: How to compile Git with NDK?
Date: Tue, 23 Sep 2014 07:52:32 -0500
Message-ID: <CAHd499CUrKqY26eA2QwK4EpWOjum-NBXi==E8GwtjOty3ZYYeA@mail.gmail.com>
References: <CAHd499C3iwpcGf+Zt+jDJfqW41P=6Uu=b8VGZKJpFZCtw56beg@mail.gmail.com>
	<54209333.7090300@gmail.com>
	<CAHd499C0XJDwNa3n3bzK7hu6iRunV1d=nvbqi+2pyoB8uSzDFA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Stefan Beller <stefanbeller@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 23 14:52:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XWPa9-0003nM-Hz
	for gcvg-git-2@plane.gmane.org; Tue, 23 Sep 2014 14:52:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753427AbaIWMwd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Sep 2014 08:52:33 -0400
Received: from mail-vc0-f178.google.com ([209.85.220.178]:42796 "EHLO
	mail-vc0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751592AbaIWMwd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Sep 2014 08:52:33 -0400
Received: by mail-vc0-f178.google.com with SMTP id lf12so3002833vcb.9
        for <git@vger.kernel.org>; Tue, 23 Sep 2014 05:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=ys/9imle0uE3pE3UDjJzO8Q3lP5sMdNvjRCtXX750Ts=;
        b=xwgyUdfCdbun9fGRNzZuKkXDIcM23DFSGcL+6cTHdModE4f4NQlqH/3ampYHlR6d79
         nNb5LVHtLU3pGTwwmv3LZ5wRmLAXBfR2Uu4siqfQtlRBd695giV6sVuP7lKTgzTEFKYT
         FydZDhKM9qk2rx/FGWsDDRjssb5kcV2itdF2FGnE6x118mRl9VKyQSYMiTokEgXu6s/f
         FQQPhddcu9ZSnLUMMtJp4fe4h30QbVcN3ECARikD9WRVw+83sr3o+7ZIs6B/bVOYTgOt
         hwAydJp2OZstF75xhY35f79CzIrjyaLuJtrcOnibPdbGMhy+3GyrHfoGPHUREWn8Pd57
         szqQ==
X-Received: by 10.220.69.210 with SMTP id a18mr150490vcj.67.1411476752266;
 Tue, 23 Sep 2014 05:52:32 -0700 (PDT)
X-Google-Sender-Delegation: rcdailey@gmail.com
Received: by 10.221.3.200 with HTTP; Tue, 23 Sep 2014 05:52:32 -0700 (PDT)
In-Reply-To: <CAHd499C0XJDwNa3n3bzK7hu6iRunV1d=nvbqi+2pyoB8uSzDFA@mail.gmail.com>
X-Google-Sender-Auth: lir9JCMB-pb8dQA7axp-6V0rjfw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257415>

On Tue, Sep 23, 2014 at 7:47 AM, Robert Dailey <rcdailey.lists@gmail.com> wrote:
> But if I type just 'make', I don't see how it will know where my ARM
> toolchain is. I'll read the INSTALL file in the meantime.

Sorry for top post earlier, my mistake.

I reviewed the INSTALL file. It doesn't mention anything regarding how
to setup the toolchain for the Git build. Also looks like I'll have to
build the library dependencies with ARM toolchain as well. Looks like
zlib is the only absolute required one. Is that correct?
