From: Vikrant Varma <vikrant.varma94@gmail.com>
Subject: Re: [PATCH 0/2] Better advice on merge
Date: Thu, 02 May 2013 04:36:46 +0530
Message-ID: <5181A006.9050107@gmail.com>
References: <1367407327-5216-1-git-send-email-vikrant.varma94@gmail.com> <20130501182726.GL24467@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 02 01:07:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXg71-0003ld-RY
	for gcvg-git-2@plane.gmane.org; Thu, 02 May 2013 01:07:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758091Ab3EAXG4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 May 2013 19:06:56 -0400
Received: from mail-pd0-f181.google.com ([209.85.192.181]:57317 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757842Ab3EAXGz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 May 2013 19:06:55 -0400
Received: by mail-pd0-f181.google.com with SMTP id p11so10450pdj.26
        for <git@vger.kernel.org>; Wed, 01 May 2013 16:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=X/nRc8WaaNJaVoBCP21sn56ZKdlz652oLc51O26RY8w=;
        b=QEwUbW+/4XNersQVhNeXRx/S1S6I05JXD0GcuxVBKU7kSlDp31IT8WxlJOMLeTBIG9
         RghEWjFXn6fqgz1gNi2rkyrMp8H602pqAFFhDYz6O+L2YLm9IYcB+UT6WPCiPrR9beyB
         Hs0l6W+67YA4rh5eRaLAcoMCZzIpy7ZhKv7XNb4Y9r6N1kyUh4MQgd7AUY/W8fH7RrJZ
         aGckds2oZfFitzt+Dsm3f1CQC8vLUwcAyeR+LVQyUYdOsi7Q05yp5CqffkB9SG8PKCmg
         PjIICN0ELtka103WqTz/Gy42URaM3QIjl5nQovl9z4eF0wOd83oUo3IMK58rRxw9VZU6
         J4rQ==
X-Received: by 10.68.218.34 with SMTP id pd2mr6027481pbc.204.1367449614945;
        Wed, 01 May 2013 16:06:54 -0700 (PDT)
Received: from [192.168.1.109] (triband-mum-59.183.180.112.mtnl.net.in. [59.183.180.112])
        by mx.google.com with ESMTPSA id ak1sm4629680pbc.10.2013.05.01.16.06.51
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 01 May 2013 16:06:53 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:17.0) Gecko/20130328 Thunderbird/17.0.5
In-Reply-To: <20130501182726.GL24467@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223164>

On 01-05-2013 23:57, Jonathan Nieder wrote:
>   - It would be nice to add a test under t/
>

Thanks, I'll do that.

>   - Since the first patch isn't useful without or logically separate
>     from the second, this would probably be easier to read as a single
>     patch.
>

They are logically separate, even if the first isn't useful without the 
second. I wanted to segregate the task of defining a helper function 
that corrects the ref name, and changing the parts of the code that 
should use it. The reason the second is separate is that once the first 
is in place, even commands like 'checkout' can use the helper function.
