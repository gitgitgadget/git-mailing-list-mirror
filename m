From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 3/4] unpack-trees: trivial cleanup
Date: Mon, 3 Jun 2013 15:51:03 -0500
Message-ID: <CAMP44s0rHtrf0aa6sgQxM=vsMcYXOt5Jian-wuP9AA_rXesBmw@mail.gmail.com>
References: <1369922181-31016-1-git-send-email-felipe.contreras@gmail.com>
	<1369922181-31016-4-git-send-email-felipe.contreras@gmail.com>
	<7vzjv7glrw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 03 22:51:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ujbih-0004tG-KI
	for gcvg-git-2@plane.gmane.org; Mon, 03 Jun 2013 22:51:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757569Ab3FCUvH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Jun 2013 16:51:07 -0400
Received: from mail-lb0-f182.google.com ([209.85.217.182]:41103 "EHLO
	mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756753Ab3FCUvF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Jun 2013 16:51:05 -0400
Received: by mail-lb0-f182.google.com with SMTP id q15so2041392lbi.13
        for <git@vger.kernel.org>; Mon, 03 Jun 2013 13:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=cCaJlUu0HOroeSdkAolF1bGfe3IES94KKV3q5bxy7sE=;
        b=m25fDAHHskiZZikwYME7+sC0MeLnXcI+fI9FYOpc5Z1rzpXNDaxZcEyKSb5XVkWEKY
         Cbpo5wpO9BZKOy1kLSGoYlWsutn2B9V/JaVU/ey61fiPL3S+6LDApsRYvrDdgxxFxDAO
         miQHhFjN9KDPOVYSqu8hxSs6Q4ITjrB+WXIdcKcsBFu7hDaHDAPq8p7sqkEiKq3xKRTC
         DyXpxg+lvlPL4VUzf9WzKZbZsfIKC55O5HQZjGGQGgZiMiRycPHLrwaIVbeqVfsCJNq+
         6hQ7GkxBNEo7S/1zrjelXjKwI2dEm3a4+sicQP4wNA8veIXnezVYlkFx1fX1gOlxxGlM
         0EFQ==
X-Received: by 10.112.33.17 with SMTP id n17mr11527372lbi.72.1370292664058;
 Mon, 03 Jun 2013 13:51:04 -0700 (PDT)
Received: by 10.114.177.164 with HTTP; Mon, 3 Jun 2013 13:51:03 -0700 (PDT)
In-Reply-To: <7vzjv7glrw.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226287>

On Mon, Jun 3, 2013 at 12:13 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> dfc has not been initialized at this point.
>>
>> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
>> ---
>
> Upon the first entry to this function, because dfc is
>
>         static struct cache_entry *dfc;

Ah, I didn't notice it's static. Smells error-prone, but I guess it's
OK for now.

-- 
Felipe Contreras
