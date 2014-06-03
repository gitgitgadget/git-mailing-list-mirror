From: Karsten Blees <karsten.blees@gmail.com>
Subject: Re: [PATCH] environment: enable core.preloadindex by default
Date: Tue, 03 Jun 2014 10:18:32 +0200
Message-ID: <538D84D8.5080604@gmail.com>
References: <CACbrTHdoA3UgoXOMVeB2ST_y-JzA2FZM7s8_uwG8C3D29WZK=Q@mail.gmail.com> <538CD827.5020607@gmail.com> <CACbrTHdyxdGWyq46GNttQ4671epLmuL9BA2Fszmua0u8a=4jSw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: Steve Hoelzer <shoelzer@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 03 10:18:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wrjvd-0006aG-OB
	for gcvg-git-2@plane.gmane.org; Tue, 03 Jun 2014 10:18:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932382AbaFCISh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jun 2014 04:18:37 -0400
Received: from mail-la0-f52.google.com ([209.85.215.52]:54873 "EHLO
	mail-la0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932109AbaFCISf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jun 2014 04:18:35 -0400
Received: by mail-la0-f52.google.com with SMTP id s18so1233397lam.25
        for <git@vger.kernel.org>; Tue, 03 Jun 2014 01:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=Dr14zInCcLgIadetLuHPEzfehRZIatXjNchNp11F/Hw=;
        b=bvDhrQVdB6uUMEjRS0FgpJCl9WcL5UmaZtpWTdAQXGg8oIvjOjPKZJGLWsm+8HDdPp
         LMVWhV9UjC07QSLL7mQjl4V9KCG+WTGoqR1MQXUwz8yKDlHEKruU0fsms5RwXxfs1QQi
         3odC3GfeOlPx+vNiw2T9v6T0+XfbvcVQI5jncFwFBQ51rQhzBFpfMSUVe4zj4nU1KY/t
         hWw+3A2cw/jZ2Z8jC7b+s/OBPQif4DXj66BUjz01NRuS7y4V2aaqSconu3ozcC5QokXP
         vOYkhEvxwINhLZj9Wr7XUhPdSN8uyQHw1qsD2slNTFbpxuLc8FAiekZa6n8Qgqf2NwlL
         zJ6g==
X-Received: by 10.152.28.194 with SMTP id d2mr33578683lah.25.1401783513345;
        Tue, 03 Jun 2014 01:18:33 -0700 (PDT)
Received: from [10.1.116.52] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id s4sm13287103las.15.2014.06.03.01.18.31
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 03 Jun 2014 01:18:32 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
In-Reply-To: <CACbrTHdyxdGWyq46GNttQ4671epLmuL9BA2Fszmua0u8a=4jSw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250619>

Am 03.06.2014 08:18, schrieb Steve Hoelzer:
> On Mon, Jun 2, 2014 at 3:01 PM, Karsten Blees <karsten.blees@gmail.com> wrote:
>> Git for Windows users may want to try core.fscache=true as well [1]. This eliminates the UAC penalties for repositories located on the Windows system drive [2].
>>
>> [1] https://github.com/msysgit/git/pull/94
>> [2] https://code.google.com/p/msysgit/issues/detail?id=320
> 
> Thanks for the tip! I didn't know about fscache, but I'll definitely
> give it a try. Is there a reason it is not turned on by default in Git
> for Windows?
> 
> Steve
> 

The feature has been merged only a few months ago, and I believe no one has found the time yet to do a thorough review of the workhorse compat/win32/fscache.[ch]. So the safe bet is to keep it turned off by default.
