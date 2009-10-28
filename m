From: Baz <brian.ewins@gmail.com>
Subject: Re: possible usability issue in rebase -i?
Date: Wed, 28 Oct 2009 14:34:09 +0000
Message-ID: <2faad3050910280734l7297c30erfb0a47b12b0bd07d@mail.gmail.com>
References: <40aa078e0910270313j5dc68576v86a3947f0dc7f9f@mail.gmail.com>
	 <2faad3050910270817l71394722nda55265ed96722df@mail.gmail.com>
	 <40aa078e0910270850u6ffec41cj372da11d9df533f@mail.gmail.com>
	 <2faad3050910271405k4a391184vb978b9b35484383b@mail.gmail.com>
	 <40aa078e0910280520t497f1289sf374a3a501856a23@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Wed Oct 28 15:34:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N39bP-0005yA-OT
	for gcvg-git-2@lo.gmane.org; Wed, 28 Oct 2009 15:34:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754121AbZJ1OeI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 Oct 2009 10:34:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754103AbZJ1OeI
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Oct 2009 10:34:08 -0400
Received: from gv-out-0910.google.com ([216.239.58.188]:23457 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754097AbZJ1OeG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 Oct 2009 10:34:06 -0400
Received: by gv-out-0910.google.com with SMTP id r4so98163gve.37
        for <git@vger.kernel.org>; Wed, 28 Oct 2009 07:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=hS2tUtxNSzwj/J8Qo6FfXmWCXDsagOK2qVgzHW+WteA=;
        b=FpisNmO8XqBPBmlBPq5IUFFYzP+yNeDCjfaNQWL/LDTPf9cs09+vH0jnv83MckkAjH
         zgpB2E/HQMn9NR/sxuPf4pSyPUjlujd7pHldiCkM21vTt+5qz2UBo2Tr3cRtBhAM/Wt4
         igdsnMmFpn5JvGRo+a/yn3hYWZKcwzLMYShGQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=W0bNw79jHXcqujrFkuzODz3XrAQkWPqwLebNkbJQqhRFPGIBcq5jSPuvZiosB8q1Cb
         Ys9cyg8Lgk/nJ+WfQgIBEJsTdT+tns4KIZGuOciOpc8AdYwRerV5dUNC24OYaSMhL47m
         fVudMHqqE2/2R33rkVd2gmWr66oYNp73KqH2c=
Received: by 10.216.88.136 with SMTP id a8mr4045670wef.77.1256740449908; Wed, 
	28 Oct 2009 07:34:09 -0700 (PDT)
In-Reply-To: <40aa078e0910280520t497f1289sf374a3a501856a23@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131466>

2009/10/28 Erik Faye-Lund <kusmabite@googlemail.com>:
> On Tue, Oct 27, 2009 at 10:05 PM, Baz <brian.ewins@gmail.com> wrote:
>> I'm fine with this way of fixing it, but I'd make a few more changes=
=2E..
>
> Feel free to make a patch-series that addresses more issues - I'm not=
 going to.
>

Yep, I wrote one but had to leave the house before sending it. Later to=
day.

> We make patches of one change at the time in Git. Other (related)
> usability issues becomes separate patches, preferably grouped togethe=
r
> in a patch-series. This change would be one patch in such a series.
>
>>> =C2=A0OPTIONS_SPEC=3D"\
>>> =C2=A0git-rebase [-i] [options] [--] <upstream> [<branch>]
>>
>> Use the dashless form and be more consistent with the help - and
>> mention '--root' here, it appears in the
>> help below:
>>
>> -git-rebase [-i] [options] [--] <upstream> [<branch>]
>> +git rebase [--interactive | -i] [options] [--onto <newbase>] [--]
>> <upstream> [<branch>]
>> +git rebase [--interactive | -i] [options] --onto <newbase> --root
>> [--] [<branch>]
>>
>
> I'm not sure I follow - aren't dashless options, uhm, dashless? Do yo=
u
> mean to use the long-form instead of the short-form? I'll assume
> that's what you mean for now, since you changed "-i" to "--interactiv=
e
> | -i".

No, I just meant 'git rebase' not 'git-rebase'. Sorry, I changed a
couple of things at once.

>
> If so, I'm not 100% convinced it's a clear win: some grep'ing
> indicates that both the short and long form are both widely used, wit=
h
> short-option bein a slight favor:
> $ git grep " \[--" | grep -v " \[--\]" | wc -l
> =C2=A0 =C2=A0228
> $ git grep " \[-[^-]" | wc -l
> =C2=A0 =C2=A0243
>
> Also, the usage isn't the only documentation. I think it makes sense
> to try to keep the usage short and to the point, there's a list
> describing each option (showing the full-name) further down in the
> usage-message. And if that's not enough, there's the "git
> help"-command.
>
> If I've misunderstood you and you only want the usage-string to match
> that of the manpage, perhaps that might be a good idea. I dunno.

In the patch I've followed other uses of OPTIONS_SPEC; they're quite
verbose, covering all options, while scripts using USAGE/LONG_USAGE
tend to emit one-liners. As for calling out 'interactive', at the
other extreme its not clear to me why we mention '-i' separately from
'[options]' at all. rebase is already pretty inconsistent here, giving
short or long usage messages depending on whether you passed '-i'. But
I'll take comments on this when I submit the patch, I've no strong
feelings on it.

>
>>
>>> -git-rebase [-i] (--continue | --abort | --skip)
>>> +git-rebase [-i] [-m] (--continue | --abort | --skip)
>>
>> Again, dashless. And I'd not mention the useless -i here, the man pa=
ge
>> doesn't either:
>>
>> -git-rebase [-i] (--continue | --abort | --skip)
>> +git rebase (--continue | --abort | --skip)
>>
>
> It was already there, so I didn't consider it, but I guess it makes
> sense. Besides, I aimed at not loosing any information while making i=
t
> a bit clearer.
>
>> These two items are misplaced in the help (I think). They're not lik=
e
>> abort, continue, skip, but then, the man page doesn't group those
>> separately either.
>>
>> +no-verify =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0override pre-rebase hoo=
k from stopping the operation
>> +root =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rebase all re=
achable commmits up to the root(s)
>>
>
> Agree.
>
>>> =C2=A0Actions:
>>> =C2=A0continue =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue rebasing=
 process
>>> =C2=A0abort =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0abort r=
ebasing process and restore original branch
>>
>> As above, remove the next two lines after your patch:
>>
>> -no-verify =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0override pre-rebase hoo=
k from stopping the operation
>> -root =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rebase all re=
achable commmits up to the root(s)
>
> I don't follow this. Are you repeating yourself now? :)

Yes :) ... was just finishing off moving those two lines.

Cheers,
Baz

>
> --
> Erik "kusma" Faye-Lund
>
