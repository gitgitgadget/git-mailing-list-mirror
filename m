From: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: gitignore broken in git 1.7.0.1: slash checks leading dirs
Date: Fri, 05 Mar 2010 10:07:10 +0100
Message-ID: <4B90C9BE.1030407@gmail.com>
References: <4B90C701.3070308@gmail.com> <4B90C974.2050405@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: linux-kernel-owner@vger.kernel.org Fri Mar 05 10:07:34 2010
connect(): Connection refused
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1NnTVO-0008OQ-5g
	for glk-linux-kernel-3@lo.gmane.org; Fri, 05 Mar 2010 10:07:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754295Ab0CEJHV (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Fri, 5 Mar 2010 04:07:21 -0500
Received: from fg-out-1718.google.com ([72.14.220.152]:47722 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751691Ab0CEJHO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Mar 2010 04:07:14 -0500
Received: by fg-out-1718.google.com with SMTP id 16so1352726fgg.1
        for <multiple recipients>; Fri, 05 Mar 2010 01:07:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :x-enigmail-version:content-type:content-transfer-encoding;
        bh=ZsrVlRi9NrWzX8/rSdgR8mRxwspoFCXMIK/57PltV08=;
        b=GUKjCyHOkKrTu3RHchLbhtV/BZDUzwa3LIeiVtSFYVZf4kVgLzATpvGb1Fs6DXVxTX
         6A3utaLoHc+6GT0EycPGip6nMixVDTlhvLIk1w/FIBlZ8KN/syUBJsI10qt5XLT0/xH4
         NuXfCuc5zzD/FPzFefcylETZ9KRdLQFYdVueY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        b=uWkRlthYp5SiKmBuC9kvPl63HmMwDz3eJqqp11KII2Nddk27bUadg51Q86+pL1+dRo
         hlcCe0wDPN6u0HNMSomTEM7YIWeRcbui0nqabyN2/fI4yJFUApefqusBsnF75TJ0zuk/
         AMcLrAVEQPdBKWxblsKCQH0+hF9bt5nB33lfo=
Received: by 10.87.70.13 with SMTP id x13mr799531fgk.66.1267780032604;
        Fri, 05 Mar 2010 01:07:12 -0800 (PST)
Received: from [192.168.2.129] ([217.66.174.142])
        by mx.google.com with ESMTPS id d6sm2337997fga.2.2010.03.05.01.07.10
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 05 Mar 2010 01:07:11 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; cs-CZ; rv:1.9.1.7) Gecko/20100111 SUSE/3.0.1-11.2 Thunderbird/3.0.1
In-Reply-To: <4B90C974.2050405@viscovery.net>
X-Enigmail-Version: 1.0.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141567>

On 03/05/2010 10:05 AM, Johannes Sixt wrote:
> Jiri Slaby schrieb:
>> having 'linux' line in .gitignore makes 'include/linux/vga_switcheroo.h'
>> to be ignored
> 
> That's the behavior that I would expect.
> 
>> though the documentation says:
>> ***
>> If the pattern does not contain a slash /, git treats it as a shell
>> glob pattern and checks for a match against the pathname without
>> leading directories.
>> ***
> 
> and this citation confirms my expectation. Note that it says "pathname",
> not "filename". 'include/linux' is a "pathname".

What are 'leading directories' then?

-- 
js
