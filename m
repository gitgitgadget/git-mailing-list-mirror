From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git-svn: Remove unused use of File::Temp
Date: Sun, 9 May 2010 01:31:37 -0700
Message-ID: <20100509083137.GA12627@dcvr.yhbt.net>
References: <1273336841-31461-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 09 10:32:09 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OB1vj-0005dw-FE
	for gcvg-git-2@lo.gmane.org; Sun, 09 May 2010 10:32:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751889Ab0EIIbj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 9 May 2010 04:31:39 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:59505 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751748Ab0EIIbi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 May 2010 04:31:38 -0400
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id ABCE01F449;
	Sun,  9 May 2010 08:31:37 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1273336841-31461-1-git-send-email-avarab@gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146711>

=C6var Arnfj=F6r=F0 Bjarmason <avarab@gmail.com> wrote:
> The use line was added in ffe256f9. File::Temp calls were later moved
> to Git.pm in 0b19138b, but that commit neglected to remove the
> now-redundant import.
>=20
> Signed-off-by: =C6var Arnfj=F6r=F0 Bjarmason <avarab@gmail.com>

Thanks,

Acked-by: Eric Wong <normalperson@yhbt.net>

=2E..and pushed out to git://git.bogomips.org/git-svn along with a few
others:

Jonathan Nieder (1):
      git svn: avoid uninitialized var in 'reset'

Torsten Schmutzler (1):
      git-svn: mangle refnames forbidden in git

=C6var Arnfj=F6r=F0 Bjarmason (2):
      git-svn documentation: minor grammar fix
      git-svn: Remove unused use of File::Temp

--=20
Eric Wong
