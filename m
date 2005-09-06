From: =?iso-8859-1?Q?David_K=E5gedal?= <davidk@lysator.liu.se>
Subject: Re: Tool renames? was Re: First stab at glossary
Date: Tue, 06 Sep 2005 10:57:04 +0200
Message-ID: <u5tek82bmlb.fsf@fidgit.hq.vtech>
References: <200509050054.j850sC3D023778@laptop11.inf.utfsm.cl>
	<Pine.LNX.4.58.0509050738340.3504@evo.osdl.org>
	<46a038f90509051713389c62c8@mail.gmail.com>
	<Pine.LNX.4.58.0509060013520.4316@evo.osdl.org>
	<7vll2atz8a.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0509060057491.4316@evo.osdl.org>
	<7vwtlusi9t.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Tue Sep 06 11:02:00 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ECZJp-0002kd-Fl
	for gcvg-git@gmane.org; Tue, 06 Sep 2005 11:00:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932449AbVIFJAS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 6 Sep 2005 05:00:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932450AbVIFJAS
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Sep 2005 05:00:18 -0400
Received: from main.gmane.org ([80.91.229.2]:2518 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932449AbVIFJAQ (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 Sep 2005 05:00:16 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1ECZHm-0002EB-BL
	for git@vger.kernel.org; Tue, 06 Sep 2005 10:58:34 +0200
Received: from dns.vtab.com ([62.20.90.195])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 06 Sep 2005 10:58:34 +0200
Received: from davidk by dns.vtab.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 06 Sep 2005 10:58:34 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: dns.vtab.com
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Cancel-Lock: sha1:HrGDHrLpXsxk3ZR3VJvIWF3+tn0=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8128>

Junio C Hamano <junkio@cox.net> writes:

> Linus Torvalds <torvalds@osdl.org> writes:
>
>> What's the upside?
>>
>> I can point to one downside: "git". That script right now is simple.=
 If=20
>> you rewrite git-cvsimport-script from shell to perl, it looks the sa=
me to=20
>> git.=20
>
> What I've been working on was to:
>
>  * have git-cvsimport.perl in the source
>
>  * install it as $(bindir)/git-cvsimport

That was what I suggested too, although I don't really care if it's
called .perl or -script in the source.

By the way, I'm not sure how the 'git' script is supposed to be used.
I know that if there is a git-foo-script file in your path, you can
run it as 'git foo'.  But what about e.g. git-init-db?  You can run
that as 'git init-db' today.  And 'git read-cache' should work too.
And 'git ls-files', and 'git rev-parse', and 'git merge-one-file' and
'git sh-setup-script' in decreasing order of usefulness...

But running 'git' without arguments only list the -script commands as
available.

--=20
David K=E5gedal
