From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: Windows support
Date: Wed, 25 Jul 2007 08:13:14 -0400
Message-ID: <fcaeb9bf0707250513v587d7a92lb688b52da3c28bb7@mail.gmail.com>
References: <a1bbc6950707250335m3d37d4farceffc50945e31f6c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Dmitry Kakurin" <dmitry.kakurin@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 25 14:13:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDfk5-0002Lm-2l
	for gcvg-git@gmane.org; Wed, 25 Jul 2007 14:13:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758852AbXGYMNR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 Jul 2007 08:13:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757785AbXGYMNQ
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jul 2007 08:13:16 -0400
Received: from an-out-0708.google.com ([209.85.132.251]:15540 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752059AbXGYMNP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jul 2007 08:13:15 -0400
Received: by an-out-0708.google.com with SMTP id d31so30777and
        for <git@vger.kernel.org>; Wed, 25 Jul 2007 05:13:15 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=XGcwT1X5YzR/svQf+03+1BCAGzhV4HmGcqZejZyRD1AhmGeBmHS227mivz3iW+XBd7TeMro9gForTEQ31psQUfOF9+4gLwQhqIv1xEa+ZwtPE3w9xdCSAB61KYvcjEDCnUNfgysYDVoiGhFFHYn0s6Z8OVjA62Vb3scD0y5aaiM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=b+Y1pQg4GIooVABXCAXAFjqNVWySgIKPif5LVqM4dD4+kD/2+7QkE6fIJ/nIO9rQAGtIyZufqJcR6DMprmXyR8pRFKcPd9MWZ4B1+TXlANeXNw0MAMHU9fUs7P/1Jw7kPkBN+5HfN7OJMQD8HL7XFIPu3L+6Tzjtrnzc6BdiRTE=
Received: by 10.100.178.7 with SMTP id a7mr323008anf.1185365594836;
        Wed, 25 Jul 2007 05:13:14 -0700 (PDT)
Received: by 10.100.127.17 with HTTP; Wed, 25 Jul 2007 05:13:11 -0700 (PDT)
In-Reply-To: <a1bbc6950707250335m3d37d4farceffc50945e31f6c@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53687>

On 7/25/07, Dmitry Kakurin <dmitry.kakurin@gmail.com> wrote:
> How serious are you guys about Windows support?
> I'm talking fully-functional port, not Cygwin.
> I did a lot of searching for a new SCM to switch to (from Perforce).
> And Git is my #1 choice. I love it's internals design and it's
> expressive power. I've also tested git-p4 and it has worked like a
> charm with my depot (with few tweaks that I may contribute later).
> But I do all my work on Windows so I need Git-For-Windows-Done-Right :-).
> The current mingw port is not there yet.

What features is mingw port missing?

> Transition to the new SCM must happen now, so basically I have 2 choices:
> 1. Survive for a few months with the current CygWin port of Git
> knowing that Windows support is coming

FYI, I'm working on getting rid of msys requirement from mingw port. I
can't tell you how long it would take though. Could be one month or
two.
-- 
Duy
