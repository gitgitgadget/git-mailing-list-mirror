From: cmn@elego.de (Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto)
Subject: Re: libgit2 status
Date: Sun, 26 Aug 2012 00:32:35 +0200
Message-ID: <87y5l2eh6k.fsf@centaur.cmartin.tk>
References: <87a9xkqtfg.fsf@waller.obbligato.org> <5038A148.4020003@op5.se>
	<CAFFjANSDyREbNH1qRgYRPw1C87+D=Ft+ZirLvNihkj3UxF-=Eg@mail.gmail.com>
	<20120825214614.GA8697@vidovic>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Vicent Marti <vicent@github.com>, Andreas Ericsson <ae@op5.se>,
	greened@obbligato.org, git@vger.kernel.org
To: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
X-From: git-owner@vger.kernel.org Sun Aug 26 00:33:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T5Oup-00056c-4b
	for gcvg-git-2@plane.gmane.org; Sun, 26 Aug 2012 00:33:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752803Ab2HYWce (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Aug 2012 18:32:34 -0400
Received: from hessy.cmartin.tk ([78.47.67.53]:52435 "EHLO hessy.dwim.me"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1752318Ab2HYWcd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Aug 2012 18:32:33 -0400
Received: from cmartin.tk (p4FC5D726.dip.t-dialin.net [79.197.215.38])
	by hessy.dwim.me (Postfix) with ESMTPA id E32D4801E9;
	Sun, 26 Aug 2012 00:32:31 +0200 (CEST)
Received: (nullmailer pid 18417 invoked by uid 1000);
	Sat, 25 Aug 2012 22:32:35 -0000
In-Reply-To: <20120825214614.GA8697@vidovic> (Nicolas Sebrecht's message of
	"Sat, 25 Aug 2012 23:46:15 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204289>

Nicolas Sebrecht <nicolas.s.dev@gmx.fr> writes:

> The 25/08/12, Vicent Marti wrote:
>
>> The development of libgit2 happens 100% in the open. I don't know what
>> "commercial entity" are you talking about, but there are several
>> companies and independent contributors working on the Library at the
>> moment.
>
> Right but as far as I'm aware of Junio had reserves about libgit2
> integration into git due to issues making repositories broken. Though,

The comment I saw about that was that at one point libgit2 had produced
broken trees; which is true, the algorithm for the almost-alphanumeric
sorting was slightly broken. This was fixed quite some time ago, which
he also mentioned in the same message.

> [ I'm somewhat in the same situation of OP. ]

If you wait for it to be perfect, it's never going to happen. If your
application would benefit, port it to libgit2 and report the issues you
find. That's the only way we can know of the odd edge cases and
improvements that we should make.

Note that the GitHub apps for Mac and Windows both use the Library to
perform parts of their job. Their new backend for the website is also
(going to be) based on libgit2.

I am also working on a project for a client involving the Library for
importing data and the only problem we've had is that we discovered an
edge case regarding symlinks and an assumption that one of the bindings
made wrt diffs, which is getting fixed.

   cmn
