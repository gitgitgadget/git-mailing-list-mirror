From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: Fault in curl on Ubuntu 9.04 with git 1.6.3
Date: Fri, 8 May 2009 11:06:58 -0400
Message-ID: <9e4733910905080806m4df381b4r75b6c7b8cb722f58@mail.gmail.com>
References: <9e4733910905071907q44de8980je4008695092d4a90@mail.gmail.com>
	 <be6fef0d0905080514qff2644cmf83889f495b64d74@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 08 17:07:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M2RfP-0005UF-7t
	for gcvg-git-2@gmane.org; Fri, 08 May 2009 17:07:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752603AbZEHPG7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 May 2009 11:06:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751481AbZEHPG7
	(ORCPT <rfc822;git-outgoing>); Fri, 8 May 2009 11:06:59 -0400
Received: from mail-qy0-f129.google.com ([209.85.221.129]:48764 "EHLO
	mail-qy0-f129.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751201AbZEHPG6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 May 2009 11:06:58 -0400
Received: by qyk35 with SMTP id 35so871624qyk.33
        for <git@vger.kernel.org>; Fri, 08 May 2009 08:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=DkGpkNbgWtqJGYnpnKXCusMP1i9TjkaLXufQaFKZ8T0=;
        b=vCbRhKmoLPgB+Ur16RRn/ubIUI1K/Q2YiCcZhkWb335Pe8Set4JZZqWkiJFcgi+VP+
         0yY4L/e9AkxCi22dY0jAbIgngpK0wWAsyyTsQJHU7SrM/mNGgmmgUxxcN4WP3UEQySti
         Smh95QpSY40AApQ/hRgHwzjp9wN7ktuM8u2jk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=OnVJ1VGf54FIrUobNAUT7ywiM6iNp3en+876vY3xFXkQPLx7fZR/1WpLRcwUGJWYPg
         frEArg0m0YkHoeoAiKNuFlpV7SePqHvoB8emXRqXy8ip9ItvXl3dNZ8aQpaEeKr64Huq
         hZJIXlAanL0CLbX98lLMD15qG4PHluy0kZDyg=
Received: by 10.220.74.3 with SMTP id s3mr8061029vcj.54.1241795218380; Fri, 08 
	May 2009 08:06:58 -0700 (PDT)
In-Reply-To: <be6fef0d0905080514qff2644cmf83889f495b64d74@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118610>

On Fri, May 8, 2009 at 8:14 AM, Tay Ray Chuan <rctay89@gmail.com> wrote:
> Hi,
>
> On Fri, May 8, 2009 at 10:07 AM, Jon Smirl <jonsmirl@gmail.com> wrote:
>> It's doing a fetch of a remote http server...
>> I hit this once. Then ran the gdb and hit it again.
>>
>> I installed libcurl3-dbg and was unable to get it to reproduce again after that.
>
> If it's ok, could you give us the repo url so we could try reproducing this?

Packages are from the main US Ubuntu Jaunty repo. I'm on amd64.


>
> --
> Cheers,
> Ray Chuan
>



-- 
Jon Smirl
jonsmirl@gmail.com
