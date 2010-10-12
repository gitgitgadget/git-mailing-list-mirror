From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: git ls-files handles paths differently in Windows and Mac
 (probably Linux)
Date: Tue, 12 Oct 2010 14:51:05 +0200
Message-ID: <AANLkTimB6s_yt6L59xpqsWO_yBsZxuVCiExFoSm9FcN1@mail.gmail.com>
References: <3C33A244-2449-4A3C-A8B5-2060CE61EE04@jetbrains.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Kirill Likhodedov <Kirill.Likhodedov@jetbrains.com>
X-From: git-owner@vger.kernel.org Tue Oct 12 14:51:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P5eKL-0005JI-13
	for gcvg-git-2@lo.gmane.org; Tue, 12 Oct 2010 14:51:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932502Ab0JLMvH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Oct 2010 08:51:07 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:34767 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932385Ab0JLMvF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Oct 2010 08:51:05 -0400
Received: by qyk5 with SMTP id 5so722276qyk.19
        for <git@vger.kernel.org>; Tue, 12 Oct 2010 05:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=iOJLKGqm/IepjPaS30sZ6M5byeKKVPo0kLyH4T21MYk=;
        b=vCkgr+zv7NXoMkogl7hjLR54e8/HiEvomb0g/P6gcylJz0JDGV/EJopnfYSZhMS6H/
         hYGIhmn3hJGzAN3dKsyFgIDUoCiquxXQO4ScJgCOuIumHXSL3AuUUss+DAbUUCJOad2q
         1zOyih0doSrzd/c/TSSSuKjgJZEY/tWqjeiwY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=igqxfkmA1JYpFAnNPk40UCNud8leSvQOYusW/vFUoLg0RAuQnvz6ajmLyTzG+ui34W
         K6gONXZQG3vpCRo43dTueAyi9dQdGLdAmbiGAGxPM8pyaXLketf513RS2Ya5MXy49urf
         erab1LG5dva55BT7GRLcplfVoWBKc1v5tzjSA=
Received: by 10.224.30.21 with SMTP id s21mr5613560qac.119.1286887865283; Tue,
 12 Oct 2010 05:51:05 -0700 (PDT)
Received: by 10.229.87.212 with HTTP; Tue, 12 Oct 2010 05:51:05 -0700 (PDT)
In-Reply-To: <3C33A244-2449-4A3C-A8B5-2060CE61EE04@jetbrains.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158832>

On Tue, Oct 12, 2010 at 14:14, Kirill Likhodedov
<Kirill.Likhodedov@jetbrains.com> wrote:
> The behavior of ls-files is inconsistent in Windows and Mac.
>
> I want to see which files were changed in the specific directory of my working tree, so I call ls-files:
>> git ls-files -douvm --exclude-standard -- MYDIR
>

Well, it is an... unconventional way to do that. May I suggest you consider
using "git diff --name-status" or just "git status" next time?

> Looks like a bug. Maybe a bug of porting Git to windows, but the behavior is the same on msys-git and cygwin-git.

Maybe. Both ports share a fair amount of Windows-related code.
