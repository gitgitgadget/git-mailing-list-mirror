From: Jeremy Morton <jeremy@configit.com>
Subject: Re: git push default behaviour?
Date: Sat, 17 Mar 2012 09:38:42 +0000
Message-ID: <CAFsnPqpS7srjHu1Wnx60qcwN_PV83uxvtWoniFBgRH2MjJzzzA@mail.gmail.com>
References: <CAFsnPqp1+jX3ZY0LZ1QDmvA=2_ebApPBttwFjr36OuTX2_MHug@mail.gmail.com>
	<CAAGHeXHWfEAym63jXFNvcBddp00joBzNuFEjhKZpqDQcn1d0kA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Sebastien Douche <sdouche@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 17 10:38:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S8q65-0005IL-HC
	for gcvg-git-2@plane.gmane.org; Sat, 17 Mar 2012 10:38:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964838Ab2CQJip convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 17 Mar 2012 05:38:45 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:58807 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754568Ab2CQJio convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 17 Mar 2012 05:38:44 -0400
Received: by lbbgm6 with SMTP id gm6so2482443lbb.19
        for <git@vger.kernel.org>; Sat, 17 Mar 2012 02:38:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding:x-gm-message-state;
        bh=yPqSd0p2LKn/CcD+rVo1SKRFu31fTvFgvgvPRHQBM1E=;
        b=mrGh37Aayi1yhUX8j/ZYDCQ8X/Ng1e85/U2Vt88DTnZvquZDNqSt7mGXQe/g0r/4Pt
         REXfkRTYKbwZCYdLYYV8Xq/t9UXocISY5Drvjv9ZuXCFJUFpcpLETTieNWdm4zJTJSZ+
         pDc3Edr/N5v+q2yNxkNkt2ul1oWOm3QOfSznWijzMLPrZR/aAYDKT6ent1SbOgH10Npd
         1smV9h/mM9xUZG5YutiUiRK0HJEhEX6JFMF5NbLfxpjrlhuY5JgwIStiylmFGY0HyEI4
         TxiKFYKnWJk2zTzaxntS9ocp9Mj1nYiea8j5we2l8syL5vJkcOW4SDtety8FkhJt1VnX
         E0WQ==
Received: by 10.152.127.136 with SMTP id ng8mr4204875lab.16.1331977122853;
 Sat, 17 Mar 2012 02:38:42 -0700 (PDT)
Received: by 10.112.23.225 with HTTP; Sat, 17 Mar 2012 02:38:42 -0700 (PDT)
In-Reply-To: <CAAGHeXHWfEAym63jXFNvcBddp00joBzNuFEjhKZpqDQcn1d0kA@mail.gmail.com>
X-Gm-Message-State: ALoCoQkUE1lqs5tedaBKBqJBZmT0e3SmlXoKEhj6AbZpWYfbObOZn8fWbJuACnwrdnP8s5KYoEZH
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193313>

On Sat, Mar 17, 2012 at 9:36 AM, Sebastien Douche <sdouche@gmail.com> w=
rote:
> On Thu, Mar 8, 2012 at 11:01, Jeremy Morton <jeremy@configit.com> wro=
te:
>> Hi everyone,
>
> Hi Jeremy (sorry to be late, back from holiday)
>
>> I've noticed that the default behaviour of 'git push' is to push to
>> *all* branches that have a remote branch set up.=A0 In order to push
>> just to one branch, you must specify 'git push repo branchname'.
>>
>> This seems rather unintuative to me
>
> I made many Git presentation and managed a lot of training[1] and the
> first thing I explain on the configuration is :
>
> 1. set your name and email
> 2. change the default push option[2]

So, that would seem to be a rather strong indication that the default
push option is a bad one.  :-)

Best regards,
Jeremy Morton (Jez)
