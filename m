From: Konstantin Khomoutov <flatworm@users.sourceforge.net>
Subject: Re: Bug report
Date: Fri, 5 Oct 2012 14:32:31 +0400
Message-ID: <20121005143231.788094d675c9974f4777318d@domain007.com>
References: <61FEBCE8-8206-498C-B3D4-ECD6AF192EE0@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=KOI8-R
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?KOI8-R?Q?=ED=D5=CB=CF=D7=CE=C9=CB=CF=D7_=ED=C9=C8=C1=C9=CC?= 
	<m.mukovnikov@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 05 12:32:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TK5D5-0006i1-W0
	for gcvg-git-2@plane.gmane.org; Fri, 05 Oct 2012 12:32:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932110Ab2JEKci convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 5 Oct 2012 06:32:38 -0400
Received: from mailhub.007spb.ru ([84.204.203.130]:34519 "EHLO
	mailhub.007spb.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932067Ab2JEKci (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Oct 2012 06:32:38 -0400
Received: from programmer.Domain007.com (programmer.domain007.com [192.168.2.100])
	by mailhub.007spb.ru (8.14.3/8.14.3/Debian-5+lenny1) with SMTP id q95AWVNl023654;
	Fri, 5 Oct 2012 14:32:32 +0400
In-Reply-To: <61FEBCE8-8206-498C-B3D4-ECD6AF192EE0@gmail.com>
X-Mailer: Sylpheed 3.2.0 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207095>

On Fri, 5 Oct 2012 14:13:49 +0400
=ED=D5=CB=CF=D7=CE=C9=CB=CF=D7 =ED=C9=C8=C1=C9=CC <m.mukovnikov@gmail.c=
om> wrote:

> There's a problem using git with files having cyrillic '=CA' in their
> name, git just can't track them.
>=20
> uname: Darwin 12.2.0 Darwin Kernel Version 12.2.0: Sat Aug 25
> 00:48:52 PDT 2012; root:xnu-2050.18.24~1/RELEASE_X86_64 x86_64 git
> version: 1.7.12.1 (from macports)
>=20
> Steps to reproduce:
> - git init
> - touch test_=CA
> - git status (should be "untracked files present")
> - git add test_=CA
> - git status
>=20
> # Untracked files:
> #   (use "git add <file>..." to include in what will be committed)
> #
> #	"test_\320\270\314\206"
> nothing added to commit but untracked files present (use "git add" to
> track)
>=20
> Could this be helped somehow?--

What "this"?  If you mean displaying escapes for UTF-8 bytes
representing that letter "=CA", then try setting core.quotepath to fals=
e
for this repository and see if that helps.

More info can be found in the git-config manual page.
