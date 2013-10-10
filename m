From: Amit Bakshi <ambakshi@gmail.com>
Subject: Re: git-archive and submodules
Date: Thu, 10 Oct 2013 12:22:50 -0700
Message-ID: <CAFGOX=WL8GEpZc1b0Rcqt_tMyOzL-nB20Jj=7PArOh82T34JoA@mail.gmail.com>
References: <CALKBF2gwVr0rPn0y8=cvwqOsUb7eQPH7EdK5U+gfZMzh=RpiKw@mail.gmail.com>
	<4F911A2C.4070306@web.de>
	<CALKBF2jzL5-mHaVi1erA=EiF_DALF1Rvwv7yB5CfdEdQa2ZhBg@mail.gmail.com>
	<49D85565-3932-4B03-9568-E5CB75F39B9E@deepdarc.com>
	<loom.20131010T160446-236@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Damien Regad <dregad@mantisbt.org>
X-From: git-owner@vger.kernel.org Thu Oct 10 21:22:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VULp1-0000Tl-F0
	for gcvg-git-2@plane.gmane.org; Thu, 10 Oct 2013 21:22:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756246Ab3JJTWv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 10 Oct 2013 15:22:51 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:48595 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753313Ab3JJTWv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Oct 2013 15:22:51 -0400
Received: by mail-pa0-f42.google.com with SMTP id lj1so3230985pab.29
        for <git@vger.kernel.org>; Thu, 10 Oct 2013 12:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=Q8PHC4qe10VBs1uw0iwSbTjm49i+g3rZAHxMN0kEr8Y=;
        b=eb162YkSul7omUdAjh4h9Nb1n3jl9S52VoKfuHbW0r7oebRYoTMNutFXXoHhvcYWJY
         6E6WvqesdXmnFonYaxBMFRO15f1Rcue/VDTMo7yEgHAwIMoNk1aDr7uHTUS+xhuqALnD
         3ugWimAULdPbTr9TVOYsojm2kmzoe9aO9yMUSZLJt4mg338SqKiJWbXpsdqhXbhTS42j
         4gxfGtRCa0yYhm1BCidjIqB4c1SNJ69sCEnJMrYXdIb/eYMkMzRWK8ESgJcBEW2gmysD
         AtfwNxu94EyYTmrY3oabjQsCRpYfL7sEPBYvU5/HeA7PSZfZP1eNONZqyEUIYvZT1oZX
         GlXg==
X-Received: by 10.68.26.202 with SMTP id n10mr15606494pbg.97.1381432970767;
 Thu, 10 Oct 2013 12:22:50 -0700 (PDT)
Received: by 10.70.35.140 with HTTP; Thu, 10 Oct 2013 12:22:50 -0700 (PDT)
In-Reply-To: <loom.20131010T160446-236@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235876>

I wrote a simple bash script that does git-archive recursively with
submodules. It first does a full mirror clone of the repo and
submodules, so that subsequent calls are faster.

https://github.com/ambakshi/git-archiver


Amit


On Thu, Oct 10, 2013 at 7:09 AM, Damien Regad <dregad@mantisbt.org> wro=
te:
> Robert Quattlebaum <darco <at> deepdarc.com> writes:
>> I got too busy to continue working to get it included. Please feel f=
ree to
> pick up where I left off.
>>
>> On Apr 20, 2012, at 2:32 PM, Andr=E9 Caron <andre.l.caron <at> gmail=
=2Ecom> wrote:
>> > Since you've touched this only last year, I'd like to know where y=
ou
>> > were at and I can see if I can pick up where you left off (unless =
you
>> > want to finish yourself).
>
> Greetings
>
> I was just wondering whether there been any progress on this topic si=
nce
> last year... Andr=E9 ?
>
> Cheers
> Damien
>
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
