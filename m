From: Konstantin Khomoutov <flatworm@users.sourceforge.net>
Subject: Re: running git from non-standard location on Mac
Date: Thu, 21 Feb 2013 14:35:25 +0400
Message-ID: <20130221143525.726f06827351376b59a02f4b@domain007.com>
References: <1CE1BECC0915A6448EAE5D7080EDA905052078C95E@oxexc1>
Mime-Version: 1.0
Content-Type: text/plain; charset=KOI8-R
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: James French <James.French@naturalmotion.com>
X-From: git-owner@vger.kernel.org Thu Feb 21 11:36:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U8TVZ-0002ee-CS
	for gcvg-git-2@plane.gmane.org; Thu, 21 Feb 2013 11:36:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753595Ab3BUKfb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 21 Feb 2013 05:35:31 -0500
Received: from mailhub.007spb.ru ([84.204.203.130]:42114 "EHLO
	mailhub.007spb.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753585Ab3BUKfa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Feb 2013 05:35:30 -0500
Received: from programmer.Domain007.com (programmer.domain007.com [192.168.2.100])
	by mailhub.007spb.ru (8.14.3/8.14.3/Debian-5+lenny1) with SMTP id r1LAZPOK023298;
	Thu, 21 Feb 2013 14:35:26 +0400
In-Reply-To: <1CE1BECC0915A6448EAE5D7080EDA905052078C95E@oxexc1>
X-Mailer: Sylpheed 3.3.0 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216764>

On Thu, 21 Feb 2013 09:48:36 +0000
James French <James.French@naturalmotion.com> wrote:

> I wonder if someone could help me. I installed git on a Mac and then
> I copied the install somewhere else (which I do want to do, trust
> me). =9AI'm now having trouble with git svn. I'm getting "Can't locat=
e
> Git/SVN.pm in @INC..."
>=20
> I've added the bin folder to PATH. What else do I need to do? Do I
> need to use -exec-path=3D/MyPathToGit/libexec/git-core? How do I chan=
ge
> the content of @INC?
>=20
> Apologies if this is a dumb question, I'm not much of a unix man.

`git svn` is implemented in Perl (which is supposedly bundled with your
Git package, but I'm not sure), and "SVN.pm" is a Perl module (a
library written in Perl, ".pm" stands for "Perl Module").

@INC is an internal variable used by Perl to locate its modules.
Its contents is partially inferred from the Perl's installation
location and partially from the environment.

This [1] should help you get started with affecting @INC.

1. http://stackoverflow.com/a/2526809/720999
