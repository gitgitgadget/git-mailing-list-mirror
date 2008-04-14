From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: StGit: kha/{stable,safe,experimental} updated
Date: Mon, 14 Apr 2008 09:03:48 +0200
Message-ID: <20080414070348.GA9135@diana.vm.bytemark.co.uk>
References: <20080413191140.GA1912@diana.vm.bytemark.co.uk> <2008-04-14-08-44-30+trackit+sam@rfc1149.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Catalin Marinas <catalin.marinas@gmail.com>, git@vger.kernel.org
To: Samuel Tardieu <sam@rfc1149.net>
X-From: git-owner@vger.kernel.org Mon Apr 14 09:04:57 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JlIkJ-0007gB-HN
	for gcvg-git-2@gmane.org; Mon, 14 Apr 2008 09:04:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755439AbYDNHEL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 Apr 2008 03:04:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755103AbYDNHEK
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Apr 2008 03:04:10 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4469 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753500AbYDNHEJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Apr 2008 03:04:09 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1JlIjF-0002XW-00; Mon, 14 Apr 2008 08:03:49 +0100
Content-Disposition: inline
In-Reply-To: <2008-04-14-08-44-30+trackit+sam@rfc1149.net>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79474>

On 2008-04-14 08:44:29 +0200, Samuel Tardieu wrote:

> I was using the StGit in Debian/unstable and just switched to your
> experimental branch.
>
> When doing "stg pull", I get, at the end:
>
> Pushing patch "pr20822" ... done
> Pushing patch "pr22387" ... done
> Pushing patch "pr30614" ... done
> Error: Unhandled exception:
> Traceback (most recent call last):
>   File "/usr/local/lib/python2.4/site-packages/stgit/main.py", line
>   280, in main
>     ret =3D command.func(parser, options, args)
>   File
>   "/usr/local/lib/python2.4/site-packages/stgit/commands/pull.py",
>   line 109, in func
>     log.log_entry(log.default_stack(), 'stg pull')
>   File "/usr/local/lib/python2.4/site-packages/stgit/lib/log.py", lin=
e
>   45, in log_entry
>     stack.repository.refs.get(ref))]
>   File "/usr/local/lib/python2.4/site-packages/stgit/lib/log.py", lin=
e
>   94, in __init__
>     self.unapplied, patches =3D pl('unapplied')
>   File "/usr/local/lib/python2.4/site-packages/stgit/lib/log.py", lin=
e
>   89, in pl
>     return ([pn for sha1, pn in patches],
> ValueError: need more than 0 values to unpack

Euh! Thanks for the report, I'll look into it tonight after work.

> Note that I have no unapplied patch in case it matters, only hidden
> ones (and applied ones of course).

Yeah, that might be a clue. Though I was under the impression that I'd
tested it with a fully applied stack ... I guess the test suite needs
an addition or two.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
