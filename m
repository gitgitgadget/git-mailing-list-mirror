From: =?UTF-8?Q?Vicent_Mart=C3=AD?= <tanoku@gmail.com>
Subject: Re: [ANNOUNCE] Git v1.9-rc0
Date: Wed, 22 Jan 2014 18:26:23 +0100
Message-ID: <CAFFjANTNLnc4GcVeSEvuWpfYVXJchJqkHwvUVdREdXmWx6e4=Q@mail.gmail.com>
References: <xmqq61pjzljn.fsf@gitster.dls.corp.google.com> <xmqqha8xt22p.fsf@gitster.dls.corp.google.com>
 <CALZVapmqcFjjKeURHdP4chkB+T2--caJZYiJBzdwq7Ou=HzO5w@mail.gmail.com>
 <52DFE882.2040605@atlas-elektronik.com> <xmqq7g9syp1m.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?U3RlZmFuIE7DpHdl?= <stefan.naewe@atlas-elektronik.com>,
	Javier Domingo Cansino <javierdo1@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 22 18:26:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W61Zh-0001PS-SG
	for gcvg-git-2@plane.gmane.org; Wed, 22 Jan 2014 18:26:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755419AbaAVR0q convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 22 Jan 2014 12:26:46 -0500
Received: from mail-vb0-f52.google.com ([209.85.212.52]:37562 "EHLO
	mail-vb0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753841AbaAVR0o convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Jan 2014 12:26:44 -0500
Received: by mail-vb0-f52.google.com with SMTP id p14so400203vbm.11
        for <multiple recipients>; Wed, 22 Jan 2014 09:26:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=gxrXrhaBOeQvn/3HNCII8oJWoh2dbjCVyRg0ZHjfeaU=;
        b=CJ9DbnEiXslqmtl21R11owRKyL0ki4iNZXXoHRR1GVvzFgMCpXwCZt1t5Ta7R9n1IB
         u5GCnpoU8JT+X3/T40rXuOY2C55t5paFlR1sZCamGOE+WoNOQwRvznolQmvr4WTEug0h
         h3bvEhLt2M2XyIYfwTxxRxd22qlopTWIbGxq8/agE/dxPuzgtpls6kqQuAq/h2MHf2Sp
         yPUhpUr1xcPwDgvhCgliRlazJc8j16iogPTsLbGzDyZEkKzszHNns+l3zg6/lcG5LJny
         GIV98txjeOqd1/sJb8/pQARDwxfqM1VZolTAouxZXoorBGLQy/+elq6NnABqtDiMvaFT
         h9aA==
X-Received: by 10.58.209.36 with SMTP id mj4mr81879vec.47.1390411603945; Wed,
 22 Jan 2014 09:26:43 -0800 (PST)
Received: by 10.220.133.73 with HTTP; Wed, 22 Jan 2014 09:26:23 -0800 (PST)
In-Reply-To: <xmqq7g9syp1m.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240840>

On Wed, Jan 22, 2014 at 5:11 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Stefan N=C3=A4we <stefan.naewe@atlas-elektronik.com> writes:
>
>> Am 22.01.2014 13:53, schrieb Javier Domingo Cansino:
>>> Will there be any change on how tarballs are distributed, taking in=
to
>>> account that Google will be shutting down Google Code Downloads
>>> section[1][2]?
>>>
>>
>> Am I missing something or what's wrong with this:
>>
>>   https://github.com/gitster/git/archive/v1.9-rc0.tar.gz
>>
>> or any
>>
>>   https://github.com/gitster/git/archive/$TAG.tar.gz
>>
>> ??
>
> Do these consume CPU every time somebody asks for a tarball?  That
> might be considered "wrong" depending on the view.

No, our infrastructure caches frequently requested tarballs so they
don't have to be regenerated on the fly. If you would prefer to
distribute a different version of the tarball for the release (e.g.
one with a different filename or folder structure), you can upload it
directly to the release page of the tag:

    https://github.com/gitster/git/releases/tag/v1.9-rc0

We'll automatically mirror your release to S3 and serve it from there.
You can also go ahead and edit the release page with the changelog
you've posted in this email thread to make it more user friendly.

WE WILL SERVE YOUR RELEASES, JUNIO

BECAUSE WE LOVE YOU

-vmg
