From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: What's cooking in git.git (Aug 2011, #02; Mon, 8)
Date: Thu, 11 Aug 2011 09:30:56 +0200
Message-ID: <201108110930.57316.jnareb@gmail.com>
References: <7v8vr3v7az.fsf@alter.siamese.dyndns.org> <m3ty9p1oaa.fsf@localhost.localdomain> <7vk4alrmjd.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 11 09:31:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QrPjY-0004dm-A5
	for gcvg-git-2@lo.gmane.org; Thu, 11 Aug 2011 09:31:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751260Ab1HKHbM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Aug 2011 03:31:12 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:43730 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751196Ab1HKHbJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Aug 2011 03:31:09 -0400
Received: by fxh19 with SMTP id 19so1485800fxh.19
        for <git@vger.kernel.org>; Thu, 11 Aug 2011 00:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=ccutiYl+Bf0k3+LIWETaz75IeNHeqYYo/37+AJ/H4RY=;
        b=Tv0qnjmiF5vxBLULUmq9EJCONth5eAM+E6vBGTlB5bEXRjuE803/Wp4bFLMbk2LDdV
         GaS/yDsg3GgygOpJK3swoApHmr52i4iICn5x8RGphHIOo1JxFVvNkEFQ/ML1lxJKsO8I
         SC4CM0PuRXvrmHzPwByUzzxfyrvgHGgGdQ2G0=
Received: by 10.223.21.220 with SMTP id k28mr12527409fab.63.1313047868252;
        Thu, 11 Aug 2011 00:31:08 -0700 (PDT)
Received: from [192.168.1.13] (abvy163.neoplus.adsl.tpnet.pl [83.8.222.163])
        by mx.google.com with ESMTPS id g16sm626532faa.3.2011.08.11.00.31.05
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 11 Aug 2011 00:31:06 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <7vk4alrmjd.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179089>

On Wed, 10 Aug 2011, Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>> --------------------------------------------------
>>> [Graduated to "master"]
>>
>>> * jn/gitweb-config-list-case (2011-07-31) 1 commit
>>>   (merged to 'next' on 2011-08-01 at 9268738)
>>>  + gitweb: Git config keys are case insensitive, make config search too
>>> 
>>> * jn/gitweb-system-config (2011-07-24) 1 commit
>>>   (merged to 'next' on 2011-08-01 at 4941e45)
>>>  + gitweb: Introduce common system-wide settings for convenience
>>
>> What happened with "[PATCH/RFC 0/6] gitweb: Improve project search"
>> series from 29.07.2011?
> 
> I dunno--you tell me ;-)
> 
> You solicited for comments, presumably you collected them and have been
> preparing a re-roll based on the comments? Or perhaps nobody was
> interested in these changes and you dropped it?

I did not get any responses, unfortunately.

The interest in gitweb patches waxes and wanes, and it looks like it is
time for waning interest.  It is a bit frustrating that there is no
response even from people who use gitweb for web interface to hosting
git repositories... but perhaps it is bad time of year.

Anyway, I plan on re-rolling search improvement series, checking if
search is covered by testsuite (IIRC it is).

-- 
Jakub Narebski
Poland
