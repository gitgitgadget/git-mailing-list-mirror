From: Jan =?UTF-8?B?S3LDvGdlcg==?= <jk@jk.gs>
Subject: [Alt. PATCH 2/2] Documentation: pack.compression: explain how to
 recompress
Date: Mon, 27 Sep 2010 14:21:58 +0200
Message-ID: <20100927142158.487b8f19@jk.gs>
References: <20100927133104.25ce5285@jk.gs>
	<alpine.LFD.2.00.1009270742250.1146@xanadu.home>
	<20100927141936.590d71b3@jk.gs>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nicolas Pitre <nico@fluxnic.net>, Git ML <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jan =?UTF-8?B?S3LDvGdlcg==?= <jk@jk.gs>
X-From: git-owner@vger.kernel.org Mon Sep 27 14:22:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0Cie-0006L0-MS
	for gcvg-git-2@lo.gmane.org; Mon, 27 Sep 2010 14:22:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759063Ab0I0MWC convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 27 Sep 2010 08:22:02 -0400
Received: from zoidberg.org ([88.198.6.61]:33162 "EHLO cthulhu.zoidberg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753270Ab0I0MWB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Sep 2010 08:22:01 -0400
Received: from jk.gs (xdsl-89-0-0-81.netcologne.de [::ffff:89.0.0.81])
  (AUTH: LOGIN jast, SSL: TLSv1/SSLv3,128bits,AES128-SHA)
  by cthulhu.zoidberg.org with esmtp; Mon, 27 Sep 2010 14:22:01 +0200
  id 004000B7.4CA08C69.000054A7
In-Reply-To: <20100927141936.590d71b3@jk.gs>
X-Mailer: Claws Mail 3.7.6 (GTK+ 2.20.1; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157328>

Add a small remark about how to recompress all existing objects after
changing the compression level for pack files.

Signed-off-by: Jan Kr=C3=BCger <jk@jk.gs>
---

--- Nicolas Pitre <nico@fluxnic.net> wrote:

> In addition to that change, perhaps a note could be added to the=20
> documentation for pack.compression indicating that for the new
> setting to take effect for existing packs, they must be repacked with
> -F.

Good idea. Here it is.

 Documentation/config.txt |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index d294dd6..506477b 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1465,6 +1465,10 @@ pack.compression::
 	not set,  defaults to -1, the zlib default, which is "a default
 	compromise between speed and compression (currently equivalent
 	to level 6)."
++
+Note that changing the compression level will not automatically recomp=
ress
+all existing objects. You can force recompression by passing the -F op=
tion
+to linkgit:git-repack[1].
=20
 pack.deltaCacheSize::
 	The maximum memory in bytes used for caching deltas in
--=20
1.7.2.3.392.g02377.dirty
