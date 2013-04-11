From: Konstantin Khomoutov <flatworm@users.sourceforge.net>
Subject: Re: git send-pack: protocol error: bad band #50
Date: Thu, 11 Apr 2013 13:26:36 +0400
Message-ID: <20130411132636.d8d59a8eadef3c23b99c84fc@domain007.com>
References: <51665D08.3030307@netcabo.pt>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?B?Sm/Do28=?= Joyce <joao.joyce@netcabo.pt>
X-From: git-owner@vger.kernel.org Thu Apr 11 11:26:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQDmO-0007JS-Qh
	for gcvg-git-2@plane.gmane.org; Thu, 11 Apr 2013 11:26:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935494Ab3DKJ0n convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 11 Apr 2013 05:26:43 -0400
Received: from mailhub.007spb.ru ([84.204.203.130]:58212 "EHLO
	mailhub.007spb.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1765335Ab3DKJ0l (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Apr 2013 05:26:41 -0400
Received: from programmer.Domain007.com (programmer.domain007.com [192.168.2.100])
	by mailhub.007spb.ru (8.14.3/8.14.3/Debian-5+lenny1) with SMTP id r3B9QZfX023395;
	Thu, 11 Apr 2013 13:26:37 +0400
In-Reply-To: <51665D08.3030307@netcabo.pt>
X-Mailer: Sylpheed 3.3.0 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220837>

On Thu, 11 Apr 2013 07:49:44 +0100
Jo=C3=A3o Joyce <joao.joyce@netcabo.pt> wrote:

[...]

> but I am getting the following error:
>      git send-pack: protocol error: bad band #50
>      fatal: The remote end hung up unexpectedly
>=20
> It seems that something is failing on the remote side but I can't
> find any reference to this protocol error.

I should add that the OP first asked this question on SO [1] and I
advised him to simply run `git --version` on the remote via SSH to
verify Git is working there, and it worked OK.

Another thing the OP failed to provide is the info on his setup.
To cite his message posted to git-users [2]:

> I am using ubuntu 12.10 in my local machine and 12.04 in the remote
> (which is a VPS hosting). The git version is 1.7.9.5 on both.

Hope this might help tracking down the issue.

1. http://stackoverflow.com/q/15921202/720999
2. https://groups.google.com/forum/?fromgroups=3D#!topic/git-users/eJXA=
SG1GlDA
