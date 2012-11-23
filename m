From: Angelo Borsotti <angelo.borsotti@gmail.com>
Subject: Re: git bash does not access drive f:
Date: Fri, 23 Nov 2012 16:48:15 +0100
Message-ID: <CAB9Jk9CbwvygUJrvE-G3ZZAc1oE7NOh9eEJKtsxTPabupfNT_A@mail.gmail.com>
References: <CAB9Jk9Ae46PNRex9QrEy9gTgqAbn8KUFifmxQU4s5K5mDDmDZQ@mail.gmail.com>
	<20121123153106.GA14509@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git <git@vger.kernel.org>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Fri Nov 23 16:48:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TbvUV-0001YY-VM
	for gcvg-git-2@plane.gmane.org; Fri, 23 Nov 2012 16:48:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753952Ab2KWPsR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Nov 2012 10:48:17 -0500
Received: from mail-pa0-f46.google.com ([209.85.220.46]:44588 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753230Ab2KWPsQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Nov 2012 10:48:16 -0500
Received: by mail-pa0-f46.google.com with SMTP id bh2so3615239pad.19
        for <git@vger.kernel.org>; Fri, 23 Nov 2012 07:48:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=wbUwnTnrrthz100rTTR+R/9ElSLXsQrC9WQdOaF9vkQ=;
        b=Yxp4PMjycYgJDJQ7n4A6+bZQbJ7YGFzWyP6yc8ja7aF9KGVY9kQMsZZh+3LUogj1rR
         00IGhTIzTCHSSufHGQrhE5volHgzm+FdRw3/4kkXhccniz8E/cANmiL99HEF1lYqPQZZ
         pTlvI5Ba96MEt8psm9enZ6LUv6Wgj/G8LZlmLSV3DYHdHntxccD89qQJQKizNoB/c6h5
         Bd4WNosE3TR/svUU0+ePGJJIAfb4oOygGGQVmCc1Lqk8m0FVw7waPji79SIGvAq3BD+I
         +szf2lDgqcOHkudqnbIMBxCEMxbLrH2JHMvh6/NUzVDl/P5QDF2PCU5jP2e8RhtVrCQx
         3+rQ==
Received: by 10.66.76.98 with SMTP id j2mr11203886paw.65.1353685696087; Fri,
 23 Nov 2012 07:48:16 -0800 (PST)
Received: by 10.67.3.101 with HTTP; Fri, 23 Nov 2012 07:48:15 -0800 (PST)
In-Reply-To: <20121123153106.GA14509@book.hvoigt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210260>

Hi Heiko,

I have changed the external drive and seen that the new one works. The
issue is, I guess, that the first drive was named "My Passport", with
a space in it, while the second one is "Iomega". Spaces in drive names
are not accepted by Linux, which could explain why they are a problem
also with git bash (even if bash could access them using what is
passed to it, which is a drive letter, and not the drive name).

Thank you
-Angelo

On 23 November 2012 16:31, Heiko Voigt <hvoigt@hvoigt.net> wrote:
> Hi,
>
> On Thu, Nov 22, 2012 at 08:07:55AM +0100, Angelo Borsotti wrote:
>> I have attached an external disc, which appears on Windows as drive f:
>> in Windows Explorer.
>> Right-clicking on it displays a context menu showing (among other
>> items) Git Init Here, Git Gui and
>> Git Bash. The first two work properly on that drive.
>> However, the git bash does not. Not even the one that is run from the icon:
>>
>> $ cd f:
>> sh.exe": cd: f:: No such file or directory
>>
>>
>> Is there any way to make it access drive f?
>
> Try using the environment variable MSYS_WATCH_FSTAB=YesPlease.
>
> We have an optimization in msys that does not update the virtually
> mounted folders and makes msys executable startups faster. I had similar
> issues with mounted disk images.
>
> The other alternative: After having the external disc mounted logout and
> login again that AFAIR that should also help.
>
> Cheers Heiko
