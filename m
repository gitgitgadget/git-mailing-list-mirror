From: Stefan Beller <stefanbeller@googlemail.com>
Subject: Re: [PATCH] repack: Add --version parameter
Date: Sat, 28 Sep 2013 10:53:19 +0200
Message-ID: <524698FF.4020602@googlemail.com>
References: <1380162409-18224-10-git-send-email-pclouds@gmail.com>	<1380184349-26380-1-git-send-email-stefanbeller@googlemail.com> <CAMP44s0E7=fupwfe=rm9yETmzdjFyH8vuyWY=Ce4wKg=g4-iJg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: =?UTF-8?B?RHV5IE5ndXnhu4Vu?= <pclouds@gmail.com>,
	git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 28 10:53:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VPqH3-0002Q3-9E
	for gcvg-git-2@plane.gmane.org; Sat, 28 Sep 2013 10:53:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752952Ab3I1IxJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Sep 2013 04:53:09 -0400
Received: from mail-ee0-f52.google.com ([74.125.83.52]:45628 "EHLO
	mail-ee0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752023Ab3I1IxH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Sep 2013 04:53:07 -0400
Received: by mail-ee0-f52.google.com with SMTP id c41so1647288eek.11
        for <git@vger.kernel.org>; Sat, 28 Sep 2013 01:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=XrBruNxGu/dSm4RVrc3Gkk0AAJQCC87sUxdUCkme8Dc=;
        b=B2Uab95z0b4EA/ulHru5nkWwVrog7GlTwwBGw78qF+Y9ZaA6pRad6ARyCRayCXf8Oi
         4T7Oxe4/MlPTxbpicXDsNQ8/j0sEQol0eds02gG4TmMxy1FpjiX+ldRdzSaXqWJr52E+
         9cawHiEXZjEz+E50ZRBTMUBELxGQ31STZKsg8ciEIfWLJ+u6xk506WAkAZpJmZwfIN3j
         5GYO0jDJ9ITPFjsPjy4dnLZ2716+OVEljUzAM8lPKt2xG/Sqx1HaNCFjdsF5GFNPR3vH
         j9OK1rmni7gpTrDnyG5LSVGuUlI9OXD7WV0OY4NZfEI4BwA/359wmIXzWFoyWIcNmLkO
         b2Og==
X-Received: by 10.14.172.133 with SMTP id t5mr17516137eel.35.1380358385908;
        Sat, 28 Sep 2013 01:53:05 -0700 (PDT)
Received: from [192.168.1.3] (ip-109-91-109-128.unitymediagroup.de. [109.91.109.128])
        by mx.google.com with ESMTPSA id i1sm25497433eeg.0.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 28 Sep 2013 01:53:05 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.0
In-Reply-To: <CAMP44s0E7=fupwfe=rm9yETmzdjFyH8vuyWY=Ce4wKg=g4-iJg@mail.gmail.com>
X-Enigmail-Version: 1.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235499>

On 09/26/2013 12:17 PM, Felipe Contreras wrote:
> On Thu, Sep 26, 2013 at 3:32 AM, Stefan Beller

>>  static const char *const git_repack_usage[] = {
>> @@ -22,6 +23,9 @@ static int repack_config(const char *var, const char *value, void *cb)
>>                 delta_base_offset = git_config_bool(var, value);
>>                 return 0;
>>         }
>> +       if (!strcmp(var, "core.preferredPackVersion")) {
>> +               pack_version = git_config_int(var, value);
>> +       }
> 
> The style is without braces if the block is a single line.
> 

Thanks for spotting, I should have put a "return 0;" there.

Stefan
