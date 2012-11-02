From: Tim Janik <timj@gnu.org>
Subject: Re: Overlong lines with git-merge --log
Date: Fri, 02 Nov 2012 14:24:29 +0100
Message-ID: <5093C98D.90807@gnu.org>
References: <50932227.3090401@gnu.org> <20121102100519.GC30221@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Nov 02 14:24:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TUHEv-0003iZ-OK
	for gcvg-git-2@plane.gmane.org; Fri, 02 Nov 2012 14:24:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757530Ab2KBNYh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Nov 2012 09:24:37 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:61835 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753102Ab2KBNYg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Nov 2012 09:24:36 -0400
Received: by mail-bk0-f46.google.com with SMTP id jk13so1382325bkc.19
        for <git@vger.kernel.org>; Fri, 02 Nov 2012 06:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=FcuN9/fEIF2h8GKKLXWHTAHE8kofaavkvBhSmg53Fmc=;
        b=o5heHbz1eoYKDqgSx2XDnXYd1rzRIaGfGkB6du8nImR9zfbUet09LPaiqt0eqJsSr4
         3K/uzzW43/Tmv3GN+bkRi5J+nQjfR0EpUrfAAsqadNftAAFw0O66/qHm8pMiHnNqiMie
         1l/ZQ35+Bbv+LUH9gAiiUvqpmIt3r4utZ6zJt64h+wMCJFxVJp0Zz0iq/uML2IIACEfS
         Oyppw3rAX9NjBN3igi7jxffiQQdYCkC25bNld26vF4S/KAjXeDCcOIRyODU9J/GmxyWD
         DjL0YEkGlOJwb8MugjyT0ONUOmaLDUdYFSLIfZWGTxNDc/jE9e/ielLbhUfADEsCnE6H
         W+Tg==
Received: by 10.204.5.151 with SMTP id 23mr394946bkv.3.1351862675973;
        Fri, 02 Nov 2012 06:24:35 -0700 (PDT)
Received: from [10.111.3.19] (e176192134.adsl.alicedsl.de. [85.176.192.134])
        by mx.google.com with ESMTPS id 1sm6626140bks.3.2012.11.02.06.24.30
        (version=SSLv3 cipher=OTHER);
        Fri, 02 Nov 2012 06:24:35 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:16.0) Gecko/20121028 Thunderbird/16.0.2
In-Reply-To: <20121102100519.GC30221@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208930>

On 02.11.2012 11:05, Jeff King wrote:

> Taking just the first line of those often cuts off the useful part. It
> was deemed less bad to show the whole message as a subject rather than
> cut it off arbitrarily.

Thanks a lot for the explanation, I'm using git directly here, but the
two cases I had indeed lacked this newline.

-- 
Yours sincerely,
Tim Janik

---
http://timj.testbit.eu/ - Free software Author
