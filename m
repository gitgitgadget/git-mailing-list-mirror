From: Michael Horowitz <michael.horowitz@ieee.org>
Subject: Re: git-p4 using notes
Date: Fri, 16 Dec 2011 19:57:00 -0500
Message-ID: <CAFLRboq3--JcfWb=-p-hoNMsQZ-fHS3=5dgYc-pwQy7-rGy-gQ@mail.gmail.com>
References: <CAFLRbori1Dinc2epputWfjgCOWp7M2f=+TA0w2jHq_fmRC=y3w@mail.gmail.com>
	<4EEBA24F.8030103@diamand.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Sat Dec 17 01:57:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RbiaK-0006h4-A6
	for gcvg-git-2@lo.gmane.org; Sat, 17 Dec 2011 01:57:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752733Ab1LQA5D convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 16 Dec 2011 19:57:03 -0500
Received: from mail-pz0-f46.google.com ([209.85.210.46]:36358 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752708Ab1LQA5B convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 Dec 2011 19:57:01 -0500
Received: by dajs34 with SMTP id s34so2375571daj.19
        for <git@vger.kernel.org>; Fri, 16 Dec 2011 16:57:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Zho4WT/dCzpgN4h4WzRXydRfG+d2o3fwE/FSGmZs5u8=;
        b=lgtPjRITx/SXPR+SfCjEkWrY1SZyXNdX0b42jOIW+PG/sWQFEV4552fx3DOrvS2dTw
         qNP2l06+gCEz0ca5o3kJN8Iw+2zdZPkV0980gFWwrLRjn9XXxxV+IzwidxP3CgINaIg/
         gK0RTe1E/kq/3/Cbaka8ccoxIC8KuMSz34A4E=
Received: by 10.68.72.6 with SMTP id z6mr20278725pbu.73.1324083420980; Fri, 16
 Dec 2011 16:57:00 -0800 (PST)
Received: by 10.143.31.6 with HTTP; Fri, 16 Dec 2011 16:57:00 -0800 (PST)
In-Reply-To: <4EEBA24F.8030103@diamand.org>
X-Google-Sender-Auth: kGijjVJ0li4ka7Gy4LeEbAi5C-0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187342>

That would be great.  If you need me to help test, let me know.
Unfortunately I don't know Python and I know very little about the
internals of git, so I can't help much more than that...

Mike



On Fri, Dec 16, 2011 at 2:55 PM, Luke Diamand <luke@diamand.org> wrote:
> On 16/12/11 16:07, Michael Horowitz wrote:
>>
>> For those of you using git-p4 because of a company requirement to us=
e
>> Perforce, but really wish you could use git only, the most frustrati=
ng
>> part is the fact that when changes are submitted, the commit message
>> is rewritten to include a reference to the P4 change number which is
>> used by the sync. =A0When syncing back changes, this causes the comm=
it
>> hash to be different, and so blows away your old commit and any pare=
nt
>> commit references and such.
>>
>> I read someplace, I can't remember where at this point, that if git-=
p4
>> used notes to write the P4 change information, that would not impact
>> the commit hash, so when merging back, things would not be
>> overwritten, and you can maintain branches and commit history proper=
ly
>> in git.
>>
>> I just ran into this project, where it seems that someone has
>> re-written git-p4 to use notes: https://github.com/ermshiperete/git-=
p4
>>
>> I was wondering if any of the maintainers of git-p4 has considered
>> this, and might want to leverage this work to merge into the main gi=
t
>> repo, possibly with an option to choose between the two behaviors.
>
>
> I'm not sure I qualify for such a grand title as maintainer, but I wa=
s going
> to give this a go in the new year as it would be quite useful, unless
> someone beat me to it. I want to fix some problems with labels first =
though.
>
> Regards!
> Luke
