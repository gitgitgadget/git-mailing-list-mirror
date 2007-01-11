From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: MinGW port (was: Re: [ANNOUNCE] qgit4 aka qgit ported to Windows)
Date: Thu, 11 Jan 2007 13:56:09 +0100
Message-ID: <e5bfff550701110456y51b8b678s59974cc1d8655a90@mail.gmail.com>
References: <e5bfff550701091314k71e282e8x125db65d5c287a94@mail.gmail.com>
	 <46a038f90701101517s1d5e818eq2fba220d17a6aa03@mail.gmail.com>
	 <45A604ED.5EF73A1E@eudaptics.com>
	 <Pine.LNX.4.63.0701111037330.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Johannes Sixt" <J.Sixt@eudaptics.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 11 13:56:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4zTa-0000le-Rq
	for gcvg-git@gmane.org; Thu, 11 Jan 2007 13:56:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030329AbXAKM4L (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 11 Jan 2007 07:56:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030324AbXAKM4L
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Jan 2007 07:56:11 -0500
Received: from py-out-1112.google.com ([64.233.166.178]:7909 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030329AbXAKM4K (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jan 2007 07:56:10 -0500
Received: by py-out-1112.google.com with SMTP id a29so213930pyi
        for <git@vger.kernel.org>; Thu, 11 Jan 2007 04:56:10 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rBu3V9yAUzxiil7NR4BQOhDJWnI0FjMSWLIOapEAp/Rjahfe6DEudvwUH9IsZVgbmVznPDwOqwky3comkwP43CSd3AQr1eleEOTJqsc+44sRnhqJrLrgPJOlT+necCOz+X7rXsCk/8mWdItSCKRjwGI9I327bW5YOMT7tn4AB24=
Received: by 10.35.115.18 with SMTP id s18mr2494254pym.1168520170037;
        Thu, 11 Jan 2007 04:56:10 -0800 (PST)
Received: by 10.35.42.4 with HTTP; Thu, 11 Jan 2007 04:56:08 -0800 (PST)
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0701111037330.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36587>

On 1/11/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Thu, 11 Jan 2007, Johannes Sixt wrote:
>
> > This works: The tools that you commonly need to work on a local repo,
> > except merges ([*]): commit, rebase, reset, log, diff and their
> > plumbing.
> >
> > [...]
> >
> > [*] because shell scripts like merge-one-file can't be invoked from an
> > exe like merge-index, yet. Fortunately this looks like the easiest part
> > to solve.
>

>From an exe you could run:

     cmd.exe /c  <script with arguments>

Of course the problem is that the content of the script should be
understandable by cmd.exe windows interpreter.
