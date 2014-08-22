From: Stefan Beller <stefanbeller@gmail.com>
Subject: Re: [PATCH 00/18] Signed push
Date: Fri, 22 Aug 2014 22:38:32 +0200
Message-ID: <53F7AA48.3000601@gmail.com>
References: <1408485987-3590-1-git-send-email-gitster@pobox.com>	<53F7A119.7070704@gmail.com>	<xmqqiolknvfz.fsf@gitster.dls.corp.google.com>	<53F7A68D.2000109@gmail.com> <xmqqegw8nu1g.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 22 22:38:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XKvbb-0003KN-Ir
	for gcvg-git-2@plane.gmane.org; Fri, 22 Aug 2014 22:38:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751931AbaHVUie (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Aug 2014 16:38:34 -0400
Received: from mail-wg0-f49.google.com ([74.125.82.49]:47683 "EHLO
	mail-wg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751823AbaHVUid (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Aug 2014 16:38:33 -0400
Received: by mail-wg0-f49.google.com with SMTP id k14so11106833wgh.32
        for <git@vger.kernel.org>; Fri, 22 Aug 2014 13:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=4AH1b/BXUe1DxN+SnIuwF9Wzxe9BQkUwosQeB4/qOoE=;
        b=I37/QhJvmr2BJxKOx0MCvUL4xFVsxXMFoCDRlKZvvT/8RHIzwVP9GMyki9KPkuzpMs
         2QVcaphRsOTs+sD1jkX7wf0Mh67HExjdl2jihxBLf+XUOn4/B0S4QfZMxuckcL46JtRi
         ZdtHLxkQoH5daFA+iMZWTtUP/0Tn4jQDvnXeJYTLJBhYvjcxJMMBNsvJcsnyGP+klF7i
         ZYZWT1ISB8dpeM+UHbFW/xeBDgkE0LHl0Inzak0Ep0giWRBEl/xJn31iEHButqvJHcBK
         RMC9dCj+BiB7IrKYnEZPv5G5kTNDofTKP4wn4vAn7I+VP5gl9BzBi2T3fJMHZlKtVuSO
         aNbQ==
X-Received: by 10.194.9.228 with SMTP id d4mr5459999wjb.99.1408739912273;
        Fri, 22 Aug 2014 13:38:32 -0700 (PDT)
Received: from [192.168.1.7] (ip-109-91-30-58.hsi12.unitymediagroup.de. [109.91.30.58])
        by mx.google.com with ESMTPSA id oz9sm27019128wjb.20.2014.08.22.13.38.31
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Aug 2014 13:38:31 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.0
In-Reply-To: <xmqqegw8nu1g.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255722>

On 22.08.2014 22:33, Junio C Hamano wrote:
> Stefan Beller <stefanbeller@gmail.com> writes:
> 
>> On 22.08.2014 22:03, Junio C Hamano wrote:
>>> Stefan Beller <stefanbeller@gmail.com> writes:
>>>
>>>> So there would be tags like:
>>>> 	master_2014_08_21
>>>> 	master_2014_08_22
>>>> 	...
>>>> 	maint_2014_08_13
>>>> 	maint_2014_08_21
>>>> and so on. Whenever there is no tag at the tip of the branch, we'd
>>>> know there is something wrong.
>>>
>>> Who creates that tag?
>>>
>>
>>> My guess would be usability as tagging so many branches is cumbersome
>> for a maintainer?
> 
> Did you answer my question?  Who creates these tags?
> 

It would be up to the one who pushes, the user, or in our case you!

This way of working would require the informal notion of
'always tag the last commit before pushing.'

As I wrote in the first email, I made up this workaround and wanted to
see, what's so bad about that workaround and how to overcome the
problems. And all I could find was a burden on the maintainer/user.

Sorry,
Stefan
