From: Vikrant Varma <vikrant.varma94@gmail.com>
Subject: Re: [PATCH 1/2] help: add help_unknown_ref
Date: Thu, 02 May 2013 03:15:30 +0530
Message-ID: <51818CFA.9030305@gmail.com>
References: <1367407327-5216-1-git-send-email-vikrant.varma94@gmail.com> <1367407327-5216-2-git-send-email-vikrant.varma94@gmail.com> <CALkWK0nMMi-nmAMUGXCaJDCV29G3dOzYTosKqSw+bFzc0osiaA@mail.gmail.com> <51817319.6060201@gmail.com> <CALkWK0nJSoBoAXR=ViGan6keFzXjmDGkfKqqWkTHqF89mHDDOQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 01 23:45:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXeqO-0004IX-AK
	for gcvg-git-2@plane.gmane.org; Wed, 01 May 2013 23:45:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757616Ab3EAVpk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 May 2013 17:45:40 -0400
Received: from mail-da0-f43.google.com ([209.85.210.43]:51643 "EHLO
	mail-da0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757471Ab3EAVpj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 May 2013 17:45:39 -0400
Received: by mail-da0-f43.google.com with SMTP id h21so821711dal.30
        for <git@vger.kernel.org>; Wed, 01 May 2013 14:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=9q4KwvtC5DHNj9yZIEAja4FSEf1zVGfo2+v6RkUbsVE=;
        b=E4T9e6pkIpYmRDE4VZGdznir0w71J7B8CIOuN5rswwuVvTq241BdRpfhldMVfVtBDv
         y2ovtp4HMulRhI1H0KCyCWNmQ+sVOnNcJujvPlDat6D08JJIZYmdNg9niQ7Z2X5mSWMQ
         HXHYAiN4vMuvh5AYCmBHX5JyFAuzG+LBsKTzGRljmCwNJNua3gvhEK5RTQG8hueqYKg5
         zkQ81YdqMYNfrAAmVFt2UziqtSfaurvctP1AaCF/pEAD95cosaljcDvbMdnEzP6AhJrR
         2u/1KMuNDEmbD/+cAYcgxvdrMCXrSSt0g8H4ZwbNxo0JnvC/jOiZRFPQdzExtpc1fRTC
         b1Hw==
X-Received: by 10.66.233.97 with SMTP id tv1mr6870912pac.96.1367444738747;
        Wed, 01 May 2013 14:45:38 -0700 (PDT)
Received: from [192.168.1.109] (triband-mum-59.183.180.112.mtnl.net.in. [59.183.180.112])
        by mx.google.com with ESMTPSA id qb1sm4383491pbb.33.2013.05.01.14.45.35
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 01 May 2013 14:45:37 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:17.0) Gecko/20130328 Thunderbird/17.0.5
In-Reply-To: <CALkWK0nJSoBoAXR=ViGan6keFzXjmDGkfKqqWkTHqF89mHDDOQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223147>

On 02-05-2013 02:02, Ramkumar Ramachandra wrote:
>> ref_cb.similar_refs has already been defined. The compiler won't let me
>> assign to it unless I cast first. However, I think compound literals are a
>> C99/gcc feature. Is this better?
>>
>>          struct similar_ref_cb ref_cb = {ref, STRING_LIST_INIT_NODUP};
>
> As Johannes pointed out, ref is a variable and that is problematic.
> Leave the cast on: I didn't notice the compiler warning in my head.
>
Is it okay to use a compound literal? It's not supported in C89.
