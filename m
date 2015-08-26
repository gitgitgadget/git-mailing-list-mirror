From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: Git's inconsistent command line options
Date: Tue, 25 Aug 2015 23:33:17 -0700
Message-ID: <CA+P7+xpMnRhNd843_w-RcvH=6eB52AhhNJ+dQWogRBWggyjtvA@mail.gmail.com>
References: <mrh7ck$r0g$1@ger.gmane.org> <CAPc5daUdVQSAhrig046qGopVuxCDagZg3v9bwXOaC3SvC2MRnw@mail.gmail.com>
 <CA+P7+xrYugueYYrrJV0pduAHCg7CLknE_0QYcU8mO6idntz=VA@mail.gmail.com>
 <CAGZ79kZ6KK0qVtzrxmmsBQqmz-dgamC4f6W0zVTQLcuYi==0fw@mail.gmail.com>
 <xmqqa8tfvsr9.fsf@gitster.dls.corp.google.com> <CA+P7+xoQnq-nCP=_Wtfh39fxxwTvEo+m-=o7fcmrdyaBBfbt8A@mail.gmail.com>
 <877foief6z.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Stefan Beller <sbeller@google.com>,
	Graeme Geldenhuys <graemeg@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Wed Aug 26 08:33:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZUUHG-0002pn-9t
	for gcvg-git-2@plane.gmane.org; Wed, 26 Aug 2015 08:33:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753566AbbHZGdi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Aug 2015 02:33:38 -0400
Received: from mail-ig0-f179.google.com ([209.85.213.179]:38519 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751216AbbHZGdh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Aug 2015 02:33:37 -0400
Received: by igfj19 with SMTP id j19so4829557igf.1
        for <git@vger.kernel.org>; Tue, 25 Aug 2015 23:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=DCymxn49Ga97jiZFEB05B+iEmfhY0WeM135LsYWMvHs=;
        b=RAudbKVkyKgoCJDVdzATJE1VzUskIqA4o1SF/tl7SWWGq6t0bLcslmMEUUfdubs0HG
         KAzaadIfEVD5UXxITsvrzSvJtHnaC9eGSiGRViEs9KEOV/igXeyJxcsC5zMkowBsTnTo
         QHCr7NTbkSRHCSjxYLJQGScroAtO9Ald5iGeFZESFDa3LSKFAw0byagwWGZZslk+8Fkd
         JdTV116Pkv0g03FWY1vy6RZnt3u+gUCsuvyPhvImDpXEnWX6G16fHMT5NEYVT9he0Xk8
         nakkXBmZZ0wIvBZqioK8k9CpRMEwt4P0TccFIXoXwPqOpkinkFno8iaHZXUKOb+cuPLW
         BV8w==
X-Received: by 10.50.93.33 with SMTP id cr1mr1435602igb.35.1440570817010; Tue,
 25 Aug 2015 23:33:37 -0700 (PDT)
Received: by 10.107.5.203 with HTTP; Tue, 25 Aug 2015 23:33:17 -0700 (PDT)
In-Reply-To: <877foief6z.fsf@igel.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276599>

On Tue, Aug 25, 2015 at 11:28 PM, Andreas Schwab <schwab@linux-m68k.org> wrote:
> Jacob Keller <jacob.keller@gmail.com> writes:
>
>> "if you really mean to create a tag named create, use
>>
>> git tag -- create master
>
> In all other uses of -- refs must be put on the *left* side.
>
> Andreas.
>

Oops that wouldn't be consistent then. Normally "--" is used to
separate options from non-options arguments, but we usually use it to
separate refs from non-refs.

Guess that sort of ruins this particular strategy.

Regards,
Jake
