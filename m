From: Thomas Hochstein <thh@inter.net>
Subject: Re: Trouble with file specific merge strategies
Date: Sun, 11 Mar 2012 16:17:52 +0100
Message-ID: <gcvg.1203111617.379@landroval.ancalagon.de>
References: <CAMXnza3SLHWLsFkYLhkJLAwtP2n=QVTXZ__GSL-CvajxC6i0Dw@mail.gmail.com> <7vk42rzfab.fsf@alter.siamese.dyndns.org> <CAMXnza12HVFdmji7k-b-G43NWmobqCQEwXZXB=VxJA=tatqX-g@mail.gmail.com> <7vd38jxu5b.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 11 18:00:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S6m8F-000462-W8
	for gcvg-git-2@plane.gmane.org; Sun, 11 Mar 2012 18:00:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753399Ab2CKRA0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 11 Mar 2012 13:00:26 -0400
Received: from plane.gmane.org ([80.91.229.3]:43405 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753271Ab2CKRA0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Mar 2012 13:00:26 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1S6m85-00041O-Vd
	for git@vger.kernel.org; Sun, 11 Mar 2012 18:00:21 +0100
Received: from p57952cfa.dip.t-dialin.net ([87.149.44.250])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 11 Mar 2012 18:00:21 +0100
Received: from thh by p57952cfa.dip.t-dialin.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 11 Mar 2012 18:00:21 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: p57952cfa.dip.t-dialin.net
User-Agent: ForteAgent/6.00-32.1186  Hamster/2.1.0.11
X-Uptime: 0 day(s), 21 hour(s), 55 minute(s), 8 second(s) [landroval | 66849]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192815>

Junio C Hamano wrote:

> suvayu ali <fatkasuvayu+linux@gmail.com> writes:
>
>> ... is that discussion on progit talking about
>> something else?
>
> Sorry, I do not read or write progit, so I do not know offhand what
> it says in the section you read and I cannot judge if it was you who
> misread, or if it was book that misspoke.

The book says:
> You can also use Git attributes to tell Git to use different merge
> strategies for specific files in your project. One very useful option
> is to tell Git to not try to merge specific files when they have
> conflicts, but rather to use your side of the merge over someone
> else=E2=80=99s.
>
> This is helpful if a branch in your project has diverged or is
> specialized, but you want to be able to merge changes back in from
> it, and you want to ignore certain files. Say you have a database
> settings file called database.xml that is different in two branches,
> and you want to merge in your other branch without messing up the
> database file. You can set up an attribute like this:
>
>| database.xml merge=3Dours
>
> If you merge in the other branch, instead of having merge conflicts
> with the database.xml file, you see something like this:
>
>| $ git merge topic
>| Auto-merging database.xml
>| Merge made by recursive.
>
> In this case, database.xml stays at whatever version you originally h=
ad.

That seems to be incorrect, as far as I understand the gitattributes
man page.

-thh
