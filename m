From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: fatal: ambiguous argument 'HEAD^': unknown revision or path
	not in the working tree.
Date: Thu, 28 Oct 2010 15:41:41 +0200
Message-ID: <20101028134141.GA16149@neumann>
References: <loom.20101028T150254-457@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Todd Wells <ttopwells@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 28 15:57:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBSyf-0006Lw-Tl
	for gcvg-git-2@lo.gmane.org; Thu, 28 Oct 2010 15:57:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933444Ab0J1N5F convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 28 Oct 2010 09:57:05 -0400
Received: from francis.fzi.de ([141.21.7.5]:55095 "EHLO exchange.fzi.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S933180Ab0J1N47 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Oct 2010 09:56:59 -0400
X-Greylist: delayed 912 seconds by postgrey-1.27 at vger.kernel.org; Thu, 28 Oct 2010 09:56:57 EDT
Received: from localhost6.localdomain6 ([141.21.4.196]) by exchange.fzi.de over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
	 Thu, 28 Oct 2010 15:41:42 +0200
Content-Disposition: inline
In-Reply-To: <loom.20101028T150254-457@post.gmane.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-OriginalArrivalTime: 28 Oct 2010 13:41:42.0380 (UTC) FILETIME=[DADD2AC0:01CB76A5]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160178>

Hi Todd,

On Thu, Oct 28, 2010 at 01:09:08PM +0000, Todd Wells wrote:
> I was using GitX to prepare a commit. Something happened -- I don't=20
> know what --  and suddenly my branch only had a single commit=20
> in it that appears to contain all  the files in my tree. So I went to=
 the=20
> command line and did this:
>=20
> $ git reset --soft HEAD^=20
> fatal: ambiguous argument 'HEAD^': unknown revision or path not=20
> in the working tree.
>=20
> When I do 'git log' in this branch, there's only one commit. Now, I=20
> had many commits in this branch a few minutes ago. I really,=20
> really, don't want to lose this.
>=20
> What steps should I take to attempt to recover?

Take a look at 'gitk yourbranch@{1}' or 'git log yourbranch@{1}'.  If
it looks like your branch's lost history, then you can recover from
this situation with 'git reset --hard yourbranch@{1}'.

You can read up about the details here:
http://www.kernel.org/pub/software/scm/git/docs/user-manual.html#recove=
ring-lost-changes

HtH,
G=E1bor
