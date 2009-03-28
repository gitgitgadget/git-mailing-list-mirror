From: Jacob Helwig <jacob.helwig@gmail.com>
Subject: Re: git svn fails to work
Date: Sat, 28 Mar 2009 15:01:17 -0700
Message-ID: <8c9a060903281501t268897d1pe2afa2f82fd2fd3a@mail.gmail.com>
References: <EA1460555FA0423EB6C233B3B0F4F098@HPLAPTOP> <37fcd2780903281351w6f77a647kd44a9afe4d2ee953@mail.gmail.com> 
	<AE2ECDC6B332479293D910D9352DCF21@HPLAPTOP>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Aaron Gray <aaronngray.lists@googlemail.com>
X-From: git-owner@vger.kernel.org Sat Mar 28 23:03:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LngcK-0000u3-Cy
	for gcvg-git-2@gmane.org; Sat, 28 Mar 2009 23:03:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761197AbZC1WBg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 28 Mar 2009 18:01:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761195AbZC1WBg
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Mar 2009 18:01:36 -0400
Received: from wf-out-1314.google.com ([209.85.200.169]:25138 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761197AbZC1WBe convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 28 Mar 2009 18:01:34 -0400
Received: by wf-out-1314.google.com with SMTP id 29so1943931wff.4
        for <git@vger.kernel.org>; Sat, 28 Mar 2009 15:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :received:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=HWCiEOLJ0rW9prbUjEQrXJcRXS8asLoqmQS0acUqWYA=;
        b=EZGouBGXnf06AfEA/3biRsgR885LC11IUcSL2Ht/KS5KE3wwCGkTUOhlP+fl6WoQCF
         yoyBCLLaam69BVnnpxp6dP4CnLyM6HY0le30eqyOlyDqyrYwvxqspGiQZOap6jqEGHjV
         rz9U/oGghXwQRaXzvgVgS69lZZSPl07gQOyII=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=GX92QXhT390a25S7KBv4rQHOduZ0clCMUG7p0vTfK1oBT5rZif/TGvZ7XXJ/+aEH0m
         2Rv1GsRm/G7aGhGxLcHVk8mZWKXm1rxL2Rsf6YWEAzFnZC6pUHiP+V1pafPbx97yxUWU
         uTVHQKjhJqQm1HH2U3rjGHyde+2zcnHSd+LK0=
In-Reply-To: <AE2ECDC6B332479293D910D9352DCF21@HPLAPTOP>
Received: by 10.142.217.17 with SMTP id p17mr1482950wfg.40.1238277692930; Sat, 
	28 Mar 2009 15:01:32 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114981>

On Sat, Mar 28, 2009 at 14:43, Aaron Gray
<aaronngray.lists@googlemail.com> wrote:
>> On Sat, Mar 28, 2009 at 8:48 PM, Aaron Gray
>> <aaronngray.lists@googlemail.com> wrote:
>>>
>>> I have been tying for a week to get git svn to work. If i do a 'git
>>> clone'
>>> and if falls over 'git svn fetch' picks up from where it left off, =
but on
>>> completion I can only see the older stuff if at all and a 'git clon=
e
>>> rebase'
>>> eithr shoud up unreconsilable differences or refuses to execute the
>>> command
>>> at all, gust giving uphelpfull help afaics.
>>
>> I am afraid if you expect anyone to help you with you, you have to s=
pend
>> a little more time to describe your problem. You have not mentioned =
what
>> version of Git you use, what operating system, what is layout of you=
r SVN
>> repo, what commands and with what options you used and what was thei=
r
>> output. Without that information no one will be able to help you...
>>
>>> Otherwise I am giving up and either going back to svn or over to
>>> mercurial.
>>
>> Yeah, right... These kind of threats will make people who want to he=
lp to
>> come running....
>
> Sorry, but I am very frustrated with the whole thing, there is not re=
al user
> guides for git-svn other that third party ones which seem to be wrong=
=2E
>
> I am using Fedora 10, GIT 1.6.0.6, the svn repo is standard layout al=
though
> I only want trunk, it here :-
>
> =C2=A0 svn co http://llvm.org/svn/llvm-project/llvm/trunk llvm
>
> This is quite a big repository 65000 or more revisions.
>
> The commands
>
> =C2=A0 git svn clone http://llvm.org/svn/llvm-project/llvm/trunk
>
> when connection fails I do a :-
>
> =C2=A0 git svn fetch
>
> gitweb is not updating at all to show any change in the repository.
>
> Aaron
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
>

gitweb will only show your local branches.  git svn fetch will update
the remote branches associated with svn.  You'll need to create a
local tracking branch for the svn remote branch.
