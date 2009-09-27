From: Alexey Nezhdanov <snakeru@gmail.com>
Subject: Re: cgit suggestion
Date: Sun, 27 Sep 2009 23:02:30 +0400
Message-ID: <200909272302.30742.snakeru@gmail.com>
References: <e95c2db40909252314t12abb6e2w9b6e9c34c7a724a5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_Gb7vKb10ucHniRY"
Cc: git@vger.kernel.org
To: hjemli@gmail.com
X-From: git-owner@vger.kernel.org Sun Sep 27 21:02:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mrz17-0004pV-Rc
	for gcvg-git-2@lo.gmane.org; Sun, 27 Sep 2009 21:02:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752730AbZI0TCc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Sep 2009 15:02:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752330AbZI0TCc
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Sep 2009 15:02:32 -0400
Received: from mail-ew0-f211.google.com ([209.85.219.211]:51333 "EHLO
	mail-ew0-f211.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751191AbZI0TCb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Sep 2009 15:02:31 -0400
Received: by ewy7 with SMTP id 7so3875932ewy.17
        for <git@vger.kernel.org>; Sun, 27 Sep 2009 12:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :message-id;
        bh=UzEmfk0hzwUgTYIcQSPiydEbca4YQMC2ewA5AQfVyes=;
        b=EPY3Ip0qOuBg8EVAdmeHhOtRsIFtXuzLtY+HGGkOg9I6hDHGjehoCSI4By4R43DdH/
         t925hEoFr9qisFOcryxZS+jnPWudDw1SoiCUTfuezhkC4vZpkwD5W6cFQzxCqjlClWHd
         z8nwljug8jZvDca63rFfseNVAmCVVyW14ROcs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:message-id;
        b=kWhS7qrheGNcMdoAQTyThDE1benH9xkhN+Ac0Hos/vw6V2dMn/ybxsHILPOIYEq05j
         GN2uuFUAoJo6Kshi7qxl0O2IRom3r+1ZkWN2lqJHerQKSaab3bRxBrk33H0HQ0ohwRf6
         BgNVJc8F30hDg/kP737/CMU/29SFnHWCstYKw=
Received: by 10.211.155.20 with SMTP id h20mr2138830ebo.44.1254078153405;
        Sun, 27 Sep 2009 12:02:33 -0700 (PDT)
Received: from ?192.168.1.3? ([77.108.242.222])
        by mx.google.com with ESMTPS id 7sm189290eyb.28.2009.09.27.12.02.32
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 27 Sep 2009 12:02:32 -0700 (PDT)
User-Agent: KMail/1.9.10
In-Reply-To: <e95c2db40909252314t12abb6e2w9b6e9c34c7a724a5@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129215>

--Boundary-00=_Gb7vKb10ucHniRY
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello Lars.
Here is the diff. It adds feature of downloading 'named' tarball from the tag 
description page.

On Saturday 26 September 2009 10:14:19 Alexey Nezhdanov wrote:
> Hello Lars.
> Discovered a cgit for myself throught the LWN article:
> http://lwn.net/Articles/351798/
>
> Great thing! I'm impressed, will use it instead of gitweb (when I'll need a
> web interface anyway ;-P).
> Came upon a thing though that I consider to be an inconvenience.
>
> When I click on a tag, for instance:
> http://hjemli.net/git/cgit/tag/?id=v0.8.2.2
> there is no download link of assotiated object. And if I click on a 'tagged
> object' I get download links, but they are referenced by SHA-1 format.
> So they can not be used as a .orig.tar.gz package or even just stored 'for
> a future use' since SHA-1 is not human readable.
> So I propose putting download links onto tag page for the objects of type
> 'tree' and 'commit'.
> If you want me to write a patch - I'll do.
>
> Regards
> Alexey Nezhdanov.



-- 
Sincerely yours
Alexey Nezhdanov

--Boundary-00=_Gb7vKb10ucHniRY
Content-Type: text/x-diff;
  charset="iso 8859-1";
  name="0001-Ad-hoc-tarball-downloads-from-the-tag-description-pa.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="0001-Ad-hoc-tarball-downloads-from-the-tag-description-pa.patch"

=46rom b70365dfab8bb9ade733ea8387880b2b2cf4baa4 Mon Sep 17 00:00:00 2001
=46rom: Alexey Nezhdanov <snakeru@gmail.com>
Date: Sun, 27 Sep 2009 23:00:29 +0400
Subject: [PATCH] Ad-hoc tarball downloads from the tag description page.

Signed-off-by: Alexey Nezhdanov <snakeru@gmail.com>
=2D--
 ui-tag.c |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/ui-tag.c b/ui-tag.c
index c2d72af..da93b7a 100644
=2D-- a/ui-tag.c
+++ b/ui-tag.c
@@ -76,6 +76,12 @@ void cgit_print_tag(char *revname)
 		html("<tr><td>Tagged object</td><td>");
 		cgit_object_link(tag->tagged);
 		html("</td></tr>\n");
+                if (ctx.repo->snapshots) {
+                        html("<tr><th>download</th><td class=3D'sha1'>");
+                        cgit_print_snapshot_links(ctx.qry.repo, ctx.qry.he=
ad,
+                                                  revname, ctx.repo->snaps=
hots);
+                        html("</td></tr>");
+                }
 		html("</table>\n");
 		print_tag_content(info->msg);
 	} else {
@@ -86,6 +92,12 @@ void cgit_print_tag(char *revname)
 		html("<tr><td>Tagged object</td><td>");
 		cgit_object_link(obj);
 		html("</td></tr>\n");
+                if (ctx.repo->snapshots) {
+                        html("<tr><th>download</th><td class=3D'sha1'>");
+                        cgit_print_snapshot_links(ctx.qry.repo, ctx.qry.he=
ad,
+                                                  revname, ctx.repo->snaps=
hots);
+                        html("</td></tr>");
+                }
 		html("</table>\n");
         }
 	return;
=2D-=20
1.5.6.3


--Boundary-00=_Gb7vKb10ucHniRY--
