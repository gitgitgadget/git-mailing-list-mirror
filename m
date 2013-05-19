From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH v5 01/15] Add new git-related helper to contrib
Date: Sun, 19 May 2013 20:45:28 +0530
Message-ID: <CALkWK0mA9zWjco1fYRu4O2QmMRJE7vd2Z3CyJj=a1VxCyymMvQ@mail.gmail.com>
References: <1368877615-9563-1-git-send-email-felipe.contreras@gmail.com>
 <1368877615-9563-2-git-send-email-felipe.contreras@gmail.com>
 <CALkWK0ke-Ns0JCt6LAzWqympWZ=2x3rRHOjnzB9QN7gc2=ckgw@mail.gmail.com> <CAMP44s1xguzX=iavUJxYXBEPOpGvJtJ_7FDHNCWMrF6qxOsuOQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Duy Nguyen <pclouds@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 19 17:16:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ue5LL-0004uW-BC
	for gcvg-git-2@plane.gmane.org; Sun, 19 May 2013 17:16:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753438Ab3ESPQK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 May 2013 11:16:10 -0400
Received: from mail-ie0-f169.google.com ([209.85.223.169]:61101 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752549Ab3ESPQJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 May 2013 11:16:09 -0400
Received: by mail-ie0-f169.google.com with SMTP id u16so12332725iet.14
        for <git@vger.kernel.org>; Sun, 19 May 2013 08:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=VqLnkJUKsk6oZEONQrjf+7WcDzbWf4bQsmSmYEZLlgM=;
        b=j7f1wv/l/ucaVOJmeY5m/7eGEVCYikHuVJvAP7hKUniBvrUgDbmJmjarQRKZ1/fDmj
         4HPC1dtxXk2Kcf3tUON0lGFoVZ/JPmYQnGrnhmk7yHZWi/9bdhMk0HuChPUsle20A3ps
         rMQmAmmK+K8xEYjwIFIVqaOy8h1ToUG1YCv3yYx9qXqBquVI1M3Td3x3g9Y6Mdf2BgFR
         955vy+4JBe9CXhHR/BdSj0ftFkkLhTwJ8/PSe24e/Xq2iK0NCjRezJRA+YZOr27ujud4
         mPCtK1Hic88gc3/BWXMoFKYcio6+iVr0ucC+jgw9DHsbOfTpBoFD61URQbqmKczF+fbM
         0D+Q==
X-Received: by 10.50.66.140 with SMTP id f12mr3071349igt.63.1368976568851;
 Sun, 19 May 2013 08:16:08 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Sun, 19 May 2013 08:15:28 -0700 (PDT)
In-Reply-To: <CAMP44s1xguzX=iavUJxYXBEPOpGvJtJ_7FDHNCWMrF6qxOsuOQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224891>

Felipe Contreras wrote:
>> Will $2 ever be nil (from fmt_person)?  ie. Why are you checking for
>> the special case " <\S+?>$"?
>
> Yes, '<email>' was valid in earlier versions of git.

There's a non-optional space before the "<email>" in your regex, which
is what I was pointing out.
