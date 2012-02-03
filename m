From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v3 1/4] completion: be nicer with zsh
Date: Fri, 3 Feb 2012 12:38:55 +0200
Message-ID: <CAMP44s0Fq_BGwcmDM5E1kWNiyoJw6e6Hr=8XaNF6tmQAcdnUmw@mail.gmail.com>
References: <1328145320-14071-1-git-send-email-felipe.contreras@gmail.com>
	<20120202084859.GC3823@burratino>
	<7v8vklvxwh.fsf@alter.siamese.dyndns.org>
	<CAMP44s1gWNG+jJ6M7OnLS-1VA5YPa07LJfnrvdbsQb0MOJB7PA@mail.gmail.com>
	<7vhaz8vkhd.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 03 11:39:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RtGXs-0003Pd-RJ
	for gcvg-git-2@plane.gmane.org; Fri, 03 Feb 2012 11:39:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755780Ab2BCKi6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 3 Feb 2012 05:38:58 -0500
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:32925 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755451Ab2BCKi4 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Fri, 3 Feb 2012 05:38:56 -0500
Received: by lagu2 with SMTP id u2so1777530lag.19
        for <git@vger.kernel.org>; Fri, 03 Feb 2012 02:38:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=4cPK1JQV3FXu0AquFlyGCRjgatPrKsMzf1Y7ZhqDVvo=;
        b=jtL1U+krupi8lZaiyapLBA0Tk/d6FfVBaLZcj0GpF0AXIIveBxIwktszsTxItuaXKS
         qhDmoBZTQBO/D57D5II0gEANn1GjHC1P8kcOUuxmeetSpfcm2j7iZm7+1jmKXc3bnP+J
         2q4B47CcZ4Au9CbwgsMYbzKXsZ1rEUuLfA25Q=
Received: by 10.152.102.237 with SMTP id fr13mr3474113lab.10.1328265535400;
 Fri, 03 Feb 2012 02:38:55 -0800 (PST)
Received: by 10.112.40.202 with HTTP; Fri, 3 Feb 2012 02:38:55 -0800 (PST)
In-Reply-To: <7vhaz8vkhd.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189747>

On Fri, Feb 3, 2012 at 2:17 AM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> On Thu, Feb 2, 2012 at 9:27 PM, Junio C Hamano <gitster@pobox.com> w=
rote:
>>> Jonathan Nieder <jrnieder@gmail.com> writes:
>>>> However, clearly I did not say it clearly enough. :) I guess it's
>>>> better to take a cue from storytellers and show rather than tell.
>>>
>>> Very big thanks for this ;-)
>>
>> Not a single comment regarding what I said?
>
> What entitles you to force me to refraining from commenting at all un=
til I
> read everything in my mailbox and after waiting for a while to make s=
ure
> there is no more to come to the thread?

=46air enough. Just wondering.

> In any case, "be nicer with zsh" conveys no more meaningful informati=
on
> than "this is some patch about zsh".

And that already tells you a lot more than other alternatives.

> Let's try to avoid warm and fuzzy
> words that imply "goodness", e.g. "improve" and "be nicer with" becau=
se
> nobody sends a patch to purposefully make Git worse and expects it to=
 be
> applied.

True. Which why I listened to the suggestion from Thomas Rast and
didn't use that, but "completion: work around zsh option propagation
bug" instead.

> I found Jonathan's alternative "avoid default value assignment on : t=
rue
> command" at least a bit better for the purpose of jogging the short-t=
erm
> memory in the "'git shortlog v1.7.9.. contrib/completion/' tells us t=
hat
> we have applied several patches, and I remember that : ${var=3Dword} =
one!"
> sense. =C2=A0It is not super-useful for the longer term, though.
>
> Here is what I ended up in preparation for queuing the series. =C2=A0=
I still
> haven't seen any version of 4/4, but please check $gmane/189683 and s=
ee if
> that matches what you intended. =C2=A0Also I am assuming $gmane/18960=
6 relayed
> by Jonathan is a squash between your 2 and 3 (which didn't reach me),=
 so
> please advise if that does not match what you want to have.

This is getting ridiculous, now I sent the patches directly to you, is
your pobox.com server also silently dropping them for no reason? I
think this is totally counter-productive. I haven't received any reply
from the vger postmaster, but I guess you should be able to find out
why your host is dropping mails. Am I the only one that has such
issues?

Anyway. I have uploaded all the mails to here:

http://people.freedesktop.org/~felipec/git-patches/

As for $gmane/189683, the changes seem to be correct, but I still
prefer my commit message[1]--which I have written and rewritten many
times now to improve it.

Regarding $gmane/189606, I still prefer my commit message[2], because
it starts with the *purpose* of the patch. As for the changes, they
are correct, and I don't mind squashing them, but they are *two*
logically independent changes; imagine in the future somebody
wants/need to re-enable __git_shopt, well, all they have to do is
revert the second patch. But that's up to you.

Cheers.

[1] http://people.freedesktop.org/~felipec/git-patches/4
[2] http://people.freedesktop.org/~felipec/git-patches/2

--=20
=46elipe Contreras
