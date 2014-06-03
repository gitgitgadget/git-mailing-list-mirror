From: Steve Hoelzer <shoelzer@gmail.com>
Subject: Re: [PATCH] environment: enable core.preloadindex by default
Date: Tue, 3 Jun 2014 01:18:12 -0500
Message-ID: <CACbrTHdyxdGWyq46GNttQ4671epLmuL9BA2Fszmua0u8a=4jSw@mail.gmail.com>
References: <CACbrTHdoA3UgoXOMVeB2ST_y-JzA2FZM7s8_uwG8C3D29WZK=Q@mail.gmail.com>
 <538CD827.5020607@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Karsten Blees <karsten.blees@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 03 08:18:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wri3R-0003Mq-Se
	for gcvg-git-2@plane.gmane.org; Tue, 03 Jun 2014 08:18:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753250AbaFCGSe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jun 2014 02:18:34 -0400
Received: from mail-ob0-f182.google.com ([209.85.214.182]:55648 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752351AbaFCGSd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jun 2014 02:18:33 -0400
Received: by mail-ob0-f182.google.com with SMTP id wn1so5690439obc.27
        for <git@vger.kernel.org>; Mon, 02 Jun 2014 23:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=qSb7lo0PNJu9lAFPlCLTzZUg5BbXVnuKw0giU/Hhdjw=;
        b=PiSdvNW3eAW3XgZ2u2iQRLUVOqBRrzsA5D7cRBI4mqcKMwSb2PjwyJwnf0v6q6RUmx
         hWEZM7cixwDKKIc9xcrKKkZHpaHiqqFpOXLTKi0/e3tX1kO+D07aYmyKTtbsEoxtVP+x
         bwoBnwGwhxgx+4Q7oXQJwLlNgJQ//v36N1thNLiS80NZknjq9y8kA/04FZeNC9IV9+jX
         bU5YjDhjP3hsaKhMxvWMPBhggQu1c26kVCsknpEkQyypYOm3whwvwTjWMi/1c2BrqeBP
         RlVbUF28tGnEHO8gN5Kw1XlDO5l0hcyOyWDudTfRmkr5PAJ178/4hZkrFGeNLYr9mmcI
         AjFg==
X-Received: by 10.60.45.4 with SMTP id i4mr43593306oem.49.1401776312887; Mon,
 02 Jun 2014 23:18:32 -0700 (PDT)
Received: by 10.182.115.130 with HTTP; Mon, 2 Jun 2014 23:18:12 -0700 (PDT)
In-Reply-To: <538CD827.5020607@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250612>

On Mon, Jun 2, 2014 at 3:01 PM, Karsten Blees <karsten.blees@gmail.com> wrote:
> Git for Windows users may want to try core.fscache=true as well [1]. This eliminates the UAC penalties for repositories located on the Windows system drive [2].
>
> [1] https://github.com/msysgit/git/pull/94
> [2] https://code.google.com/p/msysgit/issues/detail?id=320

Thanks for the tip! I didn't know about fscache, but I'll definitely
give it a try. Is there a reason it is not turned on by default in Git
for Windows?

Steve
