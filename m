From: Vincent van Ravesteijn <vfr@lyx.org>
Subject: Re: [PATCH] t: Replace 'perl' by $PERL_PATH
Date: Tue, 12 Jun 2012 21:29:28 +0200
Message-ID: <4FD79898.2050104@lyx.org>
References: <1339441313-5296-1-git-send-email-vfr@lyx.org> <7v1ull7j9k.fsf@alter.siamese.dyndns.org> <CABPQNSY=X8HG__vcEncdcgjT4fvqaC1gX_5_QH4n0+bX0tNT6g@mail.gmail.com> <7vsje0jyxh.fsf@alter.siamese.dyndns.org> <7vhaugjx9h.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: kusmabite@gmail.com, git@vger.kernel.org, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 12 21:29:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SeWmW-0001UM-05
	for gcvg-git-2@plane.gmane.org; Tue, 12 Jun 2012 21:29:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751360Ab2FLT3c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jun 2012 15:29:32 -0400
Received: from mail-ee0-f46.google.com ([74.125.83.46]:48590 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750782Ab2FLT3b (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jun 2012 15:29:31 -0400
Received: by eeit10 with SMTP id t10so2343872eei.19
        for <git@vger.kernel.org>; Tue, 12 Jun 2012 12:29:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding
         :x-gm-message-state;
        bh=LF0+Oo4JmtjAhgSI98djAKh1SbOx+16fo6pEpfXT8Ks=;
        b=FyxkwTPbkSVYZbxly3xO9440w3EfzcNKzfDR/0uupz0G62jyl2aB/XehoGJUhlHk/M
         IKrY6YYMb9fomlJtEuFq3DEbyWYL7Ft45fzmtVfFz2MRxcw+RleXK2Jc7uUICNBdrUcf
         +vesyjU/xBjZiKtefs9e+2XFKVDjOfY5NJdGkM4KsM+NmUk89g5JOmj9Ot1TzEKeyY0u
         b5kziBvA4+Be5EEEGTP3J80CHQniSOmt+8c59rkjOgJMNJU0YSkF4/7NdfJrkyrAcrD9
         XBJ77w60Yu8FubIRlqGArGPMAiK2lM04rt6uyWCIrWUuuoAisYo7Hjbl07Qd55kPSgiv
         2B4g==
Received: by 10.14.37.12 with SMTP id x12mr7014222eea.161.1339529370100;
        Tue, 12 Jun 2012 12:29:30 -0700 (PDT)
Received: from [192.168.1.8] (j175101.upc-j.chello.nl. [24.132.175.101])
        by mx.google.com with ESMTPS id p41sm67720673eef.5.2012.06.12.12.29.28
        (version=SSLv3 cipher=OTHER);
        Tue, 12 Jun 2012 12:29:29 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
In-Reply-To: <7vhaugjx9h.fsf@alter.siamese.dyndns.org>
X-Gm-Message-State: ALoCoQklvevOFPck3QXeSjWG3PbUTxNRqVWlauNQmRnBQPMbYzl6NEL4ZX2DAh82K/vUVfby9yjp
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199839>

Op 12-6-2012 18:44, Junio C Hamano schreef:
> Fair enough.  After all, that is why we have $PERL_PATH that can be
> used (and is used) in our Porcelain scripts.
>
>
> As to vfr's patch, I'll replace $PERL_PATH with "$PERL_PATH" and queue.

Thanks. At least I'm now certain that all scripts use the same perl 
interpreter.

The next question is whether the tests should also work with "the 
broken" perl interpreter, i.e. the one that replaces LF with CRLF. I 
also sent a patch on this issue for a single case, but there might be 
more issues, or not. I'll report back when I know more.

Vincent
