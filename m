From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 18/19] index-helper: autorun
Date: Fri, 18 Mar 2016 14:44:41 +0700
Message-ID: <CACsJy8Amdr-2WqwYjYjyaag0jR_pq=h36QFKMk3BYQmE_A-DOw@mail.gmail.com>
References: <1457548582-28302-1-git-send-email-dturner@twopensource.com>
 <1457548582-28302-19-git-send-email-dturner@twopensource.com>
 <CACsJy8CaWFhCzrH3imz+BRMTESSmyUB4jeAaYUDNk+Tmpj-VrQ@mail.gmail.com>
 <alpine.DEB.2.20.1603151517590.4690@virtualbox> <1458151880.9385.1.camel@twopensource.com>
 <alpine.DEB.2.20.1603161923380.4690@virtualbox> <CACsJy8AsJKmsPm8Y1LRZdmyH60n3OT5X=42RGK5GXNBDfn8j8g@mail.gmail.com>
 <alpine.DEB.2.20.1603171536420.4690@virtualbox> <CACsJy8Dx4=igm3YVYkTDdRSxevDo2xRij9P5m7VPxkVrq3oq8Q@mail.gmail.com>
 <alpine.DEB.2.20.1603180752540.4690@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: David Turner <dturner@twopensource.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Mar 18 08:45:22 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agp60-0003RU-Sv
	for gcvg-git-2@plane.gmane.org; Fri, 18 Mar 2016 08:45:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753587AbcCRHpP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Mar 2016 03:45:15 -0400
Received: from mail-lb0-f177.google.com ([209.85.217.177]:36341 "EHLO
	mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753410AbcCRHpN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Mar 2016 03:45:13 -0400
Received: by mail-lb0-f177.google.com with SMTP id qe11so28746089lbc.3
        for <git@vger.kernel.org>; Fri, 18 Mar 2016 00:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=1qRxX4fcBv4BJMVQqftz/KOPW6xHRx7UwPZ1Qr/Y/es=;
        b=gLQymMckQ9hebZNqSfvp+MBkqV55L2BZqVnEgUXs2ngnoc7C1yDa5RC61F7IrxIAcC
         +oOmT/sGPp9xFsEPBfq6ZfD5NEjwMGauC2hC3DlJFDEAbqqi3vy+HKM8ZbGmbvZRmNUQ
         WsnGZryWluVwfgt/zpG6iD7Z49+tNaTyOijwFNBwVdIe4jzfcpChAeN3itkn0jtNoKuF
         4pFusifd8auoOZMPk++YLJ3nVtFvr9Mk3ZRCfM1iQdE9EzDB0UtA0Ynxubn/xjWAvYF+
         Bcxu2yCOe6SS0SLLtxQk+/xRw+YM7nMLd/EJznI7NRDx2ezLQ2OFVEwAtuUbYQLmMtUQ
         REwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=1qRxX4fcBv4BJMVQqftz/KOPW6xHRx7UwPZ1Qr/Y/es=;
        b=O97QI6yks4l9EuNMj7RMAa/ZVZGfcSo+c+aWTQIGQmSAXlTYrtVs6sFvI3sNH/z159
         W/itRRb+MtVPQZag72wr52gm8q7GrdeBN1JWkieuoSNlQKb88lmt1bchKYQkIAAFHv+2
         2KYtPC5qXfd/ksx6lXyCdaGJsx2IpzugkGWBgzg0UN2uRFOZJM/HtAR1RAen3NoQq5Gj
         ccCQzLTKIV5XQn4QeCiuNApsUoq9XVDjZ8wYRXs1gySVOLuQEy0AswoFm49VmvXehfI/
         Bzfyg98lN4fm8/+w+dECZR9aqV2YhHxu5W9Nf4ilxxzH0I7B9DcBHPZKvqrVTcKjX0h/
         llUw==
X-Gm-Message-State: AD7BkJL1rSFHHPTBGbZ5ZJF0oXHcQwpfHNqtqMVehpEgWA8O24CMzK92OfAAW5x0YTZI2mkinPqqBv7ConuuzA==
X-Received: by 10.112.150.133 with SMTP id ui5mr5082455lbb.12.1458287111287;
 Fri, 18 Mar 2016 00:45:11 -0700 (PDT)
Received: by 10.112.167.10 with HTTP; Fri, 18 Mar 2016 00:44:41 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.20.1603180752540.4690@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289210>

On Fri, Mar 18, 2016 at 2:14 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi Duy,
>
> On Fri, 18 Mar 2016, Duy Nguyen wrote:
>
>> On Thu, Mar 17, 2016 at 9:43 PM, Johannes Schindelin
>> <Johannes.Schindelin@gmx.de> wrote:
>>
>> > I know of use cases where the index weighs 300MB, and falling back to
>> > reading it directly *really* hurts.
>>
>> For crying out loud, what do you store in that repo? What I have in
>> mind for all these works are indexes in 10MB range, or maybe 50MB max.
>
> Welcome to the real world.
>
>> Very unscientifically, git.git index is about 274kb and contains ~3000
>> entries, so 94 bytes per entry on average.
>
> In terms of software projects' size, git.git is but a toy. Most developers
> deal with vastly larger (and often messier) repositories. This is
> especially true outside Open Source. Even the Linux kernel's repository is
> *tiny* compared to real-world repositories.
>
> I am sure that David could tell many a tale about repository/working
> directory size, too.

I know a few real-world repos, decades old, but I don't remember if
any of them reached this size. Did I get that 3 million entry number
right? Because even my whole /home uses over 1m inodes. And whole /usr
only has 300k files. If the number of entries is lower, maybe there's
some improvement we can do to reduce index size a bit. There's some
fast compression we can do, for starter.

> So yeah, this is the challenge: to make Git work at real-world scale
> (didn't we hear a lot about this at the latest Git Merge?)

I'm all for making Junio cry by using Git for what it is (or was) not
intended for, but this seems too much. A repo about 500k files or
less, I think I can deal with,  not those in million range.
-- 
Duy
