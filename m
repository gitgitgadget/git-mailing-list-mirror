From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH/WIP v3 2/4] for-each-ref: introduce new structures for
 better organisation
Date: Fri, 29 May 2015 02:13:08 +0530
Message-ID: <55677DDC.2070601@gmail.com>
References: <5567527A.6090607@gmail.com> <1432835025-13291-2-git-send-email-karthik.188@gmail.com> <vpqegm0o3dx.fsf@anie.imag.fr> <55677C7F.6080400@gmail.com> <vpq8uc8l9k0.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, christian.couder@gmail.com
To: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu May 28 22:43:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yy4e6-0005xl-TR
	for gcvg-git-2@plane.gmane.org; Thu, 28 May 2015 22:43:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754782AbbE1UnP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 May 2015 16:43:15 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:36245 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754620AbbE1UnN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 May 2015 16:43:13 -0400
Received: by paza2 with SMTP id a2so31856998paz.3
        for <git@vger.kernel.org>; Thu, 28 May 2015 13:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=S6ml0E+D6lSAHoRapxvQYXpxC97dOZZsfxGFLQRHROM=;
        b=hoD5EEB1gUsLm6fWqzZGE/2UeGxQSAY+srZkNn7zAqdE9ShHcBuFnKSSESRMkmzT2l
         3O3ii70DONu6y/NSufdUiOK0k9er4sNTHBdtHvfOh8sUIScUnbxdMNo/Y/3jy+65hMug
         YxPfwccl+6MhOMvYMSpG9N6ZJkfk4wtN8lhdC54jtiF4NvhuKYI7cpapiygpsG2megi8
         8va4dV7/iR0+FcrugEaFRaa5AzfkY+VWg8k3pW23EC0ALSTY9EoaUmpxZeVGhOUJ3uWN
         N1hbDsA3AWVPEgUT0fs+cTcLIF/9g5ngJFSvtrDYsass6+HDO/++a6jIqdsjLOhW8xeG
         U03w==
X-Received: by 10.68.191.167 with SMTP id gz7mr8834046pbc.43.1432845793018;
        Thu, 28 May 2015 13:43:13 -0700 (PDT)
Received: from [192.168.0.100] ([106.51.130.23])
        by mx.google.com with ESMTPSA id e12sm3297763pap.40.2015.05.28.13.43.11
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 May 2015 13:43:12 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
In-Reply-To: <vpq8uc8l9k0.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270196>

On 05/29/2015 02:11 AM, Matthieu Moy wrote:
> The point of separating them is that the rename implies a relatively
> long patch (you have 17 occurences of 'refinfo' in the deletion part of
> your patch), but it is straightforward to review (apply, run "git diff
> --color-words" and press space a few times). But it is no longer so
> simple once you mix it with anything else.
>
Makes sense, thanks for putting it out.

-- 
Regards,
Karthik
