From: Daniel Grace <negativeview@gmail.com>
Subject: Re: Lost a week?
Date: Thu, 15 Apr 2010 09:29:26 -0500
Message-ID: <v2r62a3a9cb1004150729v1e0a60bq381bc382f76f3c27@mail.gmail.com>
References: <t2s62a3a9cb1004150657g5baabb42o512e0e103d1e9596@mail.gmail.com>
	 <vpqtyrc6bse.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Apr 15 16:35:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O2QAZ-0002f0-0P
	for gcvg-git-2@lo.gmane.org; Thu, 15 Apr 2010 16:35:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752468Ab0DOOfp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 15 Apr 2010 10:35:45 -0400
Received: from mail-qy0-f196.google.com ([209.85.221.196]:57839 "EHLO
	mail-qy0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751749Ab0DOOfo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 15 Apr 2010 10:35:44 -0400
X-Greylist: delayed 375 seconds by postgrey-1.27 at vger.kernel.org; Thu, 15 Apr 2010 10:35:44 EDT
Received: by qyk34 with SMTP id 34so1900062qyk.22
        for <git@vger.kernel.org>; Thu, 15 Apr 2010 07:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:received:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=A9Rhp1Uxb+l85ght4SB/lE8Bv+K7xA/4ndVRUbgJVQk=;
        b=gXVPyaOixp1ndP0+ixw3P5IR5mxZ0WcZxfPJzBKF2sN4YQaUHE+OX4F9eoL449SpI9
         Y4g7Fqu8ouQUQeOASrYmgIJJgOnlBOft3VrQdK+LZVYzOlKmgk+kUpLPymjHfp5PkaAQ
         aj5hBV2V8iU2QASEGqxH6FkyW9y2Er9aGjcg8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=wY+FbsSyvkz9JcssIfBNnn7PLu3yGY1oS8Jjvcif26YV67S6k98UjX0qPrk091jMTp
         swF+ziQyuwJLJZcyOyyVQxP2jLZCoZOOq1Seos9xzdObkW/eDevfgSLwGotEkZh65RtZ
         8TXGcPta6j/gGCMR9p5xBx+0WPCSzWxgUaXdI=
Received: by 10.229.86.140 with HTTP; Thu, 15 Apr 2010 07:29:26 -0700 (PDT)
In-Reply-To: <vpqtyrc6bse.fsf@bauges.imag.fr>
Received: by 10.229.181.16 with SMTP id bw16mr87063qcb.0.1271341766893; Thu, 
	15 Apr 2010 07:29:26 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144991>

Thanks everyone! I had heard the phrase "detached head" before, but
didn't really understand what it is. I'm glad to note that all my
commits were there. I wasn't really worried, I knew that git had
stored it dutifully away SOMEWHERE.

I have that page bookmarked now Thomas. Unfortunately I have customer
work to do now that I am not missing work, but I promise to read and
understand it fully as soon as I'm done with that.

Daniel
http://www.doomstick.com



On Thu, Apr 15, 2010 at 9:16 AM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Daniel Grace <negativeview@gmail.com> writes:
>
>> github shows the same. I KNOW that there were commits (representing =
a
>> good bit of work) in that time. I'm sure that it's *somewhere* but I=
'm
>> at a complete loss as to where it is. gitk shows no side branches (n=
or
>> does git branch). I don't use branches really, as much as I know tha=
t
>> I should.
>
> I guess you've been on a detached HEAD for some time. Recent version
> of Git warn you this way when you enter in this state:
>
> ,----
> | Note: checking out 'HEAD^'.
> |
> | You are in 'detached HEAD' state. You can look around, make experim=
ental
> | changes and commit them, and you can discard any commits you make i=
n this
> | state without impacting any branches by performing another checkout=
=2E
> |
> | If you want to create a new branch to retain commits you create, yo=
u may
> | do so (now or later) by using -b with the checkout command again. E=
xample:
> |
> | =A0 git checkout -b new_branch_name
> |
> | HEAD is now at a8e7ba9... foo
> `----
>
> Now, your changes are probably not lost forever: they're not reachabl=
e
> from a branch, but still there (but don't play with "git gc" until
> you're sure you've recovered all of it...). "git reflog" should give
> you the sha1 of the commit you're looking for (if you didn't really
> mess up everything, you really look for just one commit, which is the
> tip of the sequence of commits you did while on a detached HEAD, that
> is, the one just before you did "git checkout master".
>
> Then, do
>
> git branch tmp <the-sha1-you-found>
> (possibly run "gitk --all" to understand, here)
> git merge tmp
>
> to create a branch named tmp containing your commits, and merge it
> into your current branch. Naming the branch isn't strictly necessary,
> but will help in case you do anything wrong trying to merge.
>
> --
> Matthieu Moy
> http://www-verimag.imag.fr/~moy/
>
