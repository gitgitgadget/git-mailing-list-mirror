From: tolga ceylan <tolga.ceylan@gmail.com>
Subject: Re: [PATCH] git-p4: format-patch to diff-tree change breaks binary
 patches
Date: Fri, 02 May 2014 22:40:57 -0700
Message-ID: <53648169.7010307@gmail.com>
References: <20140425044618.GA7058@olive> <20140426124307.GB4767@padd.com> <535C2138.3050400@gmail.com> <535C25B5.4050506@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, cdleonard@gmail.com
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Sat May 03 07:41:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WgSh7-0003D7-I6
	for gcvg-git-2@plane.gmane.org; Sat, 03 May 2014 07:41:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750823AbaECFlA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 May 2014 01:41:00 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:43013 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750768AbaECFk7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 May 2014 01:40:59 -0400
Received: by mail-pa0-f42.google.com with SMTP id bj1so6549571pad.1
        for <git@vger.kernel.org>; Fri, 02 May 2014 22:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=1FXyWgtD73wyrWxyPp+DXtVfxy0qLJ1aXgBHb7TeZdc=;
        b=HFQNT+bLAmtNDtU2MKMgGeYLT39KXkOzkgjcHIHV3yfy457TxL06cctSsBuOarFcyy
         0U1gN+25RFmRFey9OzoEwRtAfYRPg3Hldq/IAE7FheOMu4a+g1wIwRt/Mf+Ty6I6JqTc
         D1dF2uW3RE5bVSNwY4K+naHoSu9vzqYhjPep7ikQgWWDjWpjwbh9qY99ODVuZHCc6jii
         AlxAUWB4LKoN3dtcoXxj1wZo5h/zfv9JZ1D//DwWD60wlqNpTVUhpuQBxBymcaD3gfxS
         pEArosGdVtCx2fOP9WMiYJ/Q6v00vsn2PzaX46BmgSiiBRFeCa3KAnpW+TPt9X1XMVao
         IHFw==
X-Received: by 10.66.177.168 with SMTP id cr8mr43572991pac.128.1399095658793;
        Fri, 02 May 2014 22:40:58 -0700 (PDT)
Received: from [192.168.1.100] (c-98-210-144-148.hsd1.ca.comcast.net. [98.210.144.148])
        by mx.google.com with ESMTPSA id te2sm9526903pac.25.2014.05.02.22.40.57
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 02 May 2014 22:40:58 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
In-Reply-To: <535C25B5.4050506@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248018>


>
> This is the error message git-apply emits in this case:
>
> error: cannot apply binary patch to '<filename>' without full index line
> error: <filename>: patch does not apply
>
> Cheers,
> Tolga

Any feedback is appreciated.
Cheers,
Tolga
