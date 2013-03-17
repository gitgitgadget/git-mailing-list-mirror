From: Manuel Bua <manuel.bua@gmail.com>
Subject: Re: [PATCH] gitk: Add user-configurable branch bg color
Date: Sun, 17 Mar 2013 13:46:57 +0100
Message-ID: <5145BB41.3020406@gmail.com>
References: <1363464340-24883-1-git-send-email-manuel.bua@gmail.com> <CAJDDKr5XqX3dKLEiOAo7VeaofN37Q8aAN=GyMVf5-bGiiv9FDw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Paul Mackerras <paulus@samba.org>,
	Git Mailing List <git@vger.kernel.org>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 17 13:47:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UHCzr-0002jZ-Vt
	for gcvg-git-2@plane.gmane.org; Sun, 17 Mar 2013 13:47:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751209Ab3CQMrF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Mar 2013 08:47:05 -0400
Received: from mail-bk0-f53.google.com ([209.85.214.53]:46352 "EHLO
	mail-bk0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751196Ab3CQMrC (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Mar 2013 08:47:02 -0400
Received: by mail-bk0-f53.google.com with SMTP id j10so2150548bkw.12
        for <git@vger.kernel.org>; Sun, 17 Mar 2013 05:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=eC5V8nbAXqajBGSwbO//rJaYa0pgba2n9BHe9iCbxFI=;
        b=uBHoPeH8x9yVPfhXaX878dKqihcclrKNEJMd3WSWFN9OYBKbHVfVt4esnqHEwAOA6S
         ByoapvRsI4tcvCyLhp2tqoopCQXDFRmH0Tc8YqNfwLqzoIxFCWOQX9HnvXEhGgK5DNVQ
         DJ6OvdtS5pQC5TLKFoNDntGTaah0oZrQFyKwtWS1oF44IV6rJr+0UxPaeEPmonQdCMtW
         39vNrNh1JdhvGeiblTARh+sz1UhJ5RYDa3WJi3jzymps0owzMgfqudnTdz+Lji3pBmW/
         WoEX4sWts2IKs5tPsaKO0iecP7qzxcHePH8icuxlb+hvJ1ieAskZu5/Xq2zdUt6f49KJ
         7nDw==
X-Received: by 10.205.115.17 with SMTP id fc17mr5573609bkc.77.1363524420610;
        Sun, 17 Mar 2013 05:47:00 -0700 (PDT)
Received: from [192.168.5.2] (dynamic-adsl-94-39-207-144.clienti.tiscali.it. [94.39.207.144])
        by mx.google.com with ESMTPS id fy17sm3590990bkc.6.2013.03.17.05.46.58
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 17 Mar 2013 05:46:59 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130311 Thunderbird/17.0.4
In-Reply-To: <CAJDDKr5XqX3dKLEiOAo7VeaofN37Q8aAN=GyMVf5-bGiiv9FDw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218360>

On 03/17/2013 03:57 AM, David Aguilar wrote:
>
> > In some cases, the default branch background color (green) isn't
> > an optimal choice, thus it can be difficult to read.
>
> I'm just curious -- is it "difficult to read" because gitk does not 
> specify a foreground color, thus causing it to pickup a system default 
> (which can vary), or is it for a different reason?
>
> If this is the reason then I wonder whether gitk should explicitly set 
> a foreground color. Apologies if it already works that way -- I just 
> wanted to better understand the motivation behind this patch.
>

Yes, having gitk to specify a foreground color instead would probably 
solve it too: i can remember the branch rectangles were a lot more 
readable in the past, but this could probably be due to me using a dark 
system theme at the time.

For example, in my case it would look a lot more readable if the text 
was "white on green" instead of "black on green", that could be even 
hardcoded as it was with the "green" color, but the reason behind the 
choice to let the user customize it is that i think it is better to 
honour the user system colors giving the means to adjust it to match his 
actual system configuration, rather than overriding it.

Regards,
Manuel
