From: Thomas Anderson <zelnaga@gmail.com>
Subject: Re: unable to checkout branches and proper procedure for creating a 
	new branch based off of another one
Date: Wed, 16 Jun 2010 22:44:55 -0500
Message-ID: <AANLkTilasCQ1_F0z8NTaJzFNvgnFGImlGN5DcOh0O7VV@mail.gmail.com>
References: <AANLkTilZ6zoByCngAGoCbgQ9yd424VcChpTKh_XLnogd@mail.gmail.com>
	<AANLkTillFOvwAK_rHhUjhbjRupD1DnQpcMFB3QbExctt@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 17 05:45:03 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OP62I-0007Jv-NN
	for gcvg-git-2@lo.gmane.org; Thu, 17 Jun 2010 05:45:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756940Ab0FQDo4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 16 Jun 2010 23:44:56 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:55508 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756697Ab0FQDo4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Jun 2010 23:44:56 -0400
Received: by pxi8 with SMTP id 8so4268607pxi.19
        for <git@vger.kernel.org>; Wed, 16 Jun 2010 20:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=nSz4bGKgEdIAu+brU8sT2OrgTHbVH9lE4R5FCZpc93A=;
        b=bOI1fHCZhRnKdKDWA1nLIIlJvDGezmgNINdvZWMnKBpzJ885458ej05WTShoX15SjU
         odA8wpG7tc639RD/sR78saDLlzg1jhKcwcLerEnP0PMGL0+DVVL4UZ0Gqs4qSB5EHYSm
         00M60aa7C5FekeyagVnMDvDr92CDlFatIxTPE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=w/VmJXDjtHgjn+VQCkw7cQ1NAJ24+XJ2NtyLBSRzaxrbBm4BzlKEw4UPAhWVDVLI7Z
         yQCwcOb4WKmQIEzfoL97iaJFZzsUOopXFB1Bh8TEkNG6BCXZp1Bi6KAdnBgiLy4sH2j1
         FvJtvO22rJdHQK7ggYrGAnUGUpB+moNwYncfQ=
Received: by 10.143.25.39 with SMTP id c39mr6997358wfj.47.1276746295565; Wed, 
	16 Jun 2010 20:44:55 -0700 (PDT)
Received: by 10.142.87.4 with HTTP; Wed, 16 Jun 2010 20:44:55 -0700 (PDT)
In-Reply-To: <AANLkTillFOvwAK_rHhUjhbjRupD1DnQpcMFB3QbExctt@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149287>

Also, directories that are present in the "branch" branch aren't
present in the current working directory, despite my having switched
over.  "git checkout origin/branch" adds the missing directories but
"git checkout -b origin/branch" does not.  Which leaves me wondering
what the latter is doing.

On Wed, Jun 16, 2010 at 10:32 PM, Thomas Anderson <zelnaga@gmail.com> w=
rote:
> I guess what I was trying to do was checkout a remote branch. =A0Of
> course, it's unclear to me what the difference between "git checkout
> origin/branch" and "git checkout -b origin/branch" is. =A0The latter
> creates a local branch and the former doesn't? =A0Does that mean that=
,
> with the former, changes I commit and subsequently push will get
> written to the remote default branch and not the remote "branch"
> branch?
>
> And how do I check that files in the current working directory are
> from the desired branch? =A0"git log" shows commits made to the defau=
lt
> branch - not to the "default" branch, which doesn't give me much
> confidence...
>
> On Wed, Jun 16, 2010 at 9:41 PM, Thomas Anderson <zelnaga@gmail.com> =
wrote:
>> Say there's a Git repository with two branches: default (which is th=
e
>> default branch) and branch. =A0I want to checkout branch and start
>> working on that but am unsure of how to do it. =A0Here are the comma=
nds
>> that I did:
>>
>> git clone git@github.com:username/repo.git
>> cd repo
>> git checkout branch
>>
>> But that gets me the following error:
>>
>> fatal: Not a git repository (or any of the parent directories): .git
>>
>> I do "git branch" and here's what I see:
>>
>> * default
>>
>> Where's "branch"?
>>
>> And let's say I wanted to create my own branch based on "branch".
>> Let's say "branch-zelnaga". =A0How would I do that? =A0Do I just che=
ckout
>> that branch, create a new branch while the current working directory
>> contains files from the desired branch and then push / commit as
>> appropriate?
>>
>
