From: =?UTF-8?Q?J=C3=B6rg?= Sommer <joerg@alea.gnuu.de>
Subject: Re: [BUG] --pretty=format does not work ok with rev-list
Date: Fri, 25 Apr 2008 09:14:01 +0000 (UTC)
Message-ID: <slrng1386p.ujv.joerg@alea.gnuu.de>
References: <1208032825.30817.15.camel@k0001>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 25 11:48:37 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JpKXb-0005VX-Oo
	for gcvg-git-2@gmane.org; Fri, 25 Apr 2008 11:48:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758911AbYDYJrh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 25 Apr 2008 05:47:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758692AbYDYJrh
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Apr 2008 05:47:37 -0400
Received: from banki.eumelnet.de ([83.246.114.63]:2484 "EHLO uucp.gnuu.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754740AbYDYJrg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Apr 2008 05:47:36 -0400
Received: by uucp.gnuu.de (Postfix, from userid 10)
	id 0210BEC056; Fri, 25 Apr 2008 11:47:34 +0200 (CEST)
Received: from news by alea.gnuu.de with local (Exim 4.63)
	(envelope-from <news@alea.gnuu.de>)
	id 1JpK0I-0004ga-4H
	for git@vger.kernel.org; Fri, 25 Apr 2008 11:14:02 +0200
Path: not-for-mail
Newsgroups: local.mailinglist.git
X-Trace: alea.gnuu.de 1209114841 18014 192.168.0.5 (25 Apr 2008 09:14:01 GMT)
X-Complaints-To: usenet@alea.gnuu.de
User-Agent: slrn/pre0.9.9-102 (Debian)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80333>

Hi,

k0001 <gnuk0001@gmail.com> wrote:
> Now back to business, when using --pretty=3Dformat:some_format with g=
it
> rev-list, an additional non-requested line is printed before every
> commit ("commit <sha1_id>"). Example:
>
> git rev-list output (BAD):
>
> k@k0001 ~/linux-2.6 $ git rev-list -2 --pretty=3Dformat:"%H: %cn" mas=
ter
> commit f4be31ec9690cfe6e94fcbed6ae60a6a38b3c3ed
> f4be31ec9690cfe6e94fcbed6ae60a6a38b3c3ed: Linus Torvalds
> commit 44cad261025c04327fd7e847a7088fd3031b0c3e
> 44cad261025c04327fd7e847a7088fd3031b0c3e: Linus Torvalds

Is this a bug? I've the same =E2=80=9Cproblem=E2=80=9D in my rebase wit=
h merge patch
series and added a =E2=80=9C|grep -v ^commit=E2=80=9D. But if this is a=
 bug, I can remove
it.

Sch=C3=B6ne Gr=C3=BC=C3=9Fe, J=C3=B6rg.
--=20
Viele Leute glauben, dass sie denken, wenn sie lediglich
ihre Vorurteile neu ordnen.
