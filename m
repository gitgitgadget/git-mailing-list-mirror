From: James Denholm <nod.helm@gmail.com>
Subject: Re: [PATCH] Standardize python shebangs
Date: Wed, 07 May 2014 22:03:48 +1000
Message-ID: <e5ca17b7-941d-40eb-abf1-2c0b8d79e79d@email.android.com>
References: <1399456987-24156-1-git-send-email-felipe.contreras@gmail.com> <CALKQrgc=Xa767S8ZTTYnXjHTfLOg_fDG+aT4cVqpvx4HMhO03Q@mail.gmail.com> <536a14f9de982_675a167130cb4@nysa.notmuch>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Git mailing list <git@vger.kernel.org>
To: Felipe Contreras <felipe.contreras@gmail.com>,
	Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Wed May 07 14:04:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wi0Zv-0001Z6-G1
	for gcvg-git-2@plane.gmane.org; Wed, 07 May 2014 14:04:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932567AbaEGMD7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 May 2014 08:03:59 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:33129 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932222AbaEGMD6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 May 2014 08:03:58 -0400
Received: by mail-pa0-f43.google.com with SMTP id hz1so1092005pad.16
        for <git@vger.kernel.org>; Wed, 07 May 2014 05:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:content-type:subject:from:date:to:cc
         :message-id;
        bh=T5ZXdKXdAT3BeYeSTQGNvg6WjNicMPHc0YVnfKbtmjs=;
        b=qeEvMnIaxJAh2KXjfrn6zjaZltdGhLA0/8ohNE1tXjXS9hkhl+da26oeaM1QKC0L88
         j3+9hOVx4WGKk+WQH0rswI6FeetB1vYATD+Re9L4LZ+vHJKFm/4d729Jn4DZaKOz7dCi
         GwvkTJ6A+49ED5BixRPpMuqrEv1T+xtWxeMRv78gWUIyPPiehEgwTLNqRErFda9TrEex
         mSXz9jpPX65sXX1T2DfqvOXjC/DmpivVH7JCt/kROQlySOf+0TaaLIuXp0AsIB7EnXYO
         LLepHfOgn9sc+asElv2dUjm0WNd4zwA0go7uR079W1XMYEHVZ/Y9J3gHCz4w26nJJZ/y
         1d8w==
X-Received: by 10.66.177.168 with SMTP id cr8mr18497860pac.128.1399464238261;
        Wed, 07 May 2014 05:03:58 -0700 (PDT)
Received: from [10.65.230.182] ([101.119.26.217])
        by mx.google.com with ESMTPSA id xk1sm112835711pac.21.2014.05.07.05.03.54
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 07 May 2014 05:03:57 -0700 (PDT)
User-Agent: Kaiten Mail
In-Reply-To: <536a14f9de982_675a167130cb4@nysa.notmuch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248299>

On 7 May 2014 21:11:53 GMT+10:00, Felipe Contreras <felipe.contreras@gmail.com> wrote:
>Johan Herland wrote:
>> On Wed, May 7, 2014 at 12:03 PM, Felipe Contreras
>> <felipe.contreras@gmail.com> wrote:
>> > It's better if all our scripts use the same '/usr/bin/env python'.
>> 
>> Only if they are source compatible with both Python2 and Python3. See
>> PEP394 <URL: http://legacy.python.org/dev/peps/pep-0394/ >. Otherwise
>> (for python2-only scripts) '/usr/bin/env python2' is the way to go.
>
>It doesn't matter. People and aistributions have to change them anyway.

Yeah, but they shouldn't have to. The build process is
already non-"sane", let's please not make it more so?

Moving all instances of "env python" to be "env python2",
though, that I think is a reasonable solution (if this is even
felt to be a problem).

Regards,
James Denholm.
