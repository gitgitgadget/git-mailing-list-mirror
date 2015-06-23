From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v7 0/5] git bisect old/new
Date: Tue, 23 Jun 2015 13:34:20 -0700
Message-ID: <xmqqioaecgfn.fsf@gitster.dls.corp.google.com>
References: <1435006836-18182-1-git-send-email-antoine.delaite@ensimag.grenoble-inp.fr>
	<1435064084-5554-1-git-send-email-Matthieu.Moy@imag.fr>
	<xmqq381idz59.fsf@gitster.dls.corp.google.com>
	<vpqsi9imb8d.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, antoine.delaite@ensimag.grenoble-inp.fr,
	louis--alexandre.stuber@ensimag.grenoble-inp.fr,
	chriscool@tuxfamily.org, thomasxnguy@gmail.com,
	valentinduperray@gmail.com
To: Matthieu Moy <Matthieu.Moy@Grenoble-INP.fr>
X-From: git-owner@vger.kernel.org Tue Jun 23 22:34:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z7Utn-0002xM-9Q
	for gcvg-git-2@plane.gmane.org; Tue, 23 Jun 2015 22:34:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932123AbbFWUeX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Jun 2015 16:34:23 -0400
Received: from mail-ig0-f170.google.com ([209.85.213.170]:37643 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932747AbbFWUeW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jun 2015 16:34:22 -0400
Received: by igblr2 with SMTP id lr2so20364881igb.0
        for <git@vger.kernel.org>; Tue, 23 Jun 2015 13:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=9LOg5eZXec6/Wv5c2TqOagCIjcU8xQieYBJP8BWqKBk=;
        b=if0DHuZ84nGrtLxAYM3hSUOFCuaxwUERD490M9ggIX/SEjiKBbDV2La7wGP90ukU11
         zgMAwZ+Pdb+/NKXHuzsBUliK4G8Jz3wlPUEa7hubmqarFX+GKJ1VAm+/bzSkccBF152E
         4QpObsokIeB611FKlbCEDIEmzS047t3kn6vduiWjnGB84x7OH17omcTETjplCMpCPljv
         XybfbFUg+CT+6Bk3BD6rQW/jW5ASjQtFLewXfNnEHPPxDUKSgoTozWLDOtwLgDVAxi32
         1/74j/IX5Xa76Ug8iyhc6BGldaf8xq6DOYqeUUjLcLQJ/G7l7iILK1JVJGVhvqP0ZV62
         3EyA==
X-Received: by 10.50.50.98 with SMTP id b2mr4587929igo.42.1435091662056;
        Tue, 23 Jun 2015 13:34:22 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:3c90:65f7:f86b:dfda])
        by mx.google.com with ESMTPSA id o2sm482245igr.9.2015.06.23.13.34.21
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 23 Jun 2015 13:34:21 -0700 (PDT)
In-Reply-To: <vpqsi9imb8d.fsf@anie.imag.fr> (Matthieu Moy's message of "Tue,
	23 Jun 2015 22:16:34 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272507>

Matthieu Moy <Matthieu.Moy@Grenoble-INP.fr> writes:

>> It is somewhat confusing to see v3 yesterday and then this v7 next
>> day.  How did I miss v4 thru v6?
>
> Oops, I pattern-matched the wrong part when reading [PATCH v3 6/6].
> Indeed, this should have been numberred v4, I should have s/v6/v3/ in my
> sentence above.

OK.

> So, the first commit having property name_good is between base and
> branch2. So, the message seems wrong in two ways:

Yeah, I agree with you on both points.

> Actually, I think it would make sense to include my drawing above
> in a comment in the code.

Sounds like a good idea.
