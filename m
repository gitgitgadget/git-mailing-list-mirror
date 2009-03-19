From: demerphq <demerphq@gmail.com>
Subject: Re: Gnome chose Git
Date: Thu, 19 Mar 2009 22:40:39 +0100
Message-ID: <9b18b3110903191440w20ca9801pfb218cc4b10ea769@mail.gmail.com>
References: <877i2lbvt7.fsf@iki.fi> <49C249B9.7010001@drmicha.warpmail.net>
	 <1cd1989b0903190643p19a40718yc4fd2730aab0a9a0@mail.gmail.com>
	 <49C24D9B.1060301@drmicha.warpmail.net>
	 <1cd1989b0903190701uac4602dl1d2c3cace45a9938@mail.gmail.com>
	 <20090319151610.GO23521@spearce.org>
	 <1cd1989b0903190850p1a08991y754904e7799c7879@mail.gmail.com>
	 <20090319201405.GD17028@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Mar 19 22:42:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkQ0G-00031F-TT
	for gcvg-git-2@gmane.org; Thu, 19 Mar 2009 22:42:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755989AbZCSVkn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 19 Mar 2009 17:40:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755905AbZCSVkn
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Mar 2009 17:40:43 -0400
Received: from yw-out-2324.google.com ([74.125.46.30]:56740 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752250AbZCSVkm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Mar 2009 17:40:42 -0400
Received: by yw-out-2324.google.com with SMTP id 5so717933ywb.1
        for <git@vger.kernel.org>; Thu, 19 Mar 2009 14:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=2nM00BGiC87cPvh/0pB5cRHrB1y1SD0tAwg8eDJnGFE=;
        b=sN07BNCNJnEg0IVaKpnStO+vAWVGX/C3laSON6N4Ipm8OK+fcxoG5NDZxuLBpiUD/S
         5xVL+B8XvZfVUXyE0+nthd141AqHLt7Ioyioa2eB802IZZcFzEjW7n+MmvM/PIlB7lFy
         ya4jRIesHiGNSyD6Jqng18rRxIsSz93ljuVW8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=QUHJOMBv8W1v98zF+rKZ0YaNmIuZjQz1ckZL2j0P2nWO/CAtRnnKIW9W1V55bfXC+c
         TS3w8vCruW9RP7NI8QIfvFq3VodZOoTzxYBD1cClA6Td9WPugtWe5TxmuNidUHNUee/7
         CG9AiXXp7IDFGY6hnwZ3AaNpjRFlwX+6GEZpI=
Received: by 10.231.14.196 with SMTP id h4mr969228iba.15.1237498839261; Thu, 
	19 Mar 2009 14:40:39 -0700 (PDT)
In-Reply-To: <20090319201405.GD17028@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113832>

2009/3/19 Jeff King <peff@peff.net>:
> On Thu, Mar 19, 2009 at 09:50:39AM -0600, Pat Notz wrote:
>
>> On Thu, Mar 19, 2009 at 9:16 AM, Shawn O. Pearce <spearce@spearce.or=
g> wrote:
>> >
>> > Why are people reinventing the reflog, and core.logallrefupdates ?
>> >
>>
>> Hmmm, lack of awareness of core.logallrefupdates in my case. =A0Than=
ks
>> for the pointer.
>
> But do note that reflogs expire eventually, so you will want to also
> look at gc.reflogexpire and gc.reflogexpireunreachable if you want to
> keep this as an activity log forever.

Outside of parsing the reflog directly, (which feels wrong and dirty
to me), how does one find out the times that a reflog entry was
created?

The closest thing i could find was git log -g, but that shows the time
of the commit that was switched to, not the time the reflog entry was
created. I dont see a --format pattern for it, and there doesnt seem
to be a switch to git reflog to do it. (I had initially (before
RTFM'ing) assumed that git reflog -v would show the times, but
apparently not).

If the times were easy to access then it would be much more useful as
a general logging facility.

cheers,
Yves




--=20
perl -Mre=3Ddebug -e "/just|another|perl|hacker/"
