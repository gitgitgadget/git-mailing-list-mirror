From: Pat Notz <patnotz@gmail.com>
Subject: Re: Gnome chose Git
Date: Thu, 19 Mar 2009 08:01:32 -0600
Message-ID: <1cd1989b0903190701uac4602dl1d2c3cace45a9938@mail.gmail.com>
References: <877i2lbvt7.fsf@iki.fi> <49C249B9.7010001@drmicha.warpmail.net>
	 <1cd1989b0903190643p19a40718yc4fd2730aab0a9a0@mail.gmail.com>
	 <49C24D9B.1060301@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Michael J Gruber <git@drmicha.warpmail.net>,
	Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Mar 19 15:03:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkIpu-0002qC-Vc
	for gcvg-git-2@gmane.org; Thu, 19 Mar 2009 15:03:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756892AbZCSOBh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 19 Mar 2009 10:01:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756845AbZCSOBg
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Mar 2009 10:01:36 -0400
Received: from yw-out-2324.google.com ([74.125.46.28]:37007 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756257AbZCSOBf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Mar 2009 10:01:35 -0400
Received: by yw-out-2324.google.com with SMTP id 5so523150ywb.1
        for <git@vger.kernel.org>; Thu, 19 Mar 2009 07:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=U4nmrAKRwtDw7j8fkgEaTpBqedQTImLxW9IQUt6i0wA=;
        b=sNnTFuA4OIl9HuSRQW+T7+s5f+zHSvvCyU4rOWox1dw/s8UJ47QMI/pu+jWa0nopAE
         ciRwR+YniaCbkVaZQ5i605VPzjtu9YzaRLg7pd8jehpcvMVrtuGBk10WD+9tJOFTUhLA
         ZvoXrGCoFCVWbShhEzaj7eFj3UGZlsWjSICp4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=ojQV8wFeyISL86Sqf9qspcW7iYlXgRB3eKJV9A1bY5TE6bk4cE/8wLr3VYIARcRqik
         Oymii3Q1RvY8E2hhAqTPw35VH/7UJYITjftygO7h1dgsTHwFTkT9D0AcsLOxlJy0iAuB
         /t61boyKhSRLOY7uzrrv/O+nmxZOlBsudVeiA=
Received: by 10.100.132.4 with SMTP id f4mr1615563and.109.1237471292828; Thu, 
	19 Mar 2009 07:01:32 -0700 (PDT)
In-Reply-To: <49C24D9B.1060301@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113771>

On Thu, Mar 19, 2009 at 7:50 AM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> Pat Notz venit, vidit, dixit 19.03.2009 14:43:
>> On Thu, Mar 19, 2009 at 7:33 AM, Michael J Gruber
>> <git@drmicha.warpmail.net> wrote:
>>> Teemu Likonen venit, vidit, dixit 19.03.2009 12:23:
>>>> FYI: The Gnome release team just announced that Gnome will migrate=
 from
>>>> Subversion to Git:
>>>>
>>>> =A0 =A0 http://thread.gmane.org/gmane.comp.gnome.infrastructure/11=
34
>>>
>>> Good choice :)
>>>
>>> Interestingly, they seem to go the svn-all-fast-export route.
>>>
>>> Also, they need push tracking for pushing through ssh, which is a c=
ommon
>>> requirement for many large projects. Do we have something to suppor=
t
>>> that? git-notes comes to my mind.
>>>
>>> Their current approach is writing to a single log file (receive-hoo=
k).
>>> That may support a linear push history best, but looking up who pus=
hed
>>> what, given "what"?
>>>
>>
>> That's also something we do. =A0Since the post-receive hook gives yo=
u
>> the refname and the old and new refs you should have everything you
>> need. =A0We basically record the user name, UTC timestamp and the re=
f
>> info. =A0With a little bit more scripting you should be able to figu=
re
>> everything else out (though post-receive isn't called for local
>> commits).
>>
>
> I know the info is there. It might just make more sense to have it in
> the git repo the way notes are/will be: It's public, it's connected t=
o
> the commits, it's tamper proof (anyone would notice rewrites).
>

Ahh, yes.  We'd like that too.

> Michael
>
> P.S.: Was this intentionally off-list? Just in case I respected it.
>

Oops, sorry about that.  Fixed.
