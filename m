From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: Fault in curl on Ubuntu 9.04 with git 1.6.3
Date: Fri, 8 May 2009 20:14:57 +0800
Message-ID: <be6fef0d0905080514qff2644cmf83889f495b64d74@mail.gmail.com>
References: <9e4733910905071907q44de8980je4008695092d4a90@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 08 14:15:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M2Oyr-0006IP-MK
	for gcvg-git-2@gmane.org; Fri, 08 May 2009 14:15:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760449AbZEHMO7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 May 2009 08:14:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761328AbZEHMO6
	(ORCPT <rfc822;git-outgoing>); Fri, 8 May 2009 08:14:58 -0400
Received: from rv-out-0506.google.com ([209.85.198.231]:25023 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760944AbZEHMO4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 May 2009 08:14:56 -0400
Received: by rv-out-0506.google.com with SMTP id f9so1105119rvb.1
        for <git@vger.kernel.org>; Fri, 08 May 2009 05:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=enISVBVpqu/1K/SStCGPyD4LXHfqiee1dgjHKBi3nWU=;
        b=U5qA+YhXtkcmaLOvUozs7TaD8GsIN6T0Y8y4C7YORtfLCiAqqYEQ27Di0gKLuMRZ/l
         KVU/phbdb0CJLfIR0zqC1MctrpVhWGCp7+CGzDUGKHM1MacaL9Fb3ZMqJAPWaCDWF5/u
         /zuNbx6GAqfpZMxGeUkZZR2lWWcwsuBgqDdTA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=V3bYLDLyGJIO/JWcKwwQePhqdmx35QKzuJhntX3ijW23N+8Bz1W7sufEro6q7Spyqq
         FSN6XuDBADzzFVWexZb9V6C0c99FXk1EwIKseLBB4+Gk/e5pzRPLUhs7rZS0558Qsb8q
         ku31JEeGVCnb82WTQLzJbfG1IG0Xkg8H4yzbk=
Received: by 10.114.211.2 with SMTP id j2mr3570084wag.139.1241784897616; Fri, 
	08 May 2009 05:14:57 -0700 (PDT)
In-Reply-To: <9e4733910905071907q44de8980je4008695092d4a90@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118602>

Hi,

On Fri, May 8, 2009 at 10:07 AM, Jon Smirl <jonsmirl@gmail.com> wrote:
> It's doing a fetch of a remote http server...
> I hit this once. Then ran the gdb and hit it again.
>
> I installed libcurl3-dbg and was unable to get it to reproduce again after that.

If it's ok, could you give us the repo url so we could try reproducing this?

-- 
Cheers,
Ray Chuan
