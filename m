From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 1/3] fetch: add --allow-local option
Date: Thu, 16 May 2013 16:02:36 +0530
Message-ID: <CALkWK0m=-ePHCLChrBSgD_cUk=MOSt15aYf-yXhn_LpDro88fw@mail.gmail.com>
References: <1368689474-28911-1-git-send-email-felipe.contreras@gmail.com>
 <1368689474-28911-2-git-send-email-felipe.contreras@gmail.com>
 <CALkWK0=OTBVauqpxZO5br5zRy8D_o3DzgLfaDRVx9Y_EVm19qA@mail.gmail.com>
 <CAMP44s1SWORAzBP-WO_Xc62F=YFckgU4knLyse0DSDRW33crZA@mail.gmail.com>
 <CALkWK0nT7fySb5um1RcKW2R4v6AE_EQ0gTod8_kNNJOFbwFnWQ@mail.gmail.com>
 <CAMP44s0x62h+n29osEdRvuhBtvDY7bD3m1_jDq4ZDMrgFwP0ow@mail.gmail.com>
 <CALkWK0kwia-OQj_=B7A3k6_DxCJShqoJehNQu8eApgdo=OzQwg@mail.gmail.com> <CAMP44s03C2Wi5Bwma2wK5jMisBCyBaOVQ8UXuPaec9f27A0RvQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 16 12:33:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UcvUv-0006rb-D8
	for gcvg-git-2@plane.gmane.org; Thu, 16 May 2013 12:33:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751780Ab3EPKdR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 May 2013 06:33:17 -0400
Received: from mail-ie0-f182.google.com ([209.85.223.182]:38266 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751699Ab3EPKdQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 May 2013 06:33:16 -0400
Received: by mail-ie0-f182.google.com with SMTP id a14so6035953iee.41
        for <git@vger.kernel.org>; Thu, 16 May 2013 03:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=dSOZZBW8xaLgbIV15OyKhQyKgPQ6/w6bSuWLyGPaUzM=;
        b=ydFMT3m75sNaLpkiinIfOU7e36ujbZPJknuKMaPi98QNFnjdNXvE3V1yISNYnCeD6E
         2uunmLaS/7sRIqMqp694U/Stp6YRwJguWBFgG+mqtEievfKuws44qba1XiTBphvJ5lJZ
         UgXUioO7rHNzlBDYg3Ml6Gt+D3s6L9q5fG8pnpPK9MTKfN7BkXMk+vtude25w/QZKBy5
         GviJ1/f5Re9d26dO9Ajph31XHMkAI4lTctS4rUmeWiXN+G/vHo3Sh91uQdPH8igtJoBq
         /JPVKwm9YqhSmyQkG2eIIVXveKz7mFN9R0Hk+qINRhrDYbloBetEn7SVoNr6KnK2TP61
         4R3Q==
X-Received: by 10.50.66.197 with SMTP id h5mr8507424igt.63.1368700396249; Thu,
 16 May 2013 03:33:16 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Thu, 16 May 2013 03:32:36 -0700 (PDT)
In-Reply-To: <CAMP44s03C2Wi5Bwma2wK5jMisBCyBaOVQ8UXuPaec9f27A0RvQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224552>

Felipe Contreras wrote:
> Answer: because 'git fetch .' doesn't make any sense. So if
> 'branch.HEAD.remote' is '.' it doesn't make sense to do 'git fetch .'.

I agree that 'git fetch .' is currently not useful (and I am not
against changing its behavior), but my question pertains to why you
are replacing it with the hard-coded "origin".  What happens when I
git branch -t -b devel hot-branch where branch.hot-branch.remote = ram
and not origin?
