From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Request for detailed documentation of git pack protocol
Date: Thu, 14 May 2009 17:01:40 +0200
Message-ID: <200905141701.41212.jnareb@gmail.com>
References: <200905122329.15379.jnareb@gmail.com> <20090512233450.GY30527@spearce.org> <d411cc4a0905140655y244f21aem44f1e246dd74d80c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Scott Chacon <schacon@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 14 18:21:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4dgH-0008Bh-RN
	for gcvg-git-2@gmane.org; Thu, 14 May 2009 18:21:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752468AbZENQUY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 14 May 2009 12:20:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760760AbZENQUW
	(ORCPT <rfc822;git-outgoing>); Thu, 14 May 2009 12:20:22 -0400
Received: from fg-out-1718.google.com ([72.14.220.153]:6058 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760503AbZENQUT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 May 2009 12:20:19 -0400
Received: by fg-out-1718.google.com with SMTP id 16so486753fgg.17
        for <git@vger.kernel.org>; Thu, 14 May 2009 09:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=NGxwr2Rv9HdCUd1waFu9UQjgr7BM23m1HuHG5fzNNSU=;
        b=PzKluKaS/aGQsawYZopS/jqGdnjSlylzXvianXnF++g2E8gxwyfQWJXmPpkMr5unzF
         2vjZPf3Q7eNm3t7cJacpyKbzmtOAnqjff5xkWdulupTH7J2ncA9JKTRFQdVdDrSvQZtD
         9hWAcixm6nAhff5Bei8A1EUSHCbPvzy2TsAgc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=PlmamCaES9Kja6pixE8TQIBM9Eky5RrfGKZBsv3Qr7w9hFeV+N0kPoY+2B4p7uDF8v
         BOL7Wznl4NByx84KWkzwb9prhS9L7Ax4AYIoQn39j7wcRZuNEMANmFhwdOuhFe0M9Qcc
         1QNA0uEdbsJ474E7DK2KXrxr6YsGD1iWJWdlw=
Received: by 10.86.26.11 with SMTP id 11mr2677143fgz.45.1242318018968;
        Thu, 14 May 2009 09:20:18 -0700 (PDT)
Received: from ?192.168.1.13? (abvo12.neoplus.adsl.tpnet.pl [83.8.212.12])
        by mx.google.com with ESMTPS id l19sm5743705fgb.2.2009.05.14.09.20.17
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 14 May 2009 09:20:17 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <d411cc4a0905140655y244f21aem44f1e246dd74d80c@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119204>

On Thu, 14 May 2009, Scott Chacon wrote:
> On Tue, May 12, 2009 at 4:34 PM, Shawn O. Pearce <spearce@spearce.org=
> wrote:
>> Jakub Narebski <jnareb@gmail.com> wrote:

>>> We have now proliferation of different (re)implementations of git:
>>> JGit in Java, Dulwich in Python, Grit in Ruby; and there are other
>>> planned: git# / managed git in C# (GSoC Mono project), ObjectiveGit
>>> in Objective-C (for iPhone IIRC). =C2=A0At some time they would rea=
ch
>>> the point (or reached it already) of implementing git-daemon...
>>> but currently the documentation of git protocol is lacking.
>>
>> Well, lets see...

[...]
>> ObjectGit - Scott Chacon, again, a GitHub folk. =C2=A0Though he has
>> expressed interest in moving to JGit or libgit2 where/when possible.
>=20
> Actually, all of this work has moved to CocoaGit, which is much
> farther along than ObjectiveGit ever was.  Although I would love to
> use libgit2 when it gets that far, this was for Mac/iPhone native
> client work which JGit would not be helpful for.

Could you give URL for homepage or announcement (if it exists), and
for git repository / web interface page for CocoaGit? It isn't present
on http://git.or.cz/gitwiki/InterfacesFrontendsAndTools which tries
to be clearinghouse and list all significant git tools... but which
is probably hopelessly out of date now (unfortunately).

>=20
>>
>> Dulwich - off in its own world and not even trying to match basic
>> protocol rules by just watching what happens when you telnet to a
>> git port. =C2=A0No clue how that's going to fair.
>=20
> Oddly enough, I'm in Dulwich land too. I've been working on a
> Mercurial plugin that will provide a two way lossless bridge for Hg t=
o
> be able to push and pull to/from a Git server.

I'm assuming here that the bridge has to remember somehow about the
info which cannot be represented in other SCM (like octopus merges,
or tag objects, or tagging non-commits in Git; like I guess 'rename
tracking' information in Mercurial) to be it truly two-way...

> I've fixed some of the=20
> issues I've found with the client side work and both pushes and pulls
> will work now. (I did turn off 'thin-pack' capability announcement,
> since you're correct that it simply was not properly implemented).
>=20
> If we're going to round out the list, I've also worked on an
> ActionScript partial implementation, but it never got to the packfile
> level, and some of the Erlang guys are interested in writing at least
> a partial Erlang implementation too, which I may get involved in at
> some point.

Well, with yet another implementation it is even more important to have
good technical documentation of file formats and network protocols.

BTW. if I remember correctly there were some hobbyist one-person=20
(single-developer) implementations of git in Haskell and in Lisp
or Scheme...

>=20
> It seems like if anyone would do what you're asking, it's probably me=
=2E
> In the next few weeks, I do what I can to fix up the remainder of the
> Dulwich code as part of my hg-git work.  I'm also working with Shawn
> on the Apress book, where I was going to try to document much of this
> information, perhaps I could try writing an RFC as an appendix or
> something - then that will force him to spend time correcting
> everything I got wrong :)  At least that might be a good starting
> point - I'm unfamiliar with the actual RFC process, so I'll research
> that a bit today.  I don't mind writing it, I think it would be reall=
y
> really useful to have, I just am unfamiliar with the process.

I don't think RFC _process_ is something to worry about; in the future
perhaps (just like Atom Publishing protocol was submitted to IETF).
I was thinking about _format_ used in RFC (BNF-like specification,
specific semantic for 'MUST' etc. like in RFC2119). Although any format
(more or less formal) would be better that none.

Thank you very much for your offer!

--=20
Jakub Narebski
Poland
