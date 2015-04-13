From: Max Kirillov <max@max630.net>
Subject: Re: [PATCH v3] config.c: split some variables to
 $GIT_DIR/config.worktree
Date: Tue, 14 Apr 2015 02:37:39 +0300
Message-ID: <20150413233739.GA786@wheezy.local>
References: <1427371464-22237-1-git-send-email-pclouds@gmail.com>
 <1427804079-13061-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jens.Lehmann@web.de
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 14 01:37:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yhnv9-0003lK-Lu
	for gcvg-git-2@plane.gmane.org; Tue, 14 Apr 2015 01:37:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754555AbbDMXhe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 13 Apr 2015 19:37:34 -0400
Received: from p3plsmtpa07-01.prod.phx3.secureserver.net ([173.201.192.230]:49240
	"EHLO p3plsmtpa07-01.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751509AbbDMXhb (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 13 Apr 2015 19:37:31 -0400
Received: from wheezy.local ([82.181.81.240])
	by p3plsmtpa07-01.prod.phx3.secureserver.net with 
	id FbdP1q00A5B68XE01bdVzc; Mon, 13 Apr 2015 16:37:30 -0700
Content-Disposition: inline
In-Reply-To: <1427804079-13061-1-git-send-email-pclouds@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267103>

On Tue, Mar 31, 2015 at 07:14:39PM +0700, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=
=BB=8Dc Duy wrote:
> core.worktree and core.bare, which are treated specially in 31e26eb [=
1],
> are now moved to info/core.worktree and the special treatment reverte=
d.
<...>
> -	if (get_common_dir(&sb, gitdir))
> -		fn =3D check_repo_format;
> -	else
> -		fn =3D check_repository_format_version;

By the way, after this '$GIT_DIR/common overrides core.worktree'
from t1501 started failing. I don't know what would be
better to do with the case, just remove maybe?

--=20
Max
