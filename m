From: Michael Horowitz <michael.horowitz@ieee.org>
Subject: Re: git-p4 issue
Date: Fri, 6 May 2011 16:16:04 -0400
Message-ID: <BANLkTik49sCiBnf6ZofrtW+45uR6ZC+C9Q@mail.gmail.com>
References: <BANLkTikeQSqAhm2CwCYBkE74OxPUnA0cOg@mail.gmail.com>
	<BANLkTimmVQAcx7hiQFUBcoAGdvPhktPuMg@mail.gmail.com>
	<BANLkTikDDDtyJB992DFNtvgMrGvbWf=rMw@mail.gmail.com>
	<BANLkTinJecAsXt+5JzscFYEx_ez2q9DioQ@mail.gmail.com>
	<20110420003100.GC28768@arf.padd.com>
	<BANLkTikYDR+bzJQGip9BFo-BSgsBqEcQjQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 06 22:16:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QIRRd-0005d3-3Y
	for gcvg-git-2@lo.gmane.org; Fri, 06 May 2011 22:16:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755816Ab1EFUQH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 6 May 2011 16:16:07 -0400
Received: from mail-yi0-f46.google.com ([209.85.218.46]:40240 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753185Ab1EFUQG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 May 2011 16:16:06 -0400
Received: by yia27 with SMTP id 27so1317632yia.19
        for <git@vger.kernel.org>; Fri, 06 May 2011 13:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=5GWPuaMH5hN8JHbIkxc4kVoBim59w0YApedFQp/W8O4=;
        b=StbwT0AXwjkYVnLm/INJyZR5V6W5FXNI7/GF6rDJ8wBp3zSzh0b/uvUbjFA2WYBbMt
         8hC1UWchgc4841DM3jJ0R/bu8EGUMJlbE+xjtXHg4a4rQ7NxiYguobslNiZ3epR1ivQl
         P+3bojmxXrBajE4kJHcWRYzTCzexCDZKq3ssI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=vK8W31jKqTMIs5PuTd22BaUpRyc5xkmuC/BGsjGd5AIBwy59EhNdy1csyELl6thH+T
         a+1S7/N9iywUaP7RFfmE+By0isHkbcg8cE+tZKoNgZdHtByaw+MDm2CGAsePXxevIL5G
         qjGUkWuI5byiDchDLBPCkpxNeT2CbRuilQNYQ=
Received: by 10.236.185.4 with SMTP id t4mr5220445yhm.158.1304712964798; Fri,
 06 May 2011 13:16:04 -0700 (PDT)
Received: by 10.236.105.233 with HTTP; Fri, 6 May 2011 13:16:04 -0700 (PDT)
In-Reply-To: <BANLkTikYDR+bzJQGip9BFo-BSgsBqEcQjQ@mail.gmail.com>
X-Google-Sender-Auth: KqFE1aWEwCAttKJwVT7SEQaGXOY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173005>

Vitor,

> Could you please search for the following set of patches in this mail=
ing list?
>
> [PATCH v2 0/3] git-p4: Improve branch support
>
> I think I sent v2 twice somehow, so please make sure you pick the lat=
est ;)
> In these patches I add the possibility to use a "git-p4.branchList"
> configuration to define the branches. The patch is still to be approv=
ed because
> most people in the mailing list do not use branch detection, but I us=
e it daily
> and it is working in my side. Could you please test it?

Can you send this patch again?  It looks like you had previously
responded to the list only, so I never got this message, as I wasn't
on the list at the time (I am now).  I only saw this because I was
searching the archive for something else.  I searched for the patch,
but the actual patch body doesn't seem to be in the archive.

Thanks,

Mike




On Tue, Apr 19, 2011 at 10:40 PM, Michael Horowitz
<michael.horowitz@ieee.org> wrote:
> I don't have a problem with the branch detection if other people use
> it in ways I don't, but it would be nice to have more options and
> documentation around it.
>
> The best I can do to describe what I want is for it to use what is
> returned by "git-p4 branches", at minimum.=A0 If there is some option=
al
> additional "new branch detection" logic, I don't have a problem with
> that, but that should only be in addition to the branches it already
> knows about from "git-p4 branches".=A0 So, when I do a "git-p4 sync" =
or
> "git-p4 rebase", and it is importing changes from/to multiple
> branches, then it should get that list of branches using the same
> method "git-p4 branches" uses.=A0 Does that make sense?
>
> Thanks,
>
> Mike
>
>
>
> On Tue, Apr 19, 2011 at 8:31 PM, Pete Wyckoff <pw@padd.com> wrote:
>>
>> michael.horowitz@ieee.org wrote on Mon, 18 Apr 2011 23:57 -0400:
>> > OK, after some digging, I think I have figured out what is going o=
n,
>> > but I am not sure how to fix it, at least not safely.
>> >
>> > There seem to be several different ways of detecting branches, and=
 I
>> > am not exactly sure what they are all used for, or why there are s=
o
>> > many, but the core of the issue I am having is that in importChang=
es
>> > when it calls splitFilesIntoBranches, it assumes "self.knownBranch=
es"
>> > has all the branches, even though it already has the branches from
>> > "self.p4BranchesInGit". =A0The exact reason I don't know, but the
>> > results is splitFilesIntoBranches returns an empty array, and so w=
hen
>> > the code loops over it, it silently does nothing.
>>
>> I too am confused by the branch handling in git-p4, and have never
>> used it. =A0I'd love to rip it all out, along with the confusion,
>> but know that some people use it with success.
>>
>> At least it all could use some overhaul and documentation so we
>> can see what's going on.
>>
>> > The first fix that would be helpful is to at least report an error=
 if
>> > it can't find the branches, rather than silently doing nothing. =A0=
I am
>> > not exactly sure why it needs to look in "self.knownBranches", so =
I
>> > don't know what the error should report, maybe the error should be
>> > reported earlier?
>> >
>> > The other issue is how "self.knownBranches" seems to be populated.=
 =A0It
>> > looks like form my code path, which decides to "Import from/to
>> > multiple branches", it tries to detect branches by using "p4
>> > branches". =A0Again, this is odd, since I can see it already has t=
he
>> > names of the branches from "self.p4BranchesInGit". =A0I am not fam=
iliar
>> > enough with the code (and figuring out Python as I go along) to kn=
ow
>> > why. =A0The problem with using "p4 branches" is those aren't reall=
y
>> > branches, they are aliases to a merge command (integrate in p4 lin=
go)
>> > which stores the from and to branch. =A0The branch in Perforce is =
really
>> > just a directory. =A0Interestingly enough, it seems this logic als=
o
>> > attempts to detect new branches and automatically import them, but
>> > ironically this doesn't actually work for me.
>>
>> This is my understanding of "p4 branch" as well. =A0At our site,
>> the list of p4 branches does not at all correspond to what we
>> think of as code development branches in git. =A0Again, maybe
>> others use it differently?
>>
>> We do maintain p4 view lists, but that is kept out-of-band, not
>> in any p4 mechanism. =A0These map friendlier short names to a list
>> of directories in p4 and how to assemble those into a workspace.
>>
>> > So, the crux of the problem is that "p4 branches" are not necessar=
y to
>> > have at all. =A0The reason this suddenly stopped working for me is=
 that
>> > someone had created one of these branch definitions and I didn't k=
now,
>> > so it was accidentally working all this time, but only for 2 of th=
e
>> > branches. =A0Then the person removed the definition, and it stoppe=
d
>> > working. =A0Now the workaround is to go and create these things fo=
r
>> > every branch, but considering these are unnecessary and cumbersome=
 to
>> > create, and the code seems to be able to find the branches already
>> > from the "self.p4BranchesInGit" anyway, I would like to remove the
>> > dependency on that logic.
>> >
>> > Now, I could go ahead and hack something that does things differen=
tly,
>> > but since I don't really know the intention of these structures or=
 how
>> > it might impact elsewhere in the code, I could use some guidance f=
rom
>> > someone who knows this code well.
>>
>> Vitor uses branches, and his patch that he recommends might be
>> the work-around you are looking for.
>>
>> I thought all this branch code was opt-in, so if you fail to say
>> "--detect-branches", it won't try to auto-detect anything.
>>
>> But there is maybe another use case in here, which is to
>> import multiple directories of the depot into _different_
>> refs/remotes/p4/<branch>. =A0(I've only ever done one at a
>> time, and into the default p4/master.) =A0And now that you
>> have multiple git-p4 branches, you're stuck with them due to the
>> login in p4BranchesInGit(). =A0That feature should be handled
>> independently of the "p4 branch" auto-detection one.
>>
>> The branch handling needs rework. =A0You might help by describing
>> how you want it to work and we can see if this is the same as how
>> Vitor uses branches.
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0-- Pete
>
