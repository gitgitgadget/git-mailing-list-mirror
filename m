From: Gelonida <gelonida@gmail.com>
Subject: Re: simple example for git hooks
Date: Fri, 03 Sep 2010 00:54:44 +0200
Message-ID: <i5p9vl$tk$1@dough.gmane.org>
References: <i5p96s$u7q$1@dough.gmane.org> <AANLkTimEo=sV=bKHyuQ5Md_7uQ0jAFKx+=dv4+KK+oD7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 03 00:55:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OrIgY-00071O-I2
	for gcvg-git-2@lo.gmane.org; Fri, 03 Sep 2010 00:55:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753371Ab0IBWzD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 2 Sep 2010 18:55:03 -0400
Received: from lo.gmane.org ([80.91.229.12]:42405 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751217Ab0IBWzB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Sep 2010 18:55:01 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1OrIgJ-0006l2-RT
	for git@vger.kernel.org; Fri, 03 Sep 2010 00:54:55 +0200
Received: from unicorn.dungeon.de ([81.56.82.123])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 03 Sep 2010 00:54:55 +0200
Received: from gelonida by unicorn.dungeon.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 03 Sep 2010 00:54:55 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: unicorn.dungeon.de
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.11) Gecko/20100713 ""
In-Reply-To: <AANLkTimEo=sV=bKHyuQ5Md_7uQ0jAFKx+=dv4+KK+oD7@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155220>

Him
THanks a lot for your answer.

On 09/03/2010 12:49 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> On Thu, Sep 2, 2010 at 22:41, Gelonida <gelonida@gmail.com> wrote:
>=20
>> Is there any clear documentation about hich git commands I'm allowed=
 to
>> use during a trigger script and which ones I can't
>=20
> It's just a program that's run at a certain point, and its exit statu=
s
> determines if git proceeds.
>=20
> So you can use any git command, but of course what you might affect
> what's about to be commited.
>=20
> For a pre-commit hook (IIRC) you should find the stuff to be commited
> in the index, finding a list of things that changed from a hook is
> just a matter of diffing HEAD against the contents of the index then.

ok, so it seems what I'm missing is THE command to list all added /
modified files
I could of course use

git status

and parse its output, but this is probably not the right way to do.

I use git for quite some time, but don't know many commands except
clone/pull/commit/reset/status/pull/push/cherrypick/rebase/tag/remote

thanks a lot for the typical way to identify added / modified files
and for fetching the commit comment
