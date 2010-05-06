From: mat <matthieu.stigler@gmail.com>
Subject: Re: What should be the CRLF policy when win + Linux?
Date: Thu, 06 May 2010 14:57:08 +0530
Message-ID: <4BE28B6C.3070302@gmail.com>
References: <4BE141E3.2060904@gmail.com> <t2wf3271551005050627jbe328d84q23a85a1e5dced082@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, hasan.aljudy@gmail.com
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 06 11:27:28 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O9xMe-0003Zk-2X
	for gcvg-git-2@lo.gmane.org; Thu, 06 May 2010 11:27:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754955Ab0EFJ1W convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 6 May 2010 05:27:22 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:54746 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754481Ab0EFJ1V (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 May 2010 05:27:21 -0400
Received: by pwi5 with SMTP id 5so1182541pwi.19
        for <git@vger.kernel.org>; Thu, 06 May 2010 02:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=K2tYtMbYSDFQrYTVXYMBsgbFj21J2peY0kVvT3AzODo=;
        b=cAv/iq9+GljUDGkyX9dRE7VH68H7tYFn6OaThiug68jDGJA74hFeo0hNPGH+P1mgAs
         NosQqHdC6xDUhhVxmR/yaIlkYFdjISjeuqokk2WtO9R9LMPjRZUnyFV1ZixmbnCAcT3m
         eOClGwb9J43X6hxcVGxmy8hwytEk6TEzxx18c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=SP613GAl2odQ5t7UAI+g9MTl9SVjpF3m+ctotrZ/CssKxR5bS3tuHSD8vzugEQeNyQ
         X2/XHZm02M7gA/T5ZMLJvAiYWoWUuU7b0PMgzWxxIrOODrFwKJpthDBhAmtazjD/zXnD
         Qm9acyuxFl13fmTypLueqp7KfU2gJPl7SliyU=
Received: by 10.115.113.18 with SMTP id q18mr9243679wam.220.1273138040119;
        Thu, 06 May 2010 02:27:20 -0700 (PDT)
Received: from [192.168.1.3] ([59.178.204.1])
        by mx.google.com with ESMTPS id v13sm3536865wav.2.2010.05.06.02.27.14
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 06 May 2010 02:27:17 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.24 (X11/20100411)
In-Reply-To: <t2wf3271551005050627jbe328d84q23a85a1e5dced082@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146467>

Thanks for your answer!!

I think what you suggest Ramkumar is indeed what I need, great! The=20
suggestion from hasan to keep with those settings was not doable as the=
=20
windows guy had the problem of that after even a clean cloning, git was=
=20
signaling changes (see: http://help.github.com/dealing-with-lineendings=
/)

So I just did:

 git config --global --unset core.autocrlf

and then set for this specifical project:

 git config core.autocrlf true

Hope this is how you meant?

Thanks a lot!!

Matthieu

Ramkumar Ramachandra a =C3=A9crit :
> Hi,
>
> On Wed, May 5, 2010 at 12:01 PM, mat <matthieu.stigler@gmail.com> wro=
te:
>  =20
>> So I don't know exactly what I should do...Should I change all the C=
RLF from
>> project A, but people will have also problems, or can I switch the c=
onfig,
>> once I'm using project A and B? It is not so clear in my mind and I =
would
>> appreciate any advice!!
>>    =20
>
> I'm not sure what you should be doing because I've never worked with
> Windows, but the following information might be useful: Yes, you can
> have project-specific config quite easily.
>
> In the command
>  =20
>> git config --global core.autocrlf true
>>    =20
> just drop `--global` and the setting becomes repository-specific.
>
> -- Ram
>  =20
