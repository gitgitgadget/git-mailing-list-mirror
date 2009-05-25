From: Jeff Brown <jeff@jeffandbetsy.net>
Subject: Re: tracking committer vs. author
Date: Mon, 25 May 2009 18:40:02 -0500
Message-ID: <bbd12f0f0905251640p16727ea9pedbbc99796def340@mail.gmail.com>
References: <bbd12f0f0905251420l1ab63ca5y32589a4451064b9a@mail.gmail.com>
	 <alpine.LNX.2.00.0905260015430.32620@reaper.quantumfyre.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 26 01:40:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M8jm8-0006cV-VI
	for gcvg-git-2@gmane.org; Tue, 26 May 2009 01:40:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753532AbZEYXkE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 25 May 2009 19:40:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752920AbZEYXkD
	(ORCPT <rfc822;git-outgoing>); Mon, 25 May 2009 19:40:03 -0400
Received: from mail-bw0-f222.google.com ([209.85.218.222]:55547 "EHLO
	mail-bw0-f222.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752892AbZEYXkC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 May 2009 19:40:02 -0400
Received: by bwz22 with SMTP id 22so3422819bwz.37
        for <git@vger.kernel.org>; Mon, 25 May 2009 16:40:02 -0700 (PDT)
Received: by 10.204.114.136 with SMTP id e8mr7539360bkq.190.1243294802624; 
	Mon, 25 May 2009 16:40:02 -0700 (PDT)
In-Reply-To: <alpine.LNX.2.00.0905260015430.32620@reaper.quantumfyre.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119983>

On Mon, May 25, 2009 at 6:28 PM, Julian Phillips
<julian@quantumfyre.co.uk> wrote:
> On Mon, 25 May 2009, Jeff Brown wrote:
>
>> I have noticed that when we pull changes from non-committers into ou=
r
>> repo, sometimes meta information about who committed the change to t=
he
>> repo is included along side info about who actually wrote the change=
s.
>> For example, see
>>
>> http://github.com/grails/grails/commit/8ac450c37d16b0468ba0f92d30089=
68fd6a41a75
>> and note that graemerocher has commit privileges to the repo but
>> ihotary does not. =A0ihatory's commit was pulled in by graemerocher.
>>
>> The commit at
>> http://github.com/grails/grails/commit/ff770359d152683d5794887cd743a=
10ce7d04501
>> was also authored by a non committer. =A0I pulled that change in mys=
elf
>> this evening. =A0Notice that there is no info displayed there to
>> indicate that I (jeffbrown) am the person who pushed that change int=
o
>> the repo.
>>
>> I don't know what was done differently for those 2 scenarios but bot=
h
>> of those commits were authored by folks who do not have commit
>> privileges to the repo at
>> http://github.com/grails/grails/commits/master.
>
> You say "pulled" for both commits, but do you mean that in an exact g=
it
> sense (i.e. 'git pull ...' command was used)? =A0I assume not ...
>
> If you pull from someone, then you get their commits, so they are the
> committer - on the other hand if you apply patches they have sent, th=
en you
> become committer (though they remain the author of course) as you cre=
ate new
> commits (containing basically the same changes and message).
>
> If you compare the git repository
> (http://git.kernel.org/?p=3Dgit/git.git;a=3Dsummary) where all change=
s are made
> by Junio applying patches, to the Linux kernel
> (http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=
=3Dsummary)
> where Linus pulls from many (trusted) people you can see that while t=
he
> commits in git are all committed by Junio, the kernel commits are mad=
e by a
> wide variety of people.
>
>> I don't think this is a github issue. =A0If I am wrong, please let m=
e know.
>>
>> If I want to track not only who authored the commit but also who
>> pushed it into the repo (like you see at
>>
>> http://github.com/grails/grails/commit/8ac450c37d16b0468ba0f92d30089=
68fd6a41a75),
>> what is the procedure for making that happen?
>
> This easiest way is to not pull from people who "don't have commit ri=
ghts"
> but to apply a patch series instead, as by pulling you are basically
> trusting them - possibly more that you intend/want?
>
> HTH,
> --
> Julian
>

I understand all of that but now I am not sure what the best procedure
is.  This is what I have been doing.

- create an integration branch
- pull changes from someones repo into my integration branch
- do whatever testing/reviewing/etc. necessary and if I want their
changes, continue...
- merge integration branch (which contains their changes) into my
master branch (test etc...)
- push my master to my origin

I expect there is a simple way to do what I want without having to
create patch files, but I don't know what that is.

Thanks for any suggestions.



jb
--=20
Jeff Brown
SpringSource
http://www.springsource.com/

Autism Strikes 1 in 166
=46ind The Cause ~ Find The Cure
http://www.autismspeaks.org/
