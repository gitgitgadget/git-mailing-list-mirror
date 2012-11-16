From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: Crash when pushing large binary file
Date: Fri, 16 Nov 2012 13:25:04 +0700
Message-ID: <CACsJy8AAd0odtLDiZ+A+MhX1En_G97gF2uoHjVeJvekznY3JSw@mail.gmail.com>
References: <CA+AoP-n07k0r11O6ShOT8jHiX+TL+=p8sZoei+Gi+9gG_YyJqA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Thomas Gay <tgay@tokyois.com>
X-From: git-owner@vger.kernel.org Fri Nov 16 07:25:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TZFN9-0001Jm-4z
	for gcvg-git-2@plane.gmane.org; Fri, 16 Nov 2012 07:25:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751358Ab2KPGZg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Nov 2012 01:25:36 -0500
Received: from mail-ob0-f174.google.com ([209.85.214.174]:57915 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750999Ab2KPGZf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Nov 2012 01:25:35 -0500
Received: by mail-ob0-f174.google.com with SMTP id wc20so2496096obb.19
        for <git@vger.kernel.org>; Thu, 15 Nov 2012 22:25:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=WiXjdmmmEFe6RsDixsNalJSd5GUAaHn3hX368ken2no=;
        b=IPzKxf3Iu6lADA0meJk8AOpCmnQj5yQwUpwLn2HgT+OMYqoAC3ACFGDQ3kRz+f4Rai
         1WQM3WqCFQBDNxDfo2JfuQrdRry8MJUDxbURpIQ2tKtwffFUOu/cZHlWMRohkGFbed69
         aE8t9i1vbzlCFOlIsQ6X8jQMzJ/Gyx6J34bYNIKpsu40nyHwndlyKV5tPG6Vnz5RF1PZ
         VF6le3ltDbMFyAijbsgY4nMrc0jc1Dcub6sqfo1IOvQZTpb98xnd58IJjmVqCwwFdpW2
         3dZY2tYTEjoNUuEZTp9yu/7C5kgIpIUlMnQnB/r8amb1Pqd1k7hRe+9h0gdtd4ievR9b
         4reg==
Received: by 10.60.24.7 with SMTP id q7mr2957340oef.108.1353047134732; Thu, 15
 Nov 2012 22:25:34 -0800 (PST)
Received: by 10.182.40.163 with HTTP; Thu, 15 Nov 2012 22:25:04 -0800 (PST)
In-Reply-To: <CA+AoP-n07k0r11O6ShOT8jHiX+TL+=p8sZoei+Gi+9gG_YyJqA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209864>

On Fri, Nov 16, 2012 at 12:44 PM, Thomas Gay <tgay@tokyois.com> wrote:
> Using Git 1.8 on Mac OS X 10.7.5. I just added a large binary file to

How large exactly?

> my repo, and each time I try to push it, Git crashes. I've attached
> the crash log to this email and pasted the console output below.
>
> Counting objects: 27, done.
> Delta compression using up to 4 threads.
> Compressing objects: 100% (16/16), done.
> error: unpack-objects died of signal 11 | 76.91 MiB/s
> error: pack-objects died of signal 13
> error: failed to push some refs to 'ssh://...'

If you set receive.unpacklimit to 1 on the receiving end, does it still crash?
-- 
Duy
