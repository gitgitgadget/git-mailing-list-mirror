From: Ronald Weiss <weiss.ronald@gmail.com>
Subject: Re: [PATCH 2/2] status: don't ignore submodules added to index
Date: Sun, 30 Mar 2014 01:01:42 +0100
Message-ID: <53375EE6.1020407@gmail.com>
References: <CABxC_L92v=cV=+e_DNa0L6f21LB0BRP5duai2h_heGJN_PRoUQ@mail.gmail.com>	<5335A78C.60401@web.de> <CABxC_L-4=qcZiix05dL8GrDJXv=19fw4yB0qFzRRfw=G=_Gxbg@mail.gmail.com> <53374F82.3020800@gmail.com> <53375447.2050502@web.de> <533759EB.20100@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Heiko Voigt <hvoigt@hvoigt.net>, Junio C Hamano <gitster@pobox.com>
To: Jens Lehmann <Jens.Lehmann@web.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 30 01:01:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WU3C9-00046p-4d
	for gcvg-git-2@plane.gmane.org; Sun, 30 Mar 2014 01:01:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752497AbaC3ABp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Mar 2014 20:01:45 -0400
Received: from mail-ee0-f43.google.com ([74.125.83.43]:49880 "EHLO
	mail-ee0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752326AbaC3ABo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Mar 2014 20:01:44 -0400
Received: by mail-ee0-f43.google.com with SMTP id e53so5317658eek.2
        for <git@vger.kernel.org>; Sat, 29 Mar 2014 17:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=I5u7jtkNoVEfHwuMcr5cFJCqmbE4SaExsEe9PlRnlhU=;
        b=SvJGvn6dWVTGlJDCoxpm6GQWolrarCaFxuqxkVA/KUVgMSlTmgJhP0wl6kkwIRgkhI
         W/xBO9HTYzNgKyT3t127yGaApLiBG4S7N4tdoQznM8SpHMZuCCi6I8AKSbi0hNpInTQj
         X1U01eeLWy1wbP2SAO2SHidcad3UvfNKO/r0LoYX0J9ZVqrWxfbWRyW2Ajqfhy2zR5Sq
         ZFW4N4c/X4tXAtqx4TYHnMHoB5fmAajEF65y6l0I7GiFadMAZLN86e3CmpDkggBT2wXx
         N7j/Dq7/qsiq8Xtij0mCV+xd6K/fOUl66T9/Reld3szR+wmyzWmbrJJCKjpyvdNFpGaL
         cXLg==
X-Received: by 10.14.210.65 with SMTP id t41mr20268187eeo.35.1396137703660;
        Sat, 29 Mar 2014 17:01:43 -0700 (PDT)
Received: from [10.0.1.226] (chello089173067059.chello.sk. [89.173.67.59])
        by mx.google.com with ESMTPSA id cb5sm21940013eeb.18.2014.03.29.17.01.42
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 29 Mar 2014 17:01:42 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.4.0
In-Reply-To: <533759EB.20100@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245451>

On 30. 3. 2014 0:40, Ronald Weiss wrote:
> That change was really too aggresive, the one below seems better, all
> tests pass with it, and it still works.

Oops, some tests still fail, sorry for my blindness. Nevermind, I'm 
looking forward to Your fix.
