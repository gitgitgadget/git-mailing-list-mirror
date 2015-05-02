From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: multiple source file extensions
Date: Sat, 2 May 2015 09:11:16 +0700
Message-ID: <CACsJy8C2aztHWHP0_U8VWJxMrT2HE7aYBxDQTnSWS1TVwCnedw@mail.gmail.com>
References: <CACnwZYed_aHzLsbkJVm=OnydXw-CPi-Zm9V7928rzvpaFMNENw@mail.gmail.com>
 <CANuW5x3OBWNDnHeVbH7ZQaj5AUAingea6crJ0cF9AHFjcJE_bQ@mail.gmail.com>
 <20150502011100.GB5634@peff.net> <20150502020431.GA15775@lanh>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Josh Hagins <hagins.josh@gmail.com>,
	Thiago Farina <tfransosi@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat May 02 04:11:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YoMuJ-0006DY-9U
	for gcvg-git-2@plane.gmane.org; Sat, 02 May 2015 04:11:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750866AbbEBCLs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 May 2015 22:11:48 -0400
Received: from mail-ig0-f169.google.com ([209.85.213.169]:34055 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750785AbbEBCLr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 May 2015 22:11:47 -0400
Received: by iget9 with SMTP id t9so36760582ige.1
        for <git@vger.kernel.org>; Fri, 01 May 2015 19:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=f95gPw+02gBpy7r+vMrRVRen6/NbS8Yfh3JCPnuaFqM=;
        b=wAymlgkC8/uzEubVbRtJyif/3+pjeN7Kv6lAZ+I6586TDwhNBAC0uK21iwlUwvbZ9w
         l1CO4vJflpYP8oxWhbc0L0m7i3NL9q70ghVJz9GIZlKl/lLUfg4YFdUOr0nk5bvAghgr
         mmzdmBz6Qq1zc0jvIhngCnhCs3dnomAjNqej3fakJyNYkaOpxdIQB0FG1RcHWBpgPrMJ
         04vypp61NDqUa2QMpiXKBkXHCKLby6KAgRDix5aypJ6yR9oYL0ODzDIAnEmjYISETB2Z
         AHl0QhnBe9PN2hPi6ls+LIt6AIXGCl6t7fqv44dOihHANpD2jGXpSEsCAtH5gK+UHlh3
         UXbw==
X-Received: by 10.42.76.146 with SMTP id e18mr18458994ick.42.1430532706693;
 Fri, 01 May 2015 19:11:46 -0700 (PDT)
Received: by 10.107.136.169 with HTTP; Fri, 1 May 2015 19:11:16 -0700 (PDT)
In-Reply-To: <20150502020431.GA15775@lanh>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268208>

On Sat, May 2, 2015 at 9:04 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Fri, May 01, 2015 at 09:11:01PM -0400, Jeff King wrote:
>> Unfortunately there is no way to use curly braces with git's pathspec,
>> so you have to write out three separate `*` arguments rather than using
>> the shell-style {cc,cpp,h}.
>
> Noted. Need to add curly brace support in pathspec :-)

Naah people can just do

git grep pattern -- '*'.{cc,cpp,h}

and bash will take care of expanding it into three separate arguments.
Obscure, but pathspec is also obscure..
-- 
Duy
