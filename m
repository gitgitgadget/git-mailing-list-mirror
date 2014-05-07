From: James Denholm <nod.helm@gmail.com>
Subject: Re: [PATCH] Standardize python shebangs
Date: Thu, 08 May 2014 08:19:15 +1000
Message-ID: <d15f06ad-0418-48ed-a9dc-6ca1e955e75c@email.android.com>
References: <1399456987-24156-1-git-send-email-felipe.contreras@gmail.com> <vpqy4ydpiog.fsf@anie.imag.fr> <536a842838fbb_76ff7a52ec5d@nysa.notmuch> <vpqr445nxrw.fsf@anie.imag.fr> <536a9a34e8194_76ff7a52ec7f@nysa.notmuch> <vpq1tw5nw7q.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 08 00:19:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WiABW-0002oT-RJ
	for gcvg-git-2@plane.gmane.org; Thu, 08 May 2014 00:19:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752638AbaEGWT0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 May 2014 18:19:26 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:39727 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752633AbaEGWTY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 May 2014 18:19:24 -0400
Received: by mail-pa0-f49.google.com with SMTP id lj1so1743382pab.8
        for <git@vger.kernel.org>; Wed, 07 May 2014 15:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:content-type:subject:from:date:to:cc
         :message-id;
        bh=LK+lxBBzXhDa+9zbxNdkN4J6TaF/hnpzxmvMaJtNtgc=;
        b=H/6v/ogwJR4SqovUJuz6GPvHNWxP2lg3UEl6Qal1uDaMacJR+qKnKlGI+/orz+86Kx
         KeX1qH+oDMlnOk7ITymb8I0Kcn3pTMkrSAvRecoB61Pt71sGjd/5eMB+jXmu2dzQ+E/x
         EiOgOVDZwczTz6lbb+nWfygKwWSGODG4+brLVELd68R7d0/DB1tjpxPdTjzUti04/lUW
         63zZxsiiCwjQJwENhpKFHJUHY9vQb8A11FYtr6il62F4zDkSkWsgvcPzaM0HGU537I+x
         4Z7z3MjzIb1HuO78m+BCmhhKSy7CjM4zw7EX40MxeuxOJl5JAlFZCegOS0KninsBF4Uz
         YXMQ==
X-Received: by 10.66.240.197 with SMTP id wc5mr22605777pac.78.1399501164219;
        Wed, 07 May 2014 15:19:24 -0700 (PDT)
Received: from [10.68.252.199] ([101.119.26.148])
        by mx.google.com with ESMTPSA id vd8sm118090308pac.12.2014.05.07.15.19.21
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 07 May 2014 15:19:23 -0700 (PDT)
User-Agent: Kaiten Mail
In-Reply-To: <vpq1tw5nw7q.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248385>

On 8 May 2014 06:57:13 GMT+10:00, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> wrote:
>Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> Matthieu Moy wrote:
>>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>>> > If you want to use python2, then use '/usr/bin/env python2'.
>>> 
>>> Err, yes, this is what the code does before your patch.
>>
>> Not for all the instances.
>
>Well, I guess not all scripts require python2, hence not all scripts
>declare that they depend on python2.

Does it make sense for git to have a strict subset of python scripts as
version agnostic, though? Given that some scripts depend on python2
already, and hence we know that the user has python2, and these scripts
run perfectly well on python2, why not mandate that the agnostic subset
be run on python2?

Regards,
James Denholm.
