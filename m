From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git bug/feature request
Date: Tue, 27 Nov 2007 12:51:41 +0100
Organization: At home
Message-ID: <fih0cd$d31$1@ger.gmane.org>
References: <200711271127.41161.gapon007@gmail.com> <7A14A564-C424-4ACC-A860-A11DCC38C9A1@lrde.epita.fr> <200711271216.25283.gapon007@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 27 12:52:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IwyzD-0006cT-B5
	for gcvg-git-2@gmane.org; Tue, 27 Nov 2007 12:52:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753656AbXK0LwB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 27 Nov 2007 06:52:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753436AbXK0LwA
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Nov 2007 06:52:00 -0500
Received: from main.gmane.org ([80.91.229.2]:54343 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751961AbXK0LwA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2007 06:52:00 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Iwyym-0006w8-Gv
	for git@vger.kernel.org; Tue, 27 Nov 2007 11:51:52 +0000
Received: from abvx183.neoplus.adsl.tpnet.pl ([83.8.221.183])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 27 Nov 2007 11:51:52 +0000
Received: from jnareb by abvx183.neoplus.adsl.tpnet.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 27 Nov 2007 11:51:52 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: abvx183.neoplus.adsl.tpnet.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66196>

[Cc: git@vger.kernel.org, gapon <gapon007@gmail.com>,=20
 Benoit Sigoure <tsuna@lrde.epita.fr>]

Could you _please_ do not toppost?

gapon wrote:

> Dne =FAter=FD 27 listopadu 2007 Benoit Sigoure napsal(a):
>> On Nov 27, 2007, at 11:27 AM, gapon wrote:
>> > * yes, i know that this scenario is "incorrect" but... it's
>> > possible and
>> > therefore i think it should be somehow handled - i tried a similar
>> > one with
>> > hg and bzr and i like their behaviour more
>>
>> Would you mind describing the behavior of hg and bzr in this case?
[...]
>
> bzr:
> while pushing, bzr tries to merge into the current working copy (of A=
)
> -> all changes are applied or conflicts occure

That's wrong, wrong, WRONG! What to do in the case of conflicts?
Whan you pull, you can resolve them, as they are on your local side,
but when you push you cannot do that.

> hg:
> while pushing, neither merge nor info message, but new head (branch) =
is=20
> created in repo A - so then in A you can commit your changes but it's=
=20
> different head (repo A has more heads, use hg heads to list them)
> btw i filed and enhancement for hg, to let user know that there are m=
ore heads=20
> in the repo (you have to use hg log or hg heads to discover that some=
one else=20
> has pushed into your repo and hg merge to merge them)=20

That is also wrong: how do you decide name of new branch then, and
woundn't this lead to proliferation of branches?

You can do the same with git, but you have to specify new branch name
in repo A, or just configure remote in repo B.

BTW. how do you want for user A (which might be not at terminal, or mig=
ht
be not logged in, or might use some application using terminal, or migh=
t
use multiple [virtual] terminals, or...) to be informed?

--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
