From: David Tran <unsignedzero@gmail.com>
Subject: Re: [PATCH 1/8] Import =?utf-8?b?JExTX0NPTE9SUw==?= parsing code from coreutils
Date: Thu, 20 Mar 2014 19:09:16 +0000 (UTC)
Message-ID: <loom.20140320T200517-726@post.gmane.org>
References: <1395310551-23201-1-git-send-email-pclouds@gmail.com> <1395310551-23201-2-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 20 20:20:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQiVn-0000LK-DB
	for gcvg-git-2@plane.gmane.org; Thu, 20 Mar 2014 20:20:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759590AbaCTTUJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 20 Mar 2014 15:20:09 -0400
Received: from plane.gmane.org ([80.91.229.3]:44802 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754030AbaCTTUG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Mar 2014 15:20:06 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1WQiVX-0008JZ-Vo
	for git@vger.kernel.org; Thu, 20 Mar 2014 20:20:04 +0100
Received: from 198.23.103.126-static.reverse.softlayer.com ([198.23.103.126])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 20 Mar 2014 20:20:03 +0100
Received: from unsignedzero by 198.23.103.126-static.reverse.softlayer.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 20 Mar 2014 20:20:03 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 198.23.103.126 (Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/31.1.0.0 Safari/537.36)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244573>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds <at> gmail.com> writ=
es:

> This could could help highlight files in ls-files or status output, o=
r
> even diff --name-only (but that's questionable).
>=20
> This code is from coreutils.git commit
> 7326d1f1a67edf21947ae98194f98c38b6e9e527 file src/ls.c. This is the
> last GPL-2 commit before coreutils turns to GPL-3.
>=20

I don't know if this is something to consider but for my mac, I have an=
other=20
variable CLICOLOR which shows the colors if it is set. This is also tru=
e with=20
=46reeBSD[1] as well. I don't know if that should be checked if you're =
on those=20
systems.

I think it would be nice to have --color flag as well if you want to en=
able=20
color output for just that one output.=20

[1]: https://unix.stackexchange.com/questions/2897/clicolor-and-ls-colo=
rs-in-
bash
