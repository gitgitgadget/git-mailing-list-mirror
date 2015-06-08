From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [WIP/PATCH v5 05/10] for-each-ref: introduce 'ref_array_clear()'
Date: Mon, 08 Jun 2015 20:48:34 +0530
Message-ID: <5575B24A.8040004@gmail.com>
References: <55729B78.1070207@gmail.com> <1433574581-23980-1-git-send-email-karthik.188@gmail.com> <1433574581-23980-5-git-send-email-karthik.188@gmail.com> <vpqvbey6yli.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, christian.couder@gmail.com
To: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Jun 08 17:18:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z1yp2-00064G-6P
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jun 2015 17:18:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752906AbbFHPSl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jun 2015 11:18:41 -0400
Received: from mail-pd0-f182.google.com ([209.85.192.182]:35742 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752665AbbFHPSj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jun 2015 11:18:39 -0400
Received: by pdbnf5 with SMTP id nf5so107137793pdb.2
        for <git@vger.kernel.org>; Mon, 08 Jun 2015 08:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=sCJCMGWBc4XxvTCSrG6sGUA5WI4A19CyjOqCEY8vXKU=;
        b=YhtodQMxVR0JkBwHJsocMi6yh56AOfTpunMlG9sn3dzEk4uL35VF0oVazHqf2lgUmb
         aBXCHk4fQ/89QYCYckJ2jtQjgfvEahRfRCk+4AzX/jnyrjdvRCB+dmWxe7+D1TryF8Pl
         dwZ0JAIFdV+vdSSbOKFzWm3sqUS+6ZVMTn/5cV08jEG7TGtauvTFo+X6fxuhxj85jZ0z
         gKIhZvbJzcLrZmO1xmFyomjE1pwm5kzOWeBlyqFtjMUoi/5hbKAszRCQCaRmE3cWOrRj
         JJnz6o+TjAkeQaRt4gCUf+VyWcPa608tkhTNS242WOUGv49l0lQn6i3Dpxavw1ezf+jM
         Svwg==
X-Received: by 10.66.63.8 with SMTP id c8mr31189173pas.122.1433776718810;
        Mon, 08 Jun 2015 08:18:38 -0700 (PDT)
Received: from [192.168.0.100] ([106.51.130.23])
        by mx.google.com with ESMTPSA id mq2sm2928118pbb.16.2015.06.08.08.18.36
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Jun 2015 08:18:38 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
In-Reply-To: <vpqvbey6yli.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271046>

On 06/08/2015 08:23 PM, Matthieu Moy wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
> > +/* Free all memory allocated for ref_array */
> > +void ref_array_clear(struct ref_array *array)
>
> Is this a private function? If so, then add static. If not, you probably
> want to export it in a .h file.
>
It is in ref-filter.h.

-- 
Regards,
Karthik
