From: Phil Hord <phil.hord@gmail.com>
Subject: Re: Proposal: create meaningful aliases for git reset's hard/soft/mixed
Date: Fri, 2 Dec 2011 10:28:08 -0500
Message-ID: <CABURp0qcHaoi58EQ1FLGo2atPuWfS5x4p_SK7ZA_AqV7as212w@mail.gmail.com>
References: <CAGK7Mr4GZq5eXn4OB+B0ZborX-OVoXiWU8Lo1XM5LRZDuRe1YA@mail.gmail.com>
 <CAGK7Mr5nQoubAw11KDj4WKwQnXrfgteKbMj2=AR-HhsGKi52wQ@mail.gmail.com>
 <CABURp0rtCUbJXLHtXv_1g6GRKL3mX-T+3vN1=QO4CUibqXdEMg@mail.gmail.com> <201112020826.14114.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Philippe Vaucher <philippe.vaucher@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Christian Couder <chriscool@tuxfamily.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Fri Dec 02 16:28:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RWV2R-0005Y9-Vx
	for gcvg-git-2@lo.gmane.org; Fri, 02 Dec 2011 16:28:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756779Ab1LBP2b convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 2 Dec 2011 10:28:31 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:46559 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754065Ab1LBP2a convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 2 Dec 2011 10:28:30 -0500
Received: by wgbdr13 with SMTP id dr13so1391647wgb.1
        for <git@vger.kernel.org>; Fri, 02 Dec 2011 07:28:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=XZHnB7Nq33blmM3SkctZE1JdJJmNPw6OF0FDPPBMGZY=;
        b=OwGb1L9cygZ2u9ThSeRkSLzefxT9jzILGI+L/YJURbBs3vnanm0siraOERo9+2mVtm
         RZDaSehzA919Amy1Mz3VrbRPjhEDTSwr0mJdkVrBlrWEyQUPgfoPaEz5Dr9Ap4LA2jO0
         utCdFHN9QQIlETyRwHXB7+8nMpmjgW3YS3RzA=
Received: by 10.227.203.131 with SMTP id fi3mr8119824wbb.17.1322839709482;
 Fri, 02 Dec 2011 07:28:29 -0800 (PST)
Received: by 10.216.61.142 with HTTP; Fri, 2 Dec 2011 07:28:08 -0800 (PST)
In-Reply-To: <201112020826.14114.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186222>

On Fri, Dec 2, 2011 at 2:26 AM, Thomas Rast <trast@student.ethz.ch> wro=
te:
> Phil Hord wrote:
>>
>> Think outside the "reset" command. =A0Like this:
>>
>> From the "most popular" comment on http://progit.org/2011/07/11/rese=
t.html:
>> > I remember them as:
>> > --soft =A0 =A0 =A0-> git uncommit
>> > --mixed =A0-> git unadd
>> > --hard =A0 =A0 -> git undo
>>
>> I don't particular like these names, but conceptually they are helpf=
ul.
>
> I think all of these, but the last one in particular, are *very*
> dangerous oversimplifications. =A0Doubly so if you then use "undo" wi=
th
> a revision argument.

I agree.  That's why I also said this:

> How about:
>  --soft: git checkout -B <commit>
>  --mixed: git reset -- <paths>
>  --hard:  git checkout --clean

But maybe I wasn't clear enough.  I'm not suggesting git-alias for
these.  I am proposing new commands to replace common usages of
git-reset.  These commands would need basic safeguards against
foot-shooting, of course.

Phil
