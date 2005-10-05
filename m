From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: First cut at git port to Cygwin
Date: Wed, 5 Oct 2005 15:58:22 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0510051556320.14244@wbgn013.biozentrum.uni-wuerzburg.de>
References: <433B3B10.5050407@zytor.com> <20051005131631.GA9442@diku.dk>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1148973799-1150003570-1128520702=:14244"
Cc: "H. Peter Anvin" <hpa@zytor.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Oct 05 16:00:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EN9mt-0004bb-I5
	for gcvg-git@gmane.org; Wed, 05 Oct 2005 15:58:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932624AbVJEN6Z (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Oct 2005 09:58:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932229AbVJEN6Z
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Oct 2005 09:58:25 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:45979 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S932624AbVJEN6Y (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Oct 2005 09:58:24 -0400
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 7663913EB1E; Wed,  5 Oct 2005 15:58:23 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 5A5C79DBA9; Wed,  5 Oct 2005 15:58:23 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 45EE99A70C; Wed,  5 Oct 2005 15:58:23 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id BCC8313EB1E; Wed,  5 Oct 2005 15:58:22 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Jonas Fonseca <fonseca@diku.dk>
In-Reply-To: <20051005131631.GA9442@diku.dk>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9708>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1148973799-1150003570-1128520702=:14244
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, 5 Oct 2005, Jonas Fonseca wrote:

>   user@machine /usr/local/dev/git/git
>   $ git-log
>   fatal: Not a git repository
>=20
>   user@machine /usr/local/dev/git/git
>   $ GIT_DIR=3D.git git-log | wc -l
>   26094

That could have its cause in your .git/HEAD being no symlink. That happen=
s=20
when rsync=B4ing the .git directory.

The other errors could also stem from the fact that quite a few places=20
expect HEAD to be a symlink.

Ciao,
Dscho

---1148973799-1150003570-1128520702=:14244--
