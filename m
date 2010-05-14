From: Ali Tofigh <alix.tofigh@gmail.com>
Subject: Re: many files, simple history
Date: Fri, 14 May 2010 12:25:52 -0400
Message-ID: <AANLkTinZ4MuAofDwhx6FZjlY6fU7_sdgIZlg7RRMH1C8@mail.gmail.com>
References: <AANLkTinHZbJ4obpa1FpT8boFWjNYpgU184HUTvki_A0G@mail.gmail.com> 
	<AANLkTimHB9jZq-SUxD2YUfCXKfTOHSxEnANETDL7i6DB@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Michael Witten <mfwitten@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 14 18:26:37 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OCxie-0000tM-PR
	for gcvg-git-2@lo.gmane.org; Fri, 14 May 2010 18:26:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755631Ab0ENQ0P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 May 2010 12:26:15 -0400
Received: from mail-qy0-f171.google.com ([209.85.221.171]:44610 "EHLO
	mail-qy0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753992Ab0ENQ0O (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 May 2010 12:26:14 -0400
Received: by qyk1 with SMTP id 1so3461690qyk.5
        for <git@vger.kernel.org>; Fri, 14 May 2010 09:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=D1sgogqmXPbsrF8GN8QBmwq76Ii3BGCb6CCj2XKzFYY=;
        b=Lq6H7Dg7iHFQSdpqicN9RPlURANHxAR0/2kPn9408LigV3/ZiuQDVM5XnkqHBalwzo
         S6WC1sUz80YqdpCSKySiUxIqCveazMKBAUywKY7e3ZjueAyn2LRyEZ2UJsqK3mflbAMG
         WM5kYEafW+JheiwigLRCTqmhpJFN36/sORNGI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=aRc5Nz2Y0XwwzKjhbcm1Zrusenk8Mmw+dIMLEaH1jNLDH+ch6PsB7hqiWicYRafRPk
         zNiUx0ieNrBbQe7VlIme63hKK6Qqrr7r0WTSWM9DGLV6/4YqdzP+WLQFNPo/MKslqH+t
         WcKsk0/0mTNivU32BBnr8cLstoGSFffsZyygk=
Received: by 10.224.53.91 with SMTP id l27mr723200qag.352.1273854372277; Fri, 
	14 May 2010 09:26:12 -0700 (PDT)
Received: by 10.229.51.84 with HTTP; Fri, 14 May 2010 09:25:52 -0700 (PDT)
In-Reply-To: <AANLkTimHB9jZq-SUxD2YUfCXKfTOHSxEnANETDL7i6DB@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147101>

On Thu, May 13, 2010 at 23:27, Michael Witten <mfwitten@gmail.com> wrote:
> On Thu, May 13, 2010 at 21:57, Ali Tofigh <alix.tofigh@gmail.com> wrote:
>> (i almost
>> always build from source code and install in non-standard locations).
>
> It would make a lot more sense to use a package manager.

you're probably right, but if i want to keep up with all my everyday
obligations, then i have to chose my battles carefully. for many
tasks, there are specialized tools that can be used, but these always
come at the expense of having to learn them. and if those tasks aren't
performed on a daily basis, then i don't stand a chance at remembering
what i've learned and i have to relearn them over and over again.

/ali

>
> You might find that Arch Linux's `pacman' provides everything that you
> need; it's really easy to define your own packages and build from
> source, allowing pacman to manage dependencies, locate which package
> owns which file, and upgrade/remove packages.
>
> I bet gentoo's `emerge' would also be viable.
>
