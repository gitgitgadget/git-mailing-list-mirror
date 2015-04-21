From: =?windows-1252?Q?David_Rodr=EDguez?= <deivid.rodriguez@gmail.com>
Subject: Re: git's directory is _prepended_ to PATH when called with an absolute
 path
Date: Tue, 21 Apr 2015 18:59:42 -0300
Message-ID: <5536C84E.8060702@gmail.com>
References: <5536C319.4000402@gmail.com> <xmqqzj61f90k.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 21 23:59:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YkgCv-0001F4-Rh
	for gcvg-git-2@plane.gmane.org; Tue, 21 Apr 2015 23:59:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964865AbbDUV7t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Apr 2015 17:59:49 -0400
Received: from mail-qg0-f44.google.com ([209.85.192.44]:35416 "EHLO
	mail-qg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964892AbbDUV7s (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Apr 2015 17:59:48 -0400
Received: by qgej70 with SMTP id j70so75065297qge.2
        for <git@vger.kernel.org>; Tue, 21 Apr 2015 14:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=tMEpqD56sYSKSvUVYdw85JRQkuqvkN0vCHpXyXWnDjY=;
        b=ia3Y9/fPFHvln38gmwCigvZC3AdVNTbis95+fveYrgEURopZ79TgeI8YFsTlts4A60
         FGL/nME3dJ3MVybes80A6fDa6/+CuyC1SK7QiBeyGiLp9xIjditaWMwDnB9loestPX2A
         G+XzxGgZZaKJOSL/4Tn88IIjBfI7269YlKvSsMb4x1VAQv74omT6MPyZ4tdK+1jdjp+r
         5z+KvOTlEtDU9gzBR8pmZvwnCGJOThyuSME/wmJKJddi9aUoVlsekm8cYjyhuELT7UDl
         /PmM4+Dz3/dsTq7/FI9A4uefv4HeCp/qvJzJ3J3POa9MO2kIPltgn0lw9K70wpWaBTHr
         BheA==
X-Received: by 10.229.185.193 with SMTP id cp1mr1610698qcb.18.1429653588275;
        Tue, 21 Apr 2015 14:59:48 -0700 (PDT)
Received: from [192.168.1.103] ([186.237.38.30])
        by mx.google.com with ESMTPSA id f35sm2305978qga.10.2015.04.21.14.59.46
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Apr 2015 14:59:47 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
In-Reply-To: <xmqqzj61f90k.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267561>

Thanks Junio for the useful link, I'll comment there.

On 21/04/15 18:48, Junio C Hamano wrote:
> http://thread.gmane.org/gmane.comp.version-control.git/267143/focus=267251
