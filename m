From: "Christian MICHON" <christian.michon@gmail.com>
Subject: Re: MinGW port usable
Date: Tue, 30 Jan 2007 00:08:59 +0100
Message-ID: <46d6db660701291508m4362eedchd4050e61f4989a92@mail.gmail.com>
References: <200701292320.43888.johannes.sixt@telecom.at>
	 <Pine.LNX.4.64.0701291438580.3611@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Johannes Sixt" <johannes.sixt@telecom.at>, git@vger.kernel.org
To: "Linus Torvalds" <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Jan 30 00:09:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HBfcY-0006UM-2d
	for gcvg-git@gmane.org; Tue, 30 Jan 2007 00:09:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932833AbXA2XJB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 29 Jan 2007 18:09:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932845AbXA2XJB
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Jan 2007 18:09:01 -0500
Received: from an-out-0708.google.com ([209.85.132.248]:15939 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932833AbXA2XJA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jan 2007 18:09:00 -0500
Received: by an-out-0708.google.com with SMTP id b33so802705ana
        for <git@vger.kernel.org>; Mon, 29 Jan 2007 15:09:00 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=R7P42EHIekPXs3PnfBx5hLYap2BsyGE/6urheOObwChLPwl/L6l4J0fxQ90o98bi9jVEndw7DTh+gtcJBOx8AYhQujzh7qhoJSsGSZw5VCXHXYil09N0FJSaGHMC4OrdMVW+RZRkeMq6e7eXbeZdm0XsbzMo75k6XDc0LoZV6io=
Received: by 10.114.190.6 with SMTP id n6mr311267waf.1170112139583;
        Mon, 29 Jan 2007 15:08:59 -0800 (PST)
Received: by 10.115.16.9 with HTTP; Mon, 29 Jan 2007 15:08:59 -0800 (PST)
In-Reply-To: <Pine.LNX.4.64.0701291438580.3611@woody.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38110>

On 1/29/07, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> Can you elaborate about any performance differences, especially with
> cygwin? Does this make git perform reasonably on Windows, or are the
> performance problems as bad as with cygwin?
>

I do not know about cygwin recently (else than it was slow), but I
cloned my packed git repository of all 117 2.6 linux kernels and
the "git diff" rocks on it.

git-unpack and git-repack was slow as hell, though. Maybe this
is the part to be improved. Mostly bad I/Os...

> gitk really shouldn't use either. It should probably use
>
>         git-show-ref -h -d
>
> instead, which has the same output format (modulo a space vs tab issue),
> and is entirely local, with no silly unnecessary remote connext.
>
> Something like this patch.
>
> Does that work on mingw too?
>

I'll try that tomorrow, but you'll have other reporting about it, for sure.

-- 
Christian
