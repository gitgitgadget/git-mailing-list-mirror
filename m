From: David Kastrup <dak@gnu.org>
Subject: Re: git: cannot rename foo to Foo on a case-insensitive filesystem (e.g. on Windows)
Date: Wed, 29 Aug 2007 11:43:07 +0200
Message-ID: <864piillqs.fsf@lola.quinscape.zz>
References: <3f4fd2640708280117k3f1cd03el676a87084a83480f@mail.gmail.com> <46D3ED4E.6030606@op5.se> <82tzqjgbx0.fsf@mid.bfk.de> <5A2EFA05-7A86-440B-B027-6360DA04CD89@wincent.com> <46D42C07.50001@op5.se> <54CFD615-6E05-42AC-A0D7-063B146295B8@wincent.com> <Pine.LNX.4.64.0708282144250.28586@racer.site> <301B4A5B-1765-426E-B72C-F6248894A3E0@wincent.com> <Pine.LNX.4.64.0708290321530.28586@racer.site> <1BA15C6C-1F37-401B-B8D8-4BD147CF5225@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 29 11:44:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IQK5X-0007Pf-Ts
	for gcvg-git@gmane.org; Wed, 29 Aug 2007 11:43:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754732AbXH2JnW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 29 Aug 2007 05:43:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754334AbXH2JnW
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Aug 2007 05:43:22 -0400
Received: from main.gmane.org ([80.91.229.2]:50259 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753081AbXH2JnV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Aug 2007 05:43:21 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IQK4z-0007dx-NQ
	for git@vger.kernel.org; Wed, 29 Aug 2007 11:43:17 +0200
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 29 Aug 2007 11:43:17 +0200
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 29 Aug 2007 11:43:17 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
Cancel-Lock: sha1:+om2wPFWlTQLTD6YEljyapuuSqw=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56919>

Wincent Colaiuta <win@wincent.com> writes:

> El 29/8/2007, a las 4:23, Johannes Schindelin escribi=F3:
>
>> On Wed, 29 Aug 2007, Wincent Colaiuta wrote:
>>
>> But it does not change the _meaning_ of Andreas' criticism.  They
>> took a perfectly sane system, and turned it into a mess.
>
> While I agree that most just accept the default, your argument here
> and in your previous email is spurious; it amounts to saying "A and
> B is offered, but because A is the default it is the same as if B
> were not supported at all", which isn't valid logic. If you limited
> your argument to criticizing case-insensitive filesystems then I
> would have to agree with you; I am not a fan of them. Likewise, if
> you said that the default has undesirable consequences I would also
> concur.  It's your attempt to extend your claim to an argument for
> equivalence that I can't buy.

Read up on his posting history.

>> Plenty of people have this setup
>
> Agreed...
>
>> and we have to suffer.
>
> but, don't you think you're exaggerating a bit here? How much
> "suffering" has this really caused you? I gather that you're not
> even a user of that operating system;

He is the main worker on the MSYS port of git as far as I can tell,
while not using Windows as his work platform.  So indeed he gets to
bear _all_ the pain, and no personal gain.  Since I have provided for
Windows/MSYS compatibility in AUCTeX's _installation_ procedure (a
small part of the project which is mostly operating system agnostic),
a much smaller stuff under similar circumstances, I can vouch for the
amount of hassle such a seemingly "everything we need should be there
in principle" Windows accommodation task causes.

And I actually find it extremely distasteful how little involvement in
this project is there from genuine Windows users: most restrict
themselves to complaining.

So at least on this account, I think you are not doing him justice.

> I am (have been since the first developer previews), have always
> accepted the default filesystem choice, don't even like the
> filesystem (have ranted repeatedly about its flakiness on my
> weblog), but I think I've run into case- insensitivity issues two
> times. If you want to talk about "suffering" then ask me about HFS+
> data integrity.

--=20
David Kastrup
