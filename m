From: Pat Notz <patnotz@gmail.com>
Subject: Re: [1.8.0] git-stash invocation changes
Date: Wed, 9 Feb 2011 07:35:38 -0700
Message-ID: <AANLkTineuxosCRRRJosziv9umgtO9uN3nAAh_v=f3Vfk@mail.gmail.com>
References: <7vzkqh8vqw.fsf@alter.siamese.dyndns.org> <AANLkTimu=drR+4v+B_aB+Y4jVqzaBghh1XYSZoACsBry@mail.gmail.com>
 <vpqtygmwbee.fsf@bauges.imag.fr> <201102021951.31883.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Shawn Pearce <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Wed Feb 09 15:36:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PnB9U-0005DT-EG
	for gcvg-git-2@lo.gmane.org; Wed, 09 Feb 2011 15:36:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755728Ab1BIOgB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Feb 2011 09:36:01 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:53503 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755679Ab1BIOgA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 Feb 2011 09:36:00 -0500
Received: by bwz15 with SMTP id 15so1017176bwz.19
        for <git@vger.kernel.org>; Wed, 09 Feb 2011 06:35:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=VIzZ0DKytXvRm+KBHXpKQ3dfp+qabD80/mrNTeaqSPs=;
        b=D4NjWu/tDVPgGdUtEVXXZc9/m7fOpebRNDwa2d09wSBITItjcT5T/DTQrI/bLYs/2C
         0WRXg4ipNZ1R6c0S36Y9yUolegVP1rmMH9j8xmF8gfSI3I7amVigxc/NXez2etg3gQJT
         /vO91cf5l7Y0aT/YVN58rgr0nrZIVU1lycsnk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=Od687Yf6miUca1Lvk8YLvpBc5kwFXPqKGsSi6bOHWisYZZIQEmply6C5KVf5M59yeh
         ay4IB6zs6P5enuwrWQI6pAkkoZmlYQ2AHjK6CXxYIqUaNKZdkJDuiEgIMseo6aIoBuZD
         vwfwnv8FfcEhfrvsaF5MdNWTFcrIaHJAArHDc=
Received: by 10.204.59.8 with SMTP id j8mr18952330bkh.26.1297262159129; Wed,
 09 Feb 2011 06:35:59 -0800 (PST)
Received: by 10.204.51.19 with HTTP; Wed, 9 Feb 2011 06:35:38 -0800 (PST)
In-Reply-To: <201102021951.31883.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166422>

On Wed, Feb 2, 2011 at 11:51 AM, Thomas Rast <trast@student.ethz.ch> wr=
ote:
> Matthieu Moy wrote:
>> Shawn Pearce <spearce@spearce.org> writes:
>>
>> > On Wed, Feb 2, 2011 at 09:23, Thomas Rast <trast@student.ethz.ch> =
wrote:
>> >> Proposal:
>> >>
>> >> 1. Change 'git stash <not-a-stash-command>' to give a usage messa=
ge
>> >> =A0 instead of using <not-a-stash-command> as the stash message.
>> >
>> > Oh please, yes, please do this. =A0We should have done this long, =
long
>> > ago. =A0Its easy enough to train your fingers or fix your scripts =
to say
>> > `git stash save list` rather than `git stash lsit` once stash erro=
rs
>> > out and gives you a usage message once.
>>
>> Err, hasn't this been fixed long ago already?
>
> Oh, you're actually right. =A0I have totally missed this, and should
> obviously have tested first.
>
> Still, I think the change to 'git stash -p' is also worthwhile.
>

There's still something annoyingly different about git-stash. Most git
commands that take sub-commands simply list useful information when
you don't provide a sub-command:

git branch --> lists local branches
git tag --> lists tags
git remote --> lists remotes
git stash --> creates a new stash

It would be much more predictable if git-stash without a sub-command
just listed the current stashes. But, at this point it's probably too
late to change that behavior.

> --
> Thomas Rast
> trast@{inf,student}.ethz.ch
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
