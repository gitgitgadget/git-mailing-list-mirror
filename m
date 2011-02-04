From: Tor Arvid Lund <torarvid@gmail.com>
Subject: Re: git to p4 conversion
Date: Fri, 4 Feb 2011 15:01:26 +0100
Message-ID: <AANLkTi=_spLE-KMnou-2LLQjwq4FUZxNr9pk7D9C=4PK@mail.gmail.com>
References: <AANLkTi=0TSD6p7WtsVzx=pq8=GVu+jHUdxt1bnC++CT+@mail.gmail.com>
	<4D4AF29E.7070509@vmware.com>
	<AANLkTikW_sU8oCmU9wN5q1OPPJrQbS2YZAvS0C_nBQbD@mail.gmail.com>
	<loom.20110204T004658-497@post.gmane.org>
	<AANLkTikfGapDfZtD9H10797Ted_Av78WD8M7XrACOCpW@mail.gmail.com>
	<AANLkTimrwUxNOAnfxgvReGN+-h4_0jhZ731y22TB6u1K@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Vitor Antunes <vitor.hda@gmail.com>, git@vger.kernel.org,
	Ian Wienand <ianw@vmware.com>
To: Endre Czirbesz <endre@czirbesz.hu>
X-From: git-owner@vger.kernel.org Fri Feb 04 15:01:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PlMEC-0007TN-U5
	for gcvg-git-2@lo.gmane.org; Fri, 04 Feb 2011 15:01:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753090Ab1BDOB2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 4 Feb 2011 09:01:28 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:33581 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753069Ab1BDOB1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 4 Feb 2011 09:01:27 -0500
Received: by gxk9 with SMTP id 9so927833gxk.19
        for <git@vger.kernel.org>; Fri, 04 Feb 2011 06:01:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=6MugpVAK8x8nTWEzuv35X8Ge7955GCe1WvbBqTkxoUs=;
        b=T421q6Rbtxvo1U4HQcquO4tLhpgHEUOdTENRg16da3z9XWJakSNP6te8ZPETI1SiRl
         lb8VQ0d0cfwij4d/huxJdV2dGiNaGoAMwazZby69PIw+XjN3s9zgiaOn8jDtqXEpztoo
         yt/2Ezd1OWk/w3FbYecj6oUy50bBA6KSMAo4U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Em/XUHYOdLkKtBCpv+sghGoyV9sfHvLt2mXb7Yy3gJal92r4kjfloSheD5HAcrfPpF
         kzNG56a8JAfDBUc3sKqivOomjHg9276CRfOmKMtd/pSbAeARQBo/elvYr4dYXkIQFaEb
         unbyR1X1JtXFOgZOKzeZ/OWNof+Cc9kCniy8E=
Received: by 10.101.133.20 with SMTP id k20mr7563203ann.250.1296828086498;
 Fri, 04 Feb 2011 06:01:26 -0800 (PST)
Received: by 10.101.1.19 with HTTP; Fri, 4 Feb 2011 06:01:26 -0800 (PST)
In-Reply-To: <AANLkTimrwUxNOAnfxgvReGN+-h4_0jhZ731y22TB6u1K@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166042>

On Fri, Feb 4, 2011 at 11:49 AM, Endre Czirbesz <endre@czirbesz.hu> wro=
te:
> Hi All,
>
> Thanks for the replies.
>
> 2011/2/4 Tor Arvid Lund <torarvid@gmail.com>:
>> On Fri, Feb 4, 2011 at 1:03 AM, Vitor Antunes <vitor.hda@gmail.com> =
wrote:
>>> git remote add remotename myprojectrepo
>
>> Endre, you should start like you already have; by git-p4 cloning you=
r
>> project from perforce. (You maybe want to have a dummy file checked =
in
>> to your <projectdir> in perforce, so that the 'git-p4 clone' command
>> produces at least one commit in your git repo)...
>>
>> Then, do 'git remote add tempremote <path-to-your-existing-git-repo>=
'
>> like Vitor suggests.
>>
>> At this point I would do:
>>
>> $ git checkout -b tempbranch tempremote/master
> At this point I got an error message:
> fatal: git checkout: updating paths is incompatible with switching br=
anches.
>
> So I fetched my tempremote first:
> $ git fetch tempremote
> $ git checkout -b tempbranch tempremote/master

See, this is what happens when I write a "how-to" and not actually try
it out before sending it... Obviously, you are correct in that you
have to fetch it before being able to check it out :-)

> (I got a warning from fetch, that there are no common commits, but I
> supposed that it is right. :) )

That is correct.

>> $ git rebase master
> It applied all my commits.
>
>> $ git-p4 submit
> =C2=A0Synchronizing p4 checkout...
> =C2=A0... - file(s) up-to-date.
> =C2=A0Applying 1##############################9 Initial commit
> =C2=A0error: ***: already exists in working directory
> [...]
> =C2=A0Unfortunately applying the change failed!
>
> It said this error for all my files. :(
> But I think we are almost there. :)

Again, if only I'd tried it myself first! ;)

Well, I can get it to work if I do:
$ git p4 sync

before the 'git p4 submit'.

Try that, and see if it works for you. (BTW, when committing
half-works, and then fails, oftentimes you need to do a bit of cleanup
in perforce... Revert files, manually remove files created by git
inside your p4 clientspec root directory, that sort of thing...)

    -- Tor Arvid
