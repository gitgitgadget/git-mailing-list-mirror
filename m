From: Stefan Beller <stefanbeller@gmail.com>
Subject: Re: [PATCH 4/8] CodingGuidelines: give an example for control statements
Date: Wed, 30 Apr 2014 23:54:39 +0200
Message-ID: <5361711F.1030208@gmail.com>
References: <1398894312-30763-1-git-send-email-gitster@pobox.com> <1398894312-30763-5-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 30 23:54:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WfcSb-0000Gg-Si
	for gcvg-git-2@plane.gmane.org; Wed, 30 Apr 2014 23:54:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964913AbaD3Vye (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Apr 2014 17:54:34 -0400
Received: from mail-ee0-f54.google.com ([74.125.83.54]:64279 "EHLO
	mail-ee0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759042AbaD3Vyd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Apr 2014 17:54:33 -0400
Received: by mail-ee0-f54.google.com with SMTP id d49so1780096eek.41
        for <git@vger.kernel.org>; Wed, 30 Apr 2014 14:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=lv4VkD720NL6g0In5zIKm6Vg8ZfAx7lkU8VJ0dyEqdE=;
        b=p+Z5pm59zmbeK6uIfHGCcFCuxqkESixT1p7OujfYReG7GF6yQfDS4JfEU30/+++EA0
         kIcyg4c3l4u1n7CCJvkNzQgNhbnHkGIIWiGs2R7KFJkK0d95gVdOEKae3xGgT3C5MeId
         1QvQ5I0isv6NEietMW20RuFNOzn+69zaJqzB9kjrpLYh5D9SlsL+Chht3IvrbLVJIUKq
         ooUSSgG/Wvr7UxPR82cpXGhuOX969NDhcl8sZ79yIb9iwBhEtzVvAmVSZp3F2LvXwkzB
         4hnOji2sZZ30KZb5Cv0QBLklckUtzgrnSb/lki8XlmFy74MIunmd9uRtFYW89RupwZLl
         xNKw==
X-Received: by 10.14.175.200 with SMTP id z48mr6554280eel.66.1398894872255;
        Wed, 30 Apr 2014 14:54:32 -0700 (PDT)
Received: from [192.168.1.7] (ip-178-200-168-156.unitymediagroup.de. [178.200.168.156])
        by mx.google.com with ESMTPSA id y51sm71094387eeu.0.2014.04.30.14.54.31
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 30 Apr 2014 14:54:31 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.4.0
In-Reply-To: <1398894312-30763-5-git-send-email-gitster@pobox.com>
X-Enigmail-Version: 1.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247794>

On 30.04.2014 23:45, Junio C Hamano wrote:
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  Documentation/CodingGuidelines | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
> index 1e0c4cf..d72e912 100644
> --- a/Documentation/CodingGuidelines
> +++ b/Documentation/CodingGuidelines
> @@ -97,6 +97,17 @@ For shell scripts specifically (not exhaustive):
>     "then" should be on the next line for if statements, and "do"
>     should be on the next line for "while" and "for".
>  
> +	(incorrect)

At the other patches you used #comments behind oneliners,
not sure if that's also suitable here for consistency of the documentation.

> +	if test -f hello; then
> +		do this
> +	fi
> +
> +	(correct)
> +	if test -f hello
> +	then
> +		do this
> +	fi
> +
>   - We prefer "test" over "[ ... ]".
>  
>   - We do not write the noiseword "function" in front of shell
> 
