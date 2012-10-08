From: Andrew Wong <andrew.kw.w@gmail.com>
Subject: Re: build deps
Date: Mon, 08 Oct 2012 12:09:53 -0400
Message-ID: <5072FAD1.1000807@gmail.com>
References: <CACnwZYe_vhH9Ui8W9D=M_8avgEugR+UvM1E+jH7fxr+8yk2UtQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Scott Chacon <schacon@gmail.com>
To: Thiago Farina <tfransosi@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 08 18:10:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TLFuG-0005wH-2j
	for gcvg-git-2@plane.gmane.org; Mon, 08 Oct 2012 18:10:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752628Ab2JHQKB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Oct 2012 12:10:01 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:63606 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751823Ab2JHQJ7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Oct 2012 12:09:59 -0400
Received: by mail-ie0-f174.google.com with SMTP id k13so9504141iea.19
        for <git@vger.kernel.org>; Mon, 08 Oct 2012 09:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=UkYJkrXR8e5CWpku9oeEL2aHwHL+15LGK8DpmP00SLw=;
        b=IM2Z03omI1zaBEKu+04KP5DmNGkkZ5OjwRur8KIcyGydEaVB5JQipcp9fV12WVfRW8
         wuaveQJLLvkv+EtoF8X9+JpxzMKM5eLM4/lk2VT6W8t6J7BggnP6v2xqdapL26OxECHI
         NCmTIhabq1YQrsZz2X7Y+3s0I8AEY/OrVS9zkBTE3RFdL4Lg1evgUA2BfYNn9NZo2w0l
         APCJT7nzcFrodzEPAgw2EcRyfID7giirRxRYGybvlSTv2bh1oObxDkcB03Wb9ybvQ9lr
         M5kY+AvjsQLbL4hQhJTLPxwT5ZpfQ3zc2wL978y0AmA2fOe1PRMAEWTIHnPLF+pNkxbr
         uLJQ==
Received: by 10.50.77.230 with SMTP id v6mr6517622igw.11.1349712599256;
        Mon, 08 Oct 2012 09:09:59 -0700 (PDT)
Received: from [192.168.1.3] ([69.165.255.59])
        by mx.google.com with ESMTPS id us4sm7102942igc.9.2012.10.08.09.09.57
        (version=SSLv3 cipher=OTHER);
        Mon, 08 Oct 2012 09:09:58 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.7) Gecko/20121007 Thunderbird/10.0.7
In-Reply-To: <CACnwZYe_vhH9Ui8W9D=M_8avgEugR+UvM1E+jH7fxr+8yk2UtQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207234>

On 10/07/12 20:39, Thiago Farina wrote:
> When trying to build from source but it's failing:
>
> $ sudo make prefix=/usr/local all
>     LINK git-credential-store
> gcc: @CHARSET_LIB@: No such file or directory
> make: *** [git-credential-store] Error 1
Did you run the "configure" script?
In the source folder, do you have either file "config.mak" or
"config.mak.autogen" ? If you do, try removing them, and compile again.
Which version are you compiling? Did you get the source files from tar?
Or from git?
