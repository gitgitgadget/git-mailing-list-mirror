From: Adam Spiers <git@adamspiers.org>
Subject: Re: [PATCH] pathspec.c: Fix some sparse warnings
Date: Sun, 28 Oct 2012 23:31:35 +0000
Message-ID: <CAOkDyE8BF2u0zqpZb9eQQ_hsNWzYhf1=DteAFK3QXmAONjGVbQ@mail.gmail.com>
References: <508D9EFF.3040900@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Jeff King <peff@peff.net>,
	GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Mon Oct 29 00:31:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TScKd-00029i-Qr
	for gcvg-git-2@plane.gmane.org; Mon, 29 Oct 2012 00:31:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757103Ab2J1Xbi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Oct 2012 19:31:38 -0400
Received: from mail-wg0-f42.google.com ([74.125.82.42]:43546 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757051Ab2J1Xbh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Oct 2012 19:31:37 -0400
Received: by mail-wg0-f42.google.com with SMTP id fm10so1169569wgb.1
        for <git@vger.kernel.org>; Sun, 28 Oct 2012 16:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=uQtDd9hb72s6xXWsVeau59tRgL7KuJKEPtPgYrvoun8=;
        b=nFu8/nomtbtaXYuw/RZgvwqmTLLdu72Yj9Ek8WH+rwO6EXRunCUQOhdjXwIfRjzBun
         Z0UB2/ighuKmw+OFRnN+nc/CUK3gptQqmtluFFyx50Skv6+aflu980FqSRnyJQWuY7xO
         glguIG9w5uvt6vtpx++dfvqhMOAb5D8FfohhHFfQ7bGi6628rash+BTk4XJTAgLSMe68
         emyEZg0bdXSBxEVU5h68oQ7hTkdOs5d+fOium4VTfP78T6YNAEM6NJPH3gGURnTobRXW
         Moz2rH/41dtRbpO4LeYCoWfeaO76ACSfXw6UyC4vDMJMn/kvztewYjZHzQZJcDemiLgl
         6VnQ==
Received: by 10.180.78.170 with SMTP id c10mr3646086wix.5.1351467095549; Sun,
 28 Oct 2012 16:31:35 -0700 (PDT)
Received: by 10.194.56.232 with HTTP; Sun, 28 Oct 2012 16:31:35 -0700 (PDT)
In-Reply-To: <508D9EFF.3040900@ramsay1.demon.co.uk>
X-Google-Sender-Auth: JC1v8BGY4sFAxgErrWhFe3mazFU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208575>

On Sun, Oct 28, 2012 at 9:09 PM, Ramsay Jones
<ramsay@ramsay1.demon.co.uk> wrote:
> Sparse issues a warning for all six external symbols defined in this
> file. In order to suppress the warnings, we include the 'pathspec.h'
> header file, which contains the relevant extern declarations for these
> symbols.
>
> Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
> ---
>
> Hi Nguyen,
>
> I asked Adam to squash this patch into his 'as/check-ignore' branch
> when he next re-rolled the branch. However, it appears that you
> resubmitted that branch instead ... :-D
>
> I don't know if this branch is ready to progress to next yet, but
> could somebody (yourself, Adam or Jeff?) please squash this into
> commit 1a88ae42 ("pathspec.c: move reusable code from builtin/add.c")
> before it hits next.

Noted - thanks a lot Ramsay.  My diary is a bit gentler this week so
I'm hoping to get some attention back on these patch series.
