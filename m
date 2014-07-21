From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fixup! Win32: Unicode environment (outgoing)
Date: Mon, 21 Jul 2014 09:32:52 -0700
Message-ID: <xmqq4myalljf.fsf@gitster.dls.corp.google.com>
References: <1405611486-10176-1-git-send-email-kasal@ucw.cz>
	<1405611486-10176-3-git-send-email-kasal@ucw.cz>
	<53CAC33E.9000009@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Stepan Kasal <kasal@ucw.cz>,  GIT Mailing-list <git@vger.kernel.org>,  msysGit <msysgit@googlegroups.com>,  Karsten Blees <blees@dcon.de>
To: Karsten Blees <karsten.blees@gmail.com>
X-From: msysgit+bncBCG77UMM3EJRBPUBWWPAKGQEJBLMEKA@googlegroups.com Mon Jul 21 18:33:05 2014
Return-path: <msysgit+bncBCG77UMM3EJRBPUBWWPAKGQEJBLMEKA@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-ie0-f185.google.com ([209.85.223.185])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCG77UMM3EJRBPUBWWPAKGQEJBLMEKA@googlegroups.com>)
	id 1X9GWO-0000BY-3U
	for gcvm-msysgit@m.gmane.org; Mon, 21 Jul 2014 18:33:04 +0200
Received: by mail-ie0-f185.google.com with SMTP id tr6sf2133772ieb.12
        for <gcvm-msysgit@m.gmane.org>; Mon, 21 Jul 2014 09:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type;
        bh=DoQ6zWzNF7HpDOIhXIj1i5KXslUQOkrLNwcumMhz0iM=;
        b=QdJrfvve+6kdfVa8paVYa/all88RxnC8IcKwDGPOE9LfqmTG0TJ/QY4BFTtyEcEvEa
         Ro6gpaq9cY/BWeX6Z2H/xgXXyLhu9tTIpUduK2++sZ5POESnyacjQ7VoUmy3p5P7lBGy
         JVckIyhh0tXTQ5ikq/9i4WB6MNIMeyJR83mCrKHGF8C67+X0Kxu2xMlUM/R94LsJbaKO
         4LQQg5QfQFUqZdkW07TSt6bPAwaMkO7VnWsFMGKrWJ6IRiyhx/ZjJzkME5QiS40pxcd4
         rsWY/FjqbU2FvuZmQ7yBAZoNUk0WYxeIpdrOQb/LerTM1BnsPchQvktRTmSpKJwiliCg
         EjWQ==
X-Received: by 10.50.97.74 with SMTP id dy10mr99995igb.1.1405960383084;
        Mon, 21 Jul 2014 09:33:03 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.50.17.97 with SMTP id n1ls1682468igd.5.gmail; Mon, 21 Jul 2014
 09:33:02 -0700 (PDT)
X-Received: by 10.42.39.140 with SMTP id h12mr4636236ice.9.1405960382048;
        Mon, 21 Jul 2014 09:33:02 -0700 (PDT)
Received: from smtp.pobox.com (smtp.pobox.com. [208.72.237.35])
        by gmr-mx.google.com with ESMTP id l23si1052820yhg.1.2014.07.21.09.33.01
        for <msysgit@googlegroups.com>;
        Mon, 21 Jul 2014 09:33:01 -0700 (PDT)
Received-SPF: pass (google.com: domain of junio@pobox.com designates 208.72.237.35 as permitted sender) client-ip=208.72.237.35;
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A7AAF2990E;
	Mon, 21 Jul 2014 12:33:01 -0400 (EDT)
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9AFFF2990D;
	Mon, 21 Jul 2014 12:33:01 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 475A629900;
	Mon, 21 Jul 2014 12:32:54 -0400 (EDT)
In-Reply-To: <53CAC33E.9000009@gmail.com> (Karsten Blees's message of "Sat, 19
	Jul 2014 21:13:02 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: AA4AEC06-10F4-11E4-B3D4-9903E9FBB39C-77302942!pb-smtp0.pobox.com
X-Original-Sender: gitster@pobox.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of junio@pobox.com designates 208.72.237.35 as permitted
 sender) smtp.mail=junio@pobox.com;       dkim=pass header.i=@pobox.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/msysgit/subscribe>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253974>

Karsten Blees <karsten.blees@gmail.com> writes:

> compat/mingw.c needs to #include "cache.h" for ALLOC_GROW.
>
> Signed-off-by: Karsten Blees <blees@dcon.de>
> ---

Thanks!

>  compat/mingw.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/compat/mingw.c b/compat/mingw.c
> index bd45950..c725a3e 100644
> --- a/compat/mingw.c
> +++ b/compat/mingw.c
> @@ -4,6 +4,7 @@
>  #include <wchar.h>
>  #include "../strbuf.h"
>  #include "../run-command.h"
> +#include "../cache.h"
>  
>  static const int delay[] = { 0, 1, 10, 20, 40 };
>  
> -- 
> 2.0.2.897.g7f80809.dirty
>
> -- 

-- 
-- 
*** Please reply-to-all at all times ***
*** (do not pretend to know who is subscribed and who is not) ***
*** Please avoid top-posting. ***
The msysGit Wiki is here: https://github.com/msysgit/msysgit/wiki - Github accounts are free.

You received this message because you are subscribed to the Google
Groups "msysGit" group.
To post to this group, send email to msysgit@googlegroups.com
To unsubscribe from this group, send email to
msysgit+unsubscribe@googlegroups.com
For more options, and view previous threads, visit this group at
http://groups.google.com/group/msysgit?hl=en_US?hl=en

--- 
You received this message because you are subscribed to the Google Groups "msysGit" group.
To unsubscribe from this group and stop receiving emails from it, send an email to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
