From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] diff,difftool: Don't use the {0,2} notation in usage
 strings
Date: Thu, 4 Nov 2010 13:02:42 -0500
Message-ID: <20101104180242.GA16431@burratino>
References: <20101021222129.GA13262@burratino>
 <20101024155121.GA9503@headley>
 <AANLkTimpJbuZAPfvVOedstV7=UiLiDMnDaYWQLVNQ+Yc@mail.gmail.com>
 <87wrp12p00.fsf@gmail.com>
 <AANLkTinyPkGmsgbGM9qpXMNcZRzOXvtjDDEkJ-i3nWXz@mail.gmail.com>
 <87fwvl2d4d.fsf@gmail.com>
 <87hbfxgg86.fsf_-_@gmail.com>
 <20101104174917.GA30628@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?xaB0xJtww6FuIE7Em21lYw==?= <stepnem@gmail.com>,
	git@vger.kernel.org, Sverre Rabbelier <srabbelier@gmail.com>,
	Mark Lodato <lodatom@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Nov 04 19:03:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PE49e-0000is-Kc
	for gcvg-git-2@lo.gmane.org; Thu, 04 Nov 2010 19:03:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751356Ab0KDSDO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Nov 2010 14:03:14 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:38071 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751282Ab0KDSDN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Nov 2010 14:03:13 -0400
Received: by gwj21 with SMTP id 21so1617478gwj.19
        for <git@vger.kernel.org>; Thu, 04 Nov 2010 11:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=hcCu8d6bjvlsbkebR3bNlgVBvB99U+V0XroX5unGkjA=;
        b=as2epgWFRTSiP0/WmW5Aa27Ym5BG71bp8AQZJsB4+gLX0GmI/NAFApJSawCQsogcBO
         2az1E/kbg1HbGfk0dRISpoiD+KOr1JrBQ73rdcme+fiRMV6qYjNsZDwCgFP1duLmG3QY
         UWoEHyvHQTEe0AzQpD/AydojJ1jdmHLH460ZA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=czlima9weeCAz5TLtXFDC+dlDAQRA5YyDAf00kUZ2xW+9s7g524xJ4rUlIxqk4s5BB
         4R73R2dW7nSN9sQOL/a5nQBi4uKu9vrwRnyg0KYNnnzOdx3vsh+sTbyuL/y55IttS/Ct
         cjF+TPvnm5qYMeT7SQWPvTpLhVHerPcFqPR2E=
Received: by 10.151.51.10 with SMTP id d10mr1789643ybk.142.1288893790771;
        Thu, 04 Nov 2010 11:03:10 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id n28sm150246yha.16.2010.11.04.11.03.06
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 04 Nov 2010 11:03:09 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20101104174917.GA30628@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160741>

Jeff King wrote:

>   # diff between index and working tree
>   git diff [options] [--] [<path>...]
> 
>   # diff between HEAD and index
>   git diff --cached [options] [--] [<path>...]
> 
>   # diff between commit and working tree
>   git diff [options] <commit> [--] [<path>...]
> 
>   # diff between commit and index
>   git diff --cached [options] <commit> [--] [<path>...]
> 
>   # diff between commits
>   git diff [options] <commit> <commit> [--] [<path>...]
> 
>   # diff two paths
>   git diff [options] [--] <path> <path>
> 
> which obviously is way more verbose

Yes, that's way more verbose than a typical manpage synopsis.
For example, from printf(3):

SYNOPSIS
       #include <stdio.h>

       int printf(const char *format, ...);
       int fprintf(FILE *stream, const char *format, ...);
       int sprintf(char *str, const char *format, ...);
       int snprintf(char *str, size_t size, const char *format, ...);

       #include <stdarg.h>

       int vprintf(const char *format, va_list ap);
       int vfprintf(FILE *stream, const char *format, va_list ap);
       int vsprintf(char *str, const char *format, va_list ap);
       int vsnprintf(char *str, size_t size, const char *format, va_list ap);

   Feature Test Macro Requirements for glibc (see feature_test_macros(7)):

       snprintf(), vsnprintf(): _BSD_SOURCE || _XOPEN_SOURCE >= 500 || _ISOC99_SOURCE; or cc -std=c99

which would suggest that for git-diff(!) we should say something like:

SYNOPSIS

	git diff [options] [--] [<path>...]
	git diff [options] --cached [--] [<path>...]
	git diff [options] <commit> [--] [<path>...]
	git diff [options] --cached <commit> [--] [<path>...]
	git diff [options] <commit> <commit> [--] [<path>...]
	git diff [options] --no-index [--] <path> <path>

I would rather treat --cached as one of the options ("instead of
comparing the worktree, compare its cached content in the index to the
specified commit"), and if I were running the world, I'd leave off the
[options]. :)

SYNOPSIS

	git diff [--] [<path>...]
	git diff <commit> [--] [<path>...]
	git diff <commit> <commit> [--] [<path>...]
	git diff --no-index [--] <path> <path>

perhaps with some kind of reminder about --cached:

	The first two forms accept a --cached option to compare
	to staged content in the index instead of the work tree.
