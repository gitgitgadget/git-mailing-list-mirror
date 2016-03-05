From: Charles Strahan <charles@cstrahan.com>
Subject: Re: Change in .gitignore handling: intended or bug?
Date: Fri, 04 Mar 2016 20:00:24 -0500
Message-ID: <1457139624.4135861.540124922.0A8B3F69@webmail.messagingengine.com>
References: <1457057516.1962831.539160698.3C8B30BC@webmail.messagingengine.com>
 <20160304055117.GB26609@ikke.info>
 <1457071957.2027843.539286050.10CF8D0A@webmail.messagingengine.com>
 <20160304115634.GC26609@ikke.info>
 <CACsJy8AN7xxFuVX4c6aR_RdDiuDRPjqbXS8Y2+xD4pV8G2onfg@mail.gmail.com>
 <xmqq4mcm17b4.fsf@gitster.mtv.corp.google.com>
 <CACsJy8BZm9pFdR+Njst7qZ1UnHUL9XpigM5pW+CLEicOc7ra8g@mail.gmail.com>
 <CACsJy8CcwaZ-zLX3iBKPDNkpMv5vRU=hHYFeBK7o0tnOq6uDJA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Kevin Daudt <me@ikke.info>, Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 05 02:00:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ac0a7-0006jZ-Au
	for gcvg-git-2@plane.gmane.org; Sat, 05 Mar 2016 02:00:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759116AbcCEBA1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Mar 2016 20:00:27 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:57035 "EHLO
	out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755567AbcCEBA0 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 4 Mar 2016 20:00:26 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
	by mailout.nyi.internal (Postfix) with ESMTP id 244B220B2C
	for <git@vger.kernel.org>; Fri,  4 Mar 2016 20:00:25 -0500 (EST)
Received: from web6 ([10.202.2.216])
  by compute2.internal (MEProxy); Fri, 04 Mar 2016 20:00:25 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=cstrahan.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=GmNYdkftSnnw9QPNEuva8sYc6YI=; b=Jtg4tO
	KQNl8IGet59cn0T6VLlXeHwlAp96emIYLn4d04OYCgaQ+bGoVqcBoffj+Yhxx3Xh
	fcC+eFmQONNu6jXzFSMHt4vR8BnpEZ1WUQErc96jS05BVsfOTHvNcSCEuZ/nor3p
	DeAIngQLm8cvIwO27uvhPRjpT8zkP996txnKg=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=GmNYdkftSnnw9QP
	NEuva8sYc6YI=; b=FBEmW6Nb93yIntzOa0A3V0CLWSe4CfUlA8DXSJecgMBoejj
	J+P5KS775KLrXaEI3Hh071blHk3yrRAAL6WP4lLYvy82V15/5qfPHdXlruSae+Et
	dM9uZ11hSLF7i4iVSAINh4aOTakuMs5Cbgb3saDhsxFUH+zF0+XklZto865I=
Received: by web6.nyi.internal (Postfix, from userid 99)
	id DE08549BE0; Fri,  4 Mar 2016 20:00:24 -0500 (EST)
X-Sasl-Enc: Ss2tpUHROks6o80Phl1rACPfwFPMO1SHlnvDQmn9POSH 1457139624
X-Mailer: MessagingEngine.com Webmail Interface - ajax-8b860007
In-Reply-To: <CACsJy8CcwaZ-zLX3iBKPDNkpMv5vRU=hHYFeBK7o0tnOq6uDJA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288286>

The fix on my side was quite easy (and my .gitignore is probably a _lot_
hairier
than most), and as Duy suggests, I think the new behavior makes a bit
more
sense. Personally, I would be pleased with keeping the new behavior, and
chalking it up to an unintentional bug fix (the best kind).

Either way, of course, I'd like for it to not change back and forth
between
releases :).

Perhaps just an announcement of the new behavior would suffice - 2.7.0
has been
out for a while anyway. If people were going to complain, I figure they
would
have done so by now.

-Charles


On Fri, Mar 4, 2016, at 07:50 PM, Duy Nguyen wrote:
> typo fixes
> 
> On Sat, Mar 5, 2016 at 7:43 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> > On Sat, Mar 5, 2016 at 12:28 AM, Junio C Hamano <gitster@pobox.com> wrote:
> >> Duy Nguyen <pclouds@gmail.com> writes:
> >>
> >>> On Fri, Mar 4, 2016 at 6:56 PM, Kevin Daudt <me@ikke.info> wrote:
> >>>> Verified that it's different in 2.7.0, but 2.7.2 gives expected output.
> >>>
> >>> Thanks. 2.7.1 reverts the faulty commit from 2.7.0 that generated two
> >>> other regression reports before this one. I guess it's all good then
> >>> (except for the people still on 2.7.0)
> >>
> >> Are we good at 2.8.0-rc0, too?  Somehow I had an impression that we
> >> queued "another attempt to do it differently" or something.
> >>
> >>  ... goes and looks ...
> >>
> >>     $ rungit maint status -suall
> >>     ?? baz/quux/corge/wibble.txt
> >>     ?? baz/quux/grault.txt
> >>     ?? foo/bar.txt
> >>     $ rungit master status -suall
> >>     ?? baz/quux/corge/wibble.txt
> >>     ?? baz/quux/grault.txt
> >>     ?? baz/waldo.txt
> >>     ?? foo/bar.txt
> >>     ?? foo/garply.txt
> >
> > If you swap a60ea8f and bac65a2 so that we can have tracing even
> > without the problematic commit a60ea8f (dir.c: fix match_pathname() -
> > 2016-02-15). Without a60ea8f I got
> >
> > GIT_TRACE_EXCLUDE=1 ~/w/git/temp/git status -suall 2>&1 >/dev/null
> > |grep waldo
> > 07:25:05.639445 dir.c:952               exclude: baz/waldo.txt vs * at
> > line 1 => yes
> >
> > (meaning, baz/waldo.txt matches "*" rule and is decided to be excluded)
> >
> > with a60ea8f
> >
> >> /tmp/abc $ GIT_TRACE_EXCLUDE=1 ~/w/git/temp/git status -suall 2>&1 >/dev/null |grep waldo
> > 07:25:24.425125 dir.c:952               exclude: baz/waldo.txt vs /baz
> > at line 4 => no
> >
> > the decision is not taken earlier from line "!/baz" and it's decided
> 
> s/not taken/taken/
> 
> > to be re-included. Which I would argue is the correct thing because
> > you ask to re-include the whole directory "baz". It should behave this
> > way because exclude rules without '!' behave this way.
> >
> > Because positive any negative rules can be nested, by adding a rule to
> 
> s/any/and/
> 
> > reinclude what's inside baz..
> >
> >     *
> >     !/foo
> >     !/foo/bar.txt
> >     !/baz
> >     /baz/*
> >     !/baz/quux
> >     !/baz/quux/**/*
> >
> > you'll get baz/waldo.txt excluded.
> >
> > Yes it's a behavior change. I think the old behavior is unintended.
> > But it's probably out there long enough that many .gitignore files may
> > rely on it and by making it right, I break them. Whether to revert the
> > series is up to you. Let me know if I should send the revert patch.
> > --
> > Duy
> 
> 
> 
> -- 
> Duy
