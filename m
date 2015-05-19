From: =?UTF-8?B?U8OpYmFzdGllbiBHdWltbWFyYQ==?= 
	<sebastien.guimmara@gmail.com>
Subject: Re: [PATCH v8 5/5] help: respect new common command grouping
Date: Tue, 19 May 2015 19:57:48 +0200
Message-ID: <555B799C.3000606@gmail.com>
References: <1431976697-26288-1-git-send-email-sebastien.guimmara@gmail.com>	<1431976697-26288-6-git-send-email-sebastien.guimmara@gmail.com> <xmqqr3qda7kx.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git Users <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 19 19:58:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yulm8-0001OP-76
	for gcvg-git-2@plane.gmane.org; Tue, 19 May 2015 19:57:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754807AbbESR5w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 May 2015 13:57:52 -0400
Received: from mail-wi0-f177.google.com ([209.85.212.177]:35676 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751556AbbESR5v (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 May 2015 13:57:51 -0400
Received: by wicmx19 with SMTP id mx19so127151012wic.0
        for <git@vger.kernel.org>; Tue, 19 May 2015 10:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=tK33ONmeBByrXDVx0pqDTwTC0keABb/Xw2dHusiMeu4=;
        b=QWIrpSzo6eaxu8+gG71tgDfmk77fiu8vF8cxn9iQ8sSr8iuvHdwRDJmJqjw6hEvvTO
         0rC1mkzgFD6MOYhPlqu22fUUtqdkW9gHRSh7F/b/Aqc+ULPEzDskNmDwJcK844Vt/M+c
         4UuZff0TbgPdHfX5eDWHOfbe0rBYRkjoO9ADDG5GKlnIPKq8PQG6DeqKXNjq0apwRJgO
         nni0DMoNZ322H7shs/jC8YknLIBU544uU6s9F64pF4blLj+ctwhLY53HXKYmst5R/MIQ
         Bqb5wiU7ZjZg+09m71J4pH2riM3Jk16EQaSn/aohe7JWoAehiDJLpZTry/PEwL0SX4fb
         neRg==
X-Received: by 10.194.59.46 with SMTP id w14mr57464549wjq.106.1432058270176;
        Tue, 19 May 2015 10:57:50 -0700 (PDT)
Received: from [192.168.0.10] (bd231-1-88-176-208-17.fbx.proxad.net. [88.176.208.17])
        by mx.google.com with ESMTPSA id ck16sm14858982wjb.37.2015.05.19.10.57.48
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 May 2015 10:57:49 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
In-Reply-To: <xmqqr3qda7kx.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269381>

On 05/18/2015 11:39 PM, Junio C Hamano wrote:
> I cannot exactly pinpoint what bothers me, but "The typical Git
> workflow includes:" sounds a bit awkward.
>
> What does a workflow "include"?  What are components included in a
> workflow?  Are "starting a repository", "working on a single thing",
> "collabolating", etc. components that are incuded in a workflow?
>
> If so, the fact that "clone", "init", etc. are "commands that are
> commonly used in each component of the workflow" is a more important
> thing to say; in other words, the header does not explain what list
> it is presenting the user.
>
> Or does a workflow consists of "clone", "init", "add", "mv", etc.
> that are included in it?  Then it is left unexplained what the
> section headings stand for.
>
> Perhaps something like
>
> 	These are common Git commands used in various situations:
>
> may lessen the uneasiness I felt above.  I dunno.

This sounds better indeed.

>
> Other than that, this round looks ready for 'next'.
>
> I am not absolutely sure if new dependency on "awk" will not present
> portability issues, though.  So far we only used it in scripts in
> the fringes and only a few tests.
>
> Thanks.
>

We can use Eric's perl version instead of the awk one.

Should I make another series or amend this one ?

Thank you.
