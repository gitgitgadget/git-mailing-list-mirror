From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: weird diff output?
Date: Wed, 30 Mar 2016 12:14:26 -0700
Message-ID: <CA+P7+xp+oT2zMBZqR8zvXKm8Zp5btaNyoOWFTts29HMwX+2o=Q@mail.gmail.com>
References: <CA+P7+xoiFUiBwDU2Wo9nVukchBvJSknON2XN572b6rSHnOSWaQ@mail.gmail.com>
 <CAGZ79ka4ad5dQMWANJUDx-0+kV3qR=HttOJni2XfhFzjMKfcPw@mail.gmail.com>
 <xmqqzithxj8l.fsf@gitster.mtv.corp.google.com> <CAGZ79kZiiOgxh6vMDnaJ_b+VVGrFBfGzZukTN6OEBxUV9-2vQw@mail.gmail.com>
 <CA+P7+xoLZhKzHf6khQfT_pZ2=CQAp8Nmhc9B8+10+9=YYUZH3w@mail.gmail.com>
 <20160330045554.GA11007@sigill.intra.peff.net> <CA+P7+xqskf6Ti3tVwMrOAaj3EDykRLKiXG5EbbzkjRsZP0s_7w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git mailing list <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 30 21:14:55 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1alLZs-0006EW-FH
	for gcvg-git-2@plane.gmane.org; Wed, 30 Mar 2016 21:14:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753736AbcC3TOs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Mar 2016 15:14:48 -0400
Received: from mail-io0-f169.google.com ([209.85.223.169]:36558 "EHLO
	mail-io0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753184AbcC3TOr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Mar 2016 15:14:47 -0400
Received: by mail-io0-f169.google.com with SMTP id q128so84951432iof.3
        for <git@vger.kernel.org>; Wed, 30 Mar 2016 12:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=A3iRSq1aZQXFP/xf/RSkpbJ8VXnaMMmEhaBXOonchuY=;
        b=nespLTBFvTdsDq8fwmo3OoiYPJQI0gSXQUNSi39fymJ/tHt99N+eFW5vinrQx4+zE3
         ntFRkuMGBpQB/T7ZZvBp6qiO3+Gr1sfkN2ilZC1mkoYiMkpJLVedZ5r/Y1TE11L2QeLt
         xI4ACX3i16r1MK15lw2R+cwl5LYCFuri2oeXFcmBl9yW5fRWrjguhaGXtAEz9sNbPK9P
         lqLfbNxh+PWWJ5RwNXwbad3ubiIMNF+bS/L3Ey8GvBhIEqEZfZde7smDDxP6+2BiqSDJ
         TocMdpxmDAqetNjhjnJtLocpYF1EqN/H+vWX6/uUJ/6eDGrefVWb7E2ljbjn/hcS3pME
         YIRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=A3iRSq1aZQXFP/xf/RSkpbJ8VXnaMMmEhaBXOonchuY=;
        b=P4BlAX18NrrMmXvJjsH0ajPaAgznyhRmIuWvgdHzJtorOwmslM8q9Nzum1P3LXGAAL
         Q38VtRgcsyuzvFFNNo1iHkdp+qeELPzVBLtQA9eN9YHhQQ3G7iluaxf32BDmbt79zTKw
         ECP4a8qFjONnvOWVLplwuf3wT5yiNTJiJBYNfHyJoS6Vqe817TWsa5UupqDaJp09xLmV
         KhtQm+/9lke/rOJw7CDgUI0TmVYAFvlH3a5ldfVZdsfbAUfOo2/40x9StC9JoGxGEJNn
         XSZ00Qascizx9ciqs3d1e/9MigdhcvS4FJM6r4PNQq+wKmTIyu3S8/NoOMYeAl/X9B1J
         Wsdg==
X-Gm-Message-State: AD7BkJKUKYVFoxE53O96PnoQPAUCuuu1mxRvJIfBUpMaIueg5leUstYaPcn01z1PCHYMu4QAirsut+Oof2Xn3A==
X-Received: by 10.107.166.72 with SMTP id p69mr13425310ioe.0.1459365286040;
 Wed, 30 Mar 2016 12:14:46 -0700 (PDT)
Received: by 10.107.10.202 with HTTP; Wed, 30 Mar 2016 12:14:26 -0700 (PDT)
In-Reply-To: <CA+P7+xqskf6Ti3tVwMrOAaj3EDykRLKiXG5EbbzkjRsZP0s_7w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290337>

On Tue, Mar 29, 2016 at 11:05 PM, Jacob Keller <jacob.keller@gmail.com> wrote:
> On Tue, Mar 29, 2016 at 9:55 PM, Jeff King <peff@peff.net> wrote:
>> One thing I like to do when playing with new diff ideas is to pipe all
>> of "log -p" for a real project through it and see what differences it
>> produces.
>>
>
> Great idea!
>
>> Below is a perl script that implements Stefan's heuristic. I checked its
>> output on git.git with:
>>
>>   git log --format='commit %H' -p >old
>>   perl /path/to/script <old >new
>>   diff -F ^commit -u old new | less
>>
>> which shows the differences, with the commit id in the hunk header
>> (which makes it easy to "git show $commit | perl /path/to/script" to
>> see the new diff with more context.
>>
>
> I'll try to run this  against my projects and see what it looks like
> to see if I can spot (m)any counter examples, which would indicate
> it's a bad idea. I may have some time in the next few days to see how
> hard it would be to fully integrate it into the diff machinery too.
>
> Thanks for the help!
>
> Regards,
> Jake
>

I ran this on a few of my local projects and it doesn't seem to
produce any false positives so far. Everything looks good. Of course
this is with just traditional C code. I am currently trying to run
this against the history of Linux as well and see if I can find
anything that seems bad there.

Thanks,
Jake
