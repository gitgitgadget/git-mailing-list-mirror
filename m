From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 0/14] implement @{push} shorthand
Date: Thu, 21 May 2015 11:37:53 -0700
Message-ID: <xmqq382pkc8u.fsf@gitster.dls.corp.google.com>
References: <20150521044429.GA5857@peff.net> <20150521045233.GA26507@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu May 21 20:38:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YvVM1-00030k-2n
	for gcvg-git-2@plane.gmane.org; Thu, 21 May 2015 20:38:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756322AbbEUSh4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 May 2015 14:37:56 -0400
Received: from mail-ie0-f177.google.com ([209.85.223.177]:33738 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756320AbbEUShz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 May 2015 14:37:55 -0400
Received: by iebgx4 with SMTP id gx4so14986193ieb.0
        for <git@vger.kernel.org>; Thu, 21 May 2015 11:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=tJDfAc1XtVDz4Ytdj+3WnAnmJbCvzWRzgrBJbRESMsM=;
        b=gOCr0JrvhHlXPLnFOdHOcHAIXTiQDoiRLXl1zKBZQjFop/7JIkaEVEYD5t+k2OePer
         TXvRGc5PROe6P0GTTRXdCvedS5dYBH5eq+7werOObcW1uzLXzIROr0GTq7McTV5L1VGv
         CB7d3fN6czpOeIycHghw9PWYJAf6xuBb/Ga9Hkl6Lz6hY+P1MrzFykxKPZ9RrwUKga59
         8H/IbzkqNfk1zcN6k/CCkE1i+A1FyRdkZ5+mV4mgmFgoLpj8DZgzYyyDdgW8VUSsw3vy
         x+s1CpljzE5FuSXRJSMo+Ku78IZD5EP+rubzH+ebSo2GuV++BHOqwBUFU2rmJCBm5pd5
         uOBQ==
X-Received: by 10.42.170.74 with SMTP id e10mr4710403icz.71.1432233475054;
        Thu, 21 May 2015 11:37:55 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:c1e1:e830:c078:d79d])
        by mx.google.com with ESMTPSA id 69sm15475845ioz.10.2015.05.21.11.37.54
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 21 May 2015 11:37:54 -0700 (PDT)
In-Reply-To: <20150521045233.GA26507@peff.net> (Jeff King's message of "Thu,
	21 May 2015 00:52:34 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269641>

Jeff King <peff@peff.net> writes:

> On Thu, May 21, 2015 at 12:44:29AM -0400, Jeff King wrote:
>
>> This is a re-roll of the series at:
>> 
>>   http://thread.gmane.org/gmane.comp.version-control.git/268185
>> 
>> The only changes here are the addition of patches 2 and 6, which are
>> both cleanups that help make the other patches more readable/sensible.
>> They are the same as what was posted during review of the thread linked
>> above.  So there's nothing new here, but of course fresh reviews are
>> welcome.
>
> Actually, that's not quite true; I forgot to mention one change:
>
>>   [03/14]: remote.c: drop "remote" pointer from "struct branch"
>
> In this version, this one remembers to also update the API
> documentation.
>
> -Peff

Thanks for a pleasant read.
Will queue.
