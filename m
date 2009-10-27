From: Baz <brian.ewins@gmail.com>
Subject: Re: possible usability issue in rebase -i?
Date: Tue, 27 Oct 2009 21:05:53 +0000
Message-ID: <2faad3050910271405k4a391184vb978b9b35484383b@mail.gmail.com>
References: <40aa078e0910270313j5dc68576v86a3947f0dc7f9f@mail.gmail.com>
	 <2faad3050910270817l71394722nda55265ed96722df@mail.gmail.com>
	 <40aa078e0910270850u6ffec41cj372da11d9df533f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Tue Oct 27 22:06:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N2tEv-0007vk-79
	for gcvg-git-2@lo.gmane.org; Tue, 27 Oct 2009 22:06:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932281AbZJ0VFu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 27 Oct 2009 17:05:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932233AbZJ0VFu
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Oct 2009 17:05:50 -0400
Received: from ey-out-2122.google.com ([74.125.78.26]:48911 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932167AbZJ0VFt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Oct 2009 17:05:49 -0400
Received: by ey-out-2122.google.com with SMTP id 9so59914eyd.19
        for <git@vger.kernel.org>; Tue, 27 Oct 2009 14:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=HdJI4p7g6Bx1yMsPYF6JsP5HUocGsY25IbBykj/0/gQ=;
        b=eozuOvR93PwMVQGoRea8RpmwGdx5K5qGUNOTRVTHSie8r8iSoujTxrc0voCpHP7txs
         KcxmqvZ2u7ET7WyNart2I2pGTc3yAR9YJyVPQChLB8LiJBOhdjHy3TpbtRUz4sTwR5my
         Kb9SxCKTzv5X4hjQXia+9u8MHAx1NSgFVw510=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=MjNEVao3BgQYT+q5V93vMB+Uy01ierJzgHP2iWypCqC0iL+Auetr3A2d4PaYiqK5DG
         aj6GMPPFPs0MfcJNQEuZgpBv3dRQBDEIuC7vKP5I4b3pT8nAN6YjdiB/4AkNUFuQGEZq
         wW8euboY0OgwQzuCfjb2R10HjL9+NpDa4VnlI=
Received: by 10.216.87.144 with SMTP id y16mr2788450wee.95.1256677553133; Tue, 
	27 Oct 2009 14:05:53 -0700 (PDT)
In-Reply-To: <40aa078e0910270850u6ffec41cj372da11d9df533f@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131379>

2009/10/27 Erik Faye-Lund <kusmabite@googlemail.com>:
> On Tue, Oct 27, 2009 at 4:17 PM, Baz <brian.ewins@gmail.com> wrote:
>> I've got a somewhat related minor usability issue with rebase -i. I
>> accidentally typed something like 'git rebase -i -z' and got this
>> message:
>>
>> error: unknown switch `z'
>> usage: git-rebase [-i] [options] [--] <upstream> [<branch>]
>> =C2=A0 or: git-rebase [-i] (--continue | --abort | --skip)
>>
>> Available options are
>> =C2=A0 =C2=A0-v, --verbose =C2=A0 =C2=A0 =C2=A0 =C2=A0 display a dif=
fstat of what changed upstream
>> =C2=A0 =C2=A0--onto ... =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0reb=
ase onto given branch instead of upstream
>> =C2=A0 =C2=A0-p, --preserve-merges
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0try to recreate merges instead of ignoring them
>> =C2=A0 =C2=A0-s, --strategy ... =C2=A0 =C2=A0use the given merge str=
ategy
>> =C2=A0 =C2=A0-m, --merge =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 always u=
sed (no-op)
>> =C2=A0 =C2=A0-i, --interactive =C2=A0 =C2=A0 always used (no-op)
>>
>> The last two lines were the surprise. It suggested to me that '-i' a=
nd
>> '-m' were now the defaults for git-rebase - which of course they're
>> not. A user would not know that this is actually reporting the flags
>> that work for git-rebase--interactive, especially since that's not
>> what the command calls itself. I wasn't sure about the best approach
>> to fixing this - the only comparable commands that pass arbitrary
>> flags down to an exec'd program make it clear what program is going =
to
>> be called (usually git merge) and so interpreting errors is easier.
>>
>> It seems the intent here was to signal that the flags are different
>> once a rebase is in progress, but this usage message is shown when
>> rebase -i -z is called in any state.
>
> If that is the case, my instinct tells me that this information shoul=
d
> be reflected in the usage-string (instead of the parameter
> description). Something like this?

I'm fine with this way of fixing it, but I'd make a few more changes...

>
> --->8---
>
> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> index 23ded48..3ed5f94 100755
> --- a/git-rebase--interactive.sh
> +++ b/git-rebase--interactive.sh
> @@ -13,15 +13,15 @@
> =C2=A0OPTIONS_KEEPDASHDASH=3D
> =C2=A0OPTIONS_SPEC=3D"\
> =C2=A0git-rebase [-i] [options] [--] <upstream> [<branch>]

Use the dashless form and be more consistent with the help - and
mention '--root' here, it appears in the
help below:

-git-rebase [-i] [options] [--] <upstream> [<branch>]
+git rebase [--interactive | -i] [options] [--onto <newbase>] [--]
<upstream> [<branch>]
+git rebase [--interactive | -i] [options] --onto <newbase> --root
[--] [<branch>]


> -git-rebase [-i] (--continue | --abort | --skip)
> +git-rebase [-i] [-m] (--continue | --abort | --skip)

Again, dashless. And I'd not mention the useless -i here, the man page
doesn't either:

-git-rebase [-i] (--continue | --abort | --skip)
+git rebase (--continue | --abort | --skip)

> =C2=A0--
> =C2=A0Available options are
> =C2=A0v,verbose =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0display a diffstat =
of what changed upstream
> =C2=A0onto=3D =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rebase =
onto given branch instead of upstream
> =C2=A0p,preserve-merges =C2=A0try to recreate merges instead of ignor=
ing them
> =C2=A0s,strategy=3D =C2=A0 =C2=A0 =C2=A0 =C2=A0use the given merge st=
rategy
> -m,merge =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0always used (no-op)
> -i,interactive =C2=A0 =C2=A0 =C2=A0always used (no-op)
> +m,merge =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0use merging strateg=
ies
> +i,interactive =C2=A0 =C2=A0 =C2=A0interactively edit commits

These two items are misplaced in the help (I think). They're not like
abort, continue, skip, but then, the man page doesn't group those
separately either.

+no-verify          override pre-rebase hook from stopping the operatio=
n
+root               rebase all reachable commmits up to the root(s)

> =C2=A0Actions:
> =C2=A0continue =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue rebasing p=
rocess
> =C2=A0abort =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0abort reb=
asing process and restore original branch

As above, remove the next two lines after your patch:

-no-verify          override pre-rebase hook from stopping the operatio=
n
-root               rebase all reachable commmits up to the root(s)

-Baz

>
> --
> Erik "kusma" Faye-Lund
>
