From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: Wish: make commiter email address configurable per-repo
Date: Fri, 7 Jan 2011 19:19:01 +0100
Message-ID: <AANLkTikaSwLGG_=uhF+-YqOHrqtLRBqc2qLw46G03-pg@mail.gmail.com>
References: <ig73o1$lbg$1@dough.gmane.org> <201101071420.40570.trast@student.ethz.ch>
 <ig7449$lbg$2@dough.gmane.org> <201101071443.51574.trast@student.ethz.ch> <ig7kej$j4p$1@dough.gmane.org>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Stephen Kelly <steveire@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 07 19:19:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PbGuO-0003TG-7D
	for gcvg-git-2@lo.gmane.org; Fri, 07 Jan 2011 19:19:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755004Ab1AGSTX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 Jan 2011 13:19:23 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:58166 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754758Ab1AGSTW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 Jan 2011 13:19:22 -0500
Received: by fxm20 with SMTP id 20so17176655fxm.19
        for <git@vger.kernel.org>; Fri, 07 Jan 2011 10:19:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:reply-to
         :in-reply-to:references:from:date:message-id:subject:to:cc
         :content-type:content-transfer-encoding;
        bh=dCtS/4xFiMAb12lUk4zu9Vue+JIug+ZsGo0sWGQ2irE=;
        b=occF65HV6wTEGZ208wP3bPIBXZt1G0dJIO30P1+HcPfWbhtfb/PlFjBD7BB60jyKIA
         ZQWg5dR8tAmW76NSJx3GqTQ4I91IaJAOBgfzfjnhKwCreH/ZCoSJDpqyF6BfW31/vSRO
         6R1B3w2Qw0R8kfGGxeYazKZft1U+BPQSRAglY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        b=TH2c4bci6DOgnN4V8dDmJQRK9ND6YYFO7dHXko2Tkd0tAGfs55fN+u+TyWW/zgoLCS
         ZYmAi7HuBjS4Sqr83fjtOm7Hx0UTGlxWl5g8Ymvh+jTeomCc7mvdf6UJPOkQlj6oSE4+
         x77q2rCfeETHdjP4H2vxAK4JXZXceHJlnYqPc=
Received: by 10.223.118.136 with SMTP id v8mr61764faq.90.1294424361367; Fri,
 07 Jan 2011 10:19:21 -0800 (PST)
Received: by 10.223.79.3 with HTTP; Fri, 7 Jan 2011 10:19:01 -0800 (PST)
In-Reply-To: <ig7kej$j4p$1@dough.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164730>

On Fri, Jan 7, 2011 at 7:01 PM, Stephen Kelly <steveire@gmail.com> wrot=
e:
> Thomas Rast wrote:
>
>> Stephen Kelly wrote:
>>> Thomas Rast wrote:
>>> > See user.email in git-config(1). =A0Most people set it globally, =
as in
>>> >
>>> > =A0 git config --global user.email "author@example.com"
>>> >
>>> > but there's nothing stopping you from doing
>>> >
>>> > =A0 git config user.email "alias@example.com"
>>> >
>>> > to set it on a per-repo level. =A0(Or just edit .git/config, of c=
ourse.)
>>>
>>> Doesn't this set both the author and the committer?
>>
>> Oh, I see. =A0Yes, it does.
>>
>> Stephen Kelly wrote earlier:
>>> If my email address that I use for committing is not the same as th=
at
>>> configured in the bugzilla, the automated bug closing does not work=
=2E
>>
>>
>> Probably if KDE has this use-case then that means we need to impleme=
nt
>> it as a feature on size alone, but I briefly looked into the code an=
d
>> it requires a bit more restructuring than I'm willing to do over
>> coffee.
>>
>> I think as a stop-gap measure you'll have to use an alias such as
>>
>> =A0 ci =3D commit --author=3D"your usual <author>"
>>
>> along with a local setting for user.email to force them to be
>> different. =A0(Note that this will re-set the author when saying 'gi=
t
>> ci --amend' on other people's commits!)
>>
>
> Thanks for looking into it!
>
> I'll consider the alias you suggest. Git command aliases can be confi=
gured
> per repo, right?
>

Yes, aliases are normal configuration variables, and can be set per rep=
o.

> Is there a bug tracker used for git so that this issue doesn't get lo=
st?
>

No, just this mailing list.
