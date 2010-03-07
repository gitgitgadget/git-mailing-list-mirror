From: Stephen Boyd <bebarino@gmail.com>
Subject: Re: [PATCH 2/4] format-patch: use a string_list for headers
Date: Sun, 07 Mar 2010 13:54:52 -0800
Message-ID: <4B9420AC.1030104@gmail.com>
References: <7vk4torn8j.fsf@alter.siamese.dyndns.org>	 <1267997598-20815-3-git-send-email-bebarino@gmail.com> <40aa078e1003071344h5ef4358aif7888afdad1b4fc6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Erik Faye-Lund <kusmabite@googlemail.com>,
	git <git@vger.kernel.org>, Miklos Vajna <vmiklos@frugalware.org>,
	Steven Drake <sdrake@xnet.co.nz>,
	Junio C Hamano <gitster@pobox.com>
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Sun Mar 07 22:55:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NoORF-0001vQ-10
	for gcvg-git-2@lo.gmane.org; Sun, 07 Mar 2010 22:55:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754956Ab0CGVy6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Mar 2010 16:54:58 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:53936 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752709Ab0CGVy5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Mar 2010 16:54:57 -0500
Received: by gyh3 with SMTP id 3so558095gyh.19
        for <git@vger.kernel.org>; Sun, 07 Mar 2010 13:54:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=aFfdND7RZBjbM+B/BgWWmRJcKdRxkTe56SXjnmEybu0=;
        b=MN0QyExdEuLaMTMOmIXiSF2U/QaNgvca7J/Fu5Zkp2lO/9jSCKPmFp7IYMoxrBEf+p
         fflY2/YGc9dwcfma2hOILu5EyogaNQVZxHEI9ylxiYnJaVrwjMwBpzS+M9ZfklJJV1J4
         oNmN+IzuCE/7gYt5W00IeTIeFrXZxUebhnNNQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=YUMIbZqlOGt/RkXbShSL5ajPBp+Z73GgK5yrwYOBCO7H+ItJ98kd4jlnu38yC4XAHZ
         D2MSvOz7WMvBK2OzgfBxwVfGdtMviOrVLSrrqr3pMF64WTgcYLeYWf5FIg+hYm03LnZ3
         xwkWYLvpCrHSi2k99UxXQzroSVWcfajv8Ufpk=
Received: by 10.100.24.27 with SMTP id 27mr7789845anx.124.1267998896361;
        Sun, 07 Mar 2010 13:54:56 -0800 (PST)
Received: from [192.168.1.5] (user-0c9haca.cable.mindspring.com [24.152.169.138])
        by mx.google.com with ESMTPS id 8sm1139440yxb.25.2010.03.07.13.54.54
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 07 Mar 2010 13:54:55 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.7pre) Gecko/20091214 Shredder/3.0.1pre
In-Reply-To: <40aa078e1003071344h5ef4358aif7888afdad1b4fc6@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141739>

On 03/07/2010 01:44 PM, Erik Faye-Lund wrote:
> On Sun, Mar 7, 2010 at 10:33 PM, Stephen Boyd <bebarino@gmail.com> wrote:
>   
>> +static struct string_list extra_hdr = { .strdup_strings = 1 };
>> +static struct string_list extra_to = { .strdup_strings = 1 };
>> +static struct string_list extra_cc = { .strdup_strings = 1 };
>>
>>     
> Do we really use this C99 feature (designated initializers)? I think
> it will break MSVC builds, at least... Perhaps some other non-gcc
> platforms as well?
>   

Figured as much. Not a problem to fix. Thanks.
