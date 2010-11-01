From: Brad Larson <bklarson@gmail.com>
Subject: Re: gittogether session notes
Date: Mon, 1 Nov 2010 15:36:39 -0500
Message-ID: <AANLkTim4g1=D9jqsiAavpR7_-1p2zFK5KjVD_Tabv0Tp@mail.gmail.com>
References: <20101029180530.GA18997@sigill.intra.peff.net> <m3ocachkcy.fsf@localhost.localdomain>
 <20101101202643.GA6119@sigill.intra.peff.net> <20101101203241.GB22725@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Jakub Narebski <jnareb@gmail.com>,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Nov 01 21:37:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PD17s-0005DI-GO
	for gcvg-git-2@lo.gmane.org; Mon, 01 Nov 2010 21:37:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751866Ab0KAUhC convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 1 Nov 2010 16:37:02 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:65302 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751355Ab0KAUhB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 1 Nov 2010 16:37:01 -0400
Received: by bwz11 with SMTP id 11so4894063bwz.19
        for <git@vger.kernel.org>; Mon, 01 Nov 2010 13:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=T88Qez/eqd7JgVVN0DaL3eVHoyeJMRjC0oL0OWyNHUk=;
        b=RIu5ERiNnFEKUYunSd7fXy7TmAdaczlY4R87MqFSB3e9vo0h0Wip59BbdENzzEdqPY
         1N4niym7ran8x55JzsXZFB41dm1ytoq7FtT/BRykSViM7UdzjM1LJ9L0Rmef8ZeKOjiv
         nSpb/CX3hxZB1hKgasgsKQJtzZjgTWkHCTRhA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=AtGd8g4Eo9kSLqki/If+3cW9dv571xUONiA6ashazqRZ0LEjLkz0mdN/YYTp0Q28OR
         rY+Hffhwhx3x3tyKhC1gg5u3MwHsAmDgLTToujuViAZ5Anrge9EG4JfuuWhLiNVebWZn
         fbIoHen2EUbKTS60ITXSxdw4DTAg4D9tLkD5A=
Received: by 10.204.57.10 with SMTP id a10mr3522266bkh.66.1288643819927; Mon,
 01 Nov 2010 13:36:59 -0700 (PDT)
Received: by 10.204.75.72 with HTTP; Mon, 1 Nov 2010 13:36:39 -0700 (PDT)
In-Reply-To: <20101101203241.GB22725@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160496>

On Mon, Nov 1, 2010 at 3:32 PM, Shawn O. Pearce <spearce@spearce.org> w=
rote:
> Jeff King <peff@peff.net> wrote:
>> On Fri, Oct 29, 2010 at 12:26:15PM -0700, Jakub Narebski wrote:
>>
>> > Below there are proposed talks which either weren't presented, or =
lack
>> > notes / slides.
>> > * Hudson and Gerrit integration
>>
>> Brad Larson talked about Hudson, and had slides. I don't seem to hav=
e an
>> email address for him, though.
>
> Brad, can you post your Hudson slides on the wiki?

I didn't have slides, just a live demo of Hudson running on my box
doing build tests of tools/gerrit from android.git.kernel.org.  I'll
take some screen shots and throw them into a presentation for
historical reference.  Should I email that to someone or ...?

Brad


>
>> > * What's new on github: pull requests, git based wiki etc.
>
> Tom talked about this, but there weren't any slides. =A0He just
> presented the web site and described what he was showing.
>
>> > * Git and Big Files
>
> John Hawley and I talked about this a bit, it probably makes sense
> to take Avery's bup work and start to formalize it within core Git.
> But yea, we didn't ever get around to debating the merits of a new
> "sequence" object type vs. defining a new variant of the current
> tree mode and reusing the current tree walking support to link in
> the segments of the huge file.
>
> I think it really depends on what older versions of Git will
> do. =A0If older Git versions would accept a different tree mode
> (e.g. '040001') and treat them as normal trees, we could at least
> use older Git servers for push/pull/fsck/gc without breaking the
> repository. =A0But doing a checkout would produce a directory of
> segments, and updating a segment would break the directory mode.
> But I suspect older gits will choke on that tree mode.
>
>> > * git log -L demo, combination of log and blame
>>
>> Thomas did this, but it was mostly just showing off "-L".
>
> And this is pretty cool too. =A0I was pretty impressed by the flag.
>
>> > * RefInsteadOf (discussion)
>
> RefInsteadOf turned out to be a non-discussion. =A0I asked the SEMC
> guys what they wanted... and it turns out its already handled
> somewhere else and they didn't realize it. =A0They just needed to
> use the fetch refspec in .git/config correctly. =A0:-)
>
>> > * git-always-on
>
> This was the Qualcomm guys presenting how they use DRBD to keep
> git in sync on multiple machines and implement quick fail-over when
> there is a problem with the primary.
>
> --
> Shawn.
>
