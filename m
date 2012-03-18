From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] gitk: use "gitk: repo-top-level-dir" as window title
Date: Mon, 19 Mar 2012 10:01:40 +1100
Message-ID: <20120318230140.GB26977@bloggs.ozlabs.ibm.com>
References: <1320856108-25233-1-git-send-email-zbyszek@in.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Doug Maxey <dwm@enoyolf.org>,
	gitster@pobox.com
To: Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
X-From: git-owner@vger.kernel.org Mon Mar 19 00:26:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S9PUQ-0007tU-Ua
	for gcvg-git-2@plane.gmane.org; Mon, 19 Mar 2012 00:26:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756883Ab2CRX0N convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 18 Mar 2012 19:26:13 -0400
Received: from ozlabs.org ([203.10.76.45]:39991 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755071Ab2CRX0L (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Mar 2012 19:26:11 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id BC51EB7069; Mon, 19 Mar 2012 10:26:09 +1100 (EST)
Content-Disposition: inline
In-Reply-To: <1320856108-25233-1-git-send-email-zbyszek@in.waw.pl>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193397>

On Wed, Nov 09, 2011 at 05:28:28PM +0100, Zbigniew J=C4=99drzejewski-Sz=
mek wrote:
> Previously, when run in a subdirectory, gitk would show the name
> of this subdirectory as title, which was misleading. When run with
> GIT_DIR set, it would show the cwd, which is even more misleading.
>=20
> In case of non-bare repos, the .git suffix in the path is skipped.
>=20
> Signed-off-by: Zbigniew J=C4=99drzejewski-Szmek <zbyszek@in.waw.pl>

Thanks, applied, with the patch fixed to use $gitdir not [gitdir]
(needed since 86e847bc removed [gitdir]).

Paul.
