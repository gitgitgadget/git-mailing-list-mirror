From: Eugene Sajine <euguess@gmail.com>
Subject: Re: git rebase command and docs questions
Date: Fri, 9 Apr 2010 16:51:06 -0400
Message-ID: <p2m76c5b8581004091351o8ed7877ch1361f0089d3bdf79@mail.gmail.com>
References: <h2j76c5b8581004091149y9f5f93a8o5f11b3ffc657623@mail.gmail.com>
	 <r2mfabb9a1e1004091337w8ec2b721y3a5082d5e0f5925c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Eugene Sajine <euguess@gmail.com>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 09 22:51:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0LAb-0006TX-9t
	for gcvg-git-2@lo.gmane.org; Fri, 09 Apr 2010 22:51:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756889Ab0DIUvK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 9 Apr 2010 16:51:10 -0400
Received: from mail-fx0-f223.google.com ([209.85.220.223]:43227 "EHLO
	mail-fx0-f223.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752757Ab0DIUvI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Apr 2010 16:51:08 -0400
Received: by fxm23 with SMTP id 23so3093618fxm.21
        for <git@vger.kernel.org>; Fri, 09 Apr 2010 13:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:received:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=G9n8djDthjIPR1rbh/jOqGj152RvmW0iF4KQdCt4LLo=;
        b=bhqc3psQiKsk1CeYkWyBeEtzX44m10dHXO8L+N7aWSlIbA8j3y8FVueStYtpEB4lhk
         lnhusi8CKC7CGh4Dqbz0FKmJdgMraSrMxLSrzXr2xsp3b+hJ6upZe1HZwfJUOMWrSRwm
         s86HMlKi15zerF82ncdpA+1L29ZCu/s3dtv8M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=VTyRIikWfBh/J/HaJXobXexloL+XxaFz+jc9f+IJxREPXK6kJFYPdmDySXBLxFOunl
         ShlofrRdPOV4ij9c1hnVZuP9M1QEtuO6AF6ZQLWRCSsnb7TQPj5zbCJq0SBfKBEXatZD
         7AmdLCI287XtduXVre9z2Cn4CPG+xMuC1P2QM=
Received: by 10.223.114.82 with HTTP; Fri, 9 Apr 2010 13:51:06 -0700 (PDT)
In-Reply-To: <r2mfabb9a1e1004091337w8ec2b721y3a5082d5e0f5925c@mail.gmail.com>
Received: by 10.223.21.17 with SMTP id h17mr574256fab.45.1270846266409; Fri, 
	09 Apr 2010 13:51:06 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144470>

On Fri, Apr 9, 2010 at 4:37 PM, Sverre Rabbelier <srabbelier@gmail.com>=
 wrote:
> Heya,
>
> On Fri, Apr 9, 2010 at 20:49, Eugene Sajine <euguess@gmail.com> wrote=
:
>> But, in =E2=80=9Cgit rebase =E2=80=93onto master next topic=E2=80=9D=
 the meaning of the =E2=80=9Cnext
>> topic=E2=80=9D parameters is different: as I understand, it actually=
 specifies
>> a range of commits from next to topic, =C2=A0because =E2=80=93onto c=
hanges the way
>> the whole command is working, but it is not clarified in help. Is th=
at
>> correct understanding?
>
> I've never been able to remember how rebase --onto works, perhaps if
> we actually let users specify a range it would be more intuitive?
>
> $ git rebase next..topic master

I thought about it too. Even with the old syntax:

git rebase --onto master next..topic

at least as a second option the whole command would be much more
understandable for users. Currently, it fails with such range.

Thanks,
Eugene
