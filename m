From: Alexandre Julliard <julliard@winehq.org>
Subject: Re: [PATCH] Adding menu for Emacs git.el
Date: Sun, 02 Dec 2007 19:42:31 +0100
Message-ID: <87fxylos4o.fsf@wine.dyndns.org>
References: <87mysvfr7e.dlv@vanicat.homelinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?us-ascii?Q?=3D=3Futf-8=3Fq=3FR=3DC3=3DA9mi=3D20Vanicat=3F=3D?= 
	<vanicat@debian.org>
X-From: git-owner@vger.kernel.org Sun Dec 02 19:43:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IytnC-0003ZQ-VC
	for gcvg-git-2@gmane.org; Sun, 02 Dec 2007 19:43:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756130AbXLBSmp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 2 Dec 2007 13:42:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756080AbXLBSmo
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Dec 2007 13:42:44 -0500
Received: from mail.codeweavers.com ([216.251.189.131]:58085 "EHLO
	mail.codeweavers.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756026AbXLBSmn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 2 Dec 2007 13:42:43 -0500
Received: from adsl-84-227-183-69.adslplus.ch ([84.227.183.69] helo=wine.dyndns.org)
	by mail.codeweavers.com with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <julliard@winehq.org>)
	id 1Iytlz-0003Z2-Hu; Sun, 02 Dec 2007 12:42:41 -0600
Received: from wine.dyndns.org (localhost [127.0.0.1])
	by wine.dyndns.org (Postfix) with ESMTP id D500A1E713C;
	Sun,  2 Dec 2007 19:42:31 +0100 (CET)
In-Reply-To: <87mysvfr7e.dlv@vanicat.homelinux.org> (utf's message of "Fri, 30
	Nov 2007 20:29:08 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.0.50 (gnu/linux)
X-Spam-Score: -1.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66806>

"=3D?utf-8?q?R=3DC3=3DA9mi=3D20Vanicat?=3D" <vanicat@debian.org>, Remi =
Vanicat
<vanicat@debian.org> writes:

> Adding three menu to the git-status-mode of git.el : One for marking
> and unmarking, one for every thing you need when you have a conflict,
> and a last one for all the rest.
>
> Signed-off-by: R=C3=A9mi Vanicat <vanicat@debian.org>

It looks good to me. A couple of minor details:

> +      ["Interctive Diff File" git-diff-file-idiff t]

There's a typo here.

> +      ["Show Uptodate" git-toggle-show-uptodate :style toggle :selec=
ted git-show-uptodate]
> +      ["Toggle Show Ignored" git-toggle-show-ignored :style toggle :=
selected git-show-ignored]
> +      ["Toggle Show Unknown" git-toggle-show-unknown :style toggle :=
selected git-show-unknown]))

I'd get rid of 'Toggle' on the last two for consistency.

BTW do you have a copyright assignment for Emacs?

--=20
Alexandre Julliard
julliard@winehq.org
