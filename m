From: Jacob Helwig <jacob.helwig@gmail.com>
Subject: Re: Fork of abandoned SVN mirror - how to keep up to date with the 
	SVN
Date: Sat, 28 Mar 2009 15:04:36 -0700
Message-ID: <8c9a060903281504qd1b66hefb70e60c3f624d2@mail.gmail.com>
References: <22756729.post@talk.nabble.com> <8c9a060903280922r6514de83mea4dea84c4116225@mail.gmail.com> 
	<1238258794470-2549665.post@n2.nabble.com> <8c9a060903281102r3eae26edta34899485feb884b@mail.gmail.com> 
	<1238263580197-2549943.post@n2.nabble.com> <8c9a060903281327j33056807j78a2cd03b8151979@mail.gmail.com> 
	<1238276809892-2550565.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: jamespetts <jamespetts@yahoo.com>
X-From: git-owner@vger.kernel.org Sat Mar 28 23:06:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lngfd-00013A-71
	for gcvg-git-2@gmane.org; Sat, 28 Mar 2009 23:06:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761645AbZC1WE4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 28 Mar 2009 18:04:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761576AbZC1WEy
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Mar 2009 18:04:54 -0400
Received: from rv-out-0506.google.com ([209.85.198.226]:6879 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761589AbZC1WEx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 28 Mar 2009 18:04:53 -0400
Received: by rv-out-0506.google.com with SMTP id f9so1835306rvb.1
        for <git@vger.kernel.org>; Sat, 28 Mar 2009 15:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :received:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=1c6ulcgwUshssgtTNMCESrv50u7FU1rcSYiDwR6pMaE=;
        b=g9Y2GyD3WsOLyhckf7LxVI688cA2QsIuq+U8BEgEkFQ/FrKHYb45uAqWW1QjSWwSFy
         wNn5sbCpOATsly5Ci9XOeMFzd59vOIpzEqkg1qqtGoarSPUiuoXEMwdjIwWrQpkGlXmI
         w6MLNE/KStWuqDxpB6vFPXuEyL8kI78jsQVIQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=XT0T7gBb216Cl9BzPsDi+KeCJIva/KufOdSPMWUjD9pX4BAvPJ+LrFMxNOL6g8F/qI
         noxx6AwCRE3Z4H5ltCi+82z5SaOepCkVAa3vLv1h420kQoxQU+2UEBxRp//JeZBMHvSh
         rPwvp0wjhbUa1ftRTTk2t4JklQgGdJQ/xd+gQ=
In-Reply-To: <1238276809892-2550565.post@n2.nabble.com>
Received: by 10.143.163.12 with SMTP id q12mr1474412wfo.224.1238277891185; 
	Sat, 28 Mar 2009 15:04:51 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114982>

On Sat, Mar 28, 2009 at 14:46, jamespetts <jamespetts@yahoo.com> wrote:
>
> Thank you for your reply. Unfortunately, I cannot for the life of me =
get git-svn to work. It refuses to recognise "git svn" as a valid comma=
nd, and "svn" does not appear in the list of commands when I type, "svn=
 --help" in Git Bash (I am using Git in Windows, if that makes any diff=
erence). I tried to look for svn2git, but the homepage linked from the =
link that you gave me produced a 404.
>
> Also, once I have managed to create a Git clone of the SVN repository=
 myself, how do I synchronise that properly with the branch of the othe=
r mirror of the SVN repository that I have been using as the trunk so f=
ar, such that I can continue to download updates and have [i]just[/i] t=
he changes since the previous versions applied?
>
>
> On Sat, Mar 28, 2009 at 11:06, jamespetts <jamespetts@yahoo.com> wrot=
e:
>>
>> Thank you very much for your reply :-) Ahh, I didn't realise that th=
at sort of SVN URL should be avoided. Is there any way around that when=
 the project itself uses that sort of URL? And I think that it does req=
uire a username and empty password. I haven't tried the Github IRC chan=
nel - I must confess - I did not know that there was one.
>>
>> Any suggestions about how to deal with the other problem?
>>
>
> It looks like GitHub won't keep the project in sync for you, so you'r=
e
> probably best off doing the git-svn clone yourself, and maintaining i=
t
> that way.
>
> http://github.com/guides/import-from-subversion
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
>
>
>
> --
> View this message in context: http://n2.nabble.com/Fork-of-abandoned-=
SVN-mirror---how-to-keep-up-to-date-with-the-SVN-tp2548952p2550565.html
> Sent from the git mailing list archive at Nabble.com.
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
>

You should be able to use the exact command I showed earlier within
"git bash".  Also, you'd want to type "git help svn", not "svn --help"
to see the manual.
