From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v4 56/73] gettextize: git-status shortstatus messages
Date: Tue, 22 Feb 2011 23:42:15 +0000
Message-ID: <1298418152-27789-57-git-send-email-avarab@gmail.com>
References: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 23 00:46:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ps1w4-0000rs-V1
	for gcvg-git-2@lo.gmane.org; Wed, 23 Feb 2011 00:46:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755694Ab1BVXpk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 Feb 2011 18:45:40 -0500
Received: from mail-bw0-f51.google.com ([209.85.214.51]:52041 "EHLO
	mail-bw0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754651Ab1BVXo2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Feb 2011 18:44:28 -0500
Received: by mail-bw0-f51.google.com with SMTP id 10so3867035bwz.10
        for <git@vger.kernel.org>; Tue, 22 Feb 2011 15:44:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=lYMRuenqFIqgcMkCeF4IXVFANCNxdkApV/XDDMCMu5I=;
        b=wqrbK1vIK41OMeE2JDpppY63R14DyYvEa7t1u9Z0zEZiUKfPF0mhQItAgoI7hYnAyM
         Gd38qb50TLZm+6xVKgOf4qRUZSyVcynsyP5gpfJ/gWst/2hRtl7Bh9V2+qdrhbicZO6M
         arr+vsGqF0iuBIYVO8O1qE2ZHsGoi0YtyK2KY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=b6xqAMaslJ5HGx49tZHzFjSeAwTmIlxpg3clohZ1XTsUQrzd2+UlUljqOsnruqaLRg
         U9Bb/qpkLFu7xR9LGMW8P5aow25hxy9ZGjcrJwFHsTjKkpgrTdYa68lWpZ71oP6o2Jfl
         Wbe2WKslidjuiyk9ceihQUYmMh5/dvgsu7MpQ=
Received: by 10.204.102.206 with SMTP id h14mr3059196bko.45.1298418268070;
        Tue, 22 Feb 2011 15:44:28 -0800 (PST)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id z18sm4913415bkf.8.2011.02.22.15.44.26
        (version=SSLv3 cipher=OTHER);
        Tue, 22 Feb 2011 15:44:27 -0800 (PST)
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
In-Reply-To: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
References: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167628>

Make the messages added in v1.7.2-rc0~54^2~1 translatable. Some of
these could use the to be implemented plural support in the gettext
library.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 wt-status.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/wt-status.c b/wt-status.c
index a975d07..fc38ac2 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -804,13 +804,13 @@ static void wt_shortstatus_print_tracking(struct =
wt_status *s)
 	if (!prefixcmp(branch_name, "refs/heads/"))
 		branch_name +=3D 11;
 	else if (!strcmp(branch_name, "HEAD")) {
-		branch_name =3D "HEAD (no branch)";
+		branch_name =3D _("HEAD (no branch)");
 		branch_color_local =3D color(WT_STATUS_NOBRANCH, s);
 	}
=20
 	branch =3D branch_get(s->branch + 11);
 	if (s->is_initial)
-		color_fprintf(s->fp, header_color, "Initial commit on ");
+		color_fprintf(s->fp, header_color, _("Initial commit on "));
 	if (!stat_tracking_info(branch, &num_ours, &num_theirs)) {
 		color_fprintf_ln(s->fp, branch_color_local,
 			"%s", branch_name);
@@ -825,15 +825,15 @@ static void wt_shortstatus_print_tracking(struct =
wt_status *s)
=20
 	color_fprintf(s->fp, header_color, " [");
 	if (!num_ours) {
-		color_fprintf(s->fp, header_color, "behind ");
+		color_fprintf(s->fp, header_color, _("behind "));
 		color_fprintf(s->fp, branch_color_remote, "%d", num_theirs);
 	} else if (!num_theirs) {
-		color_fprintf(s->fp, header_color, "ahead ");
+		color_fprintf(s->fp, header_color, _("ahead "));
 		color_fprintf(s->fp, branch_color_local, "%d", num_ours);
 	} else {
-		color_fprintf(s->fp, header_color, "ahead ");
+		color_fprintf(s->fp, header_color, _("ahead "));
 		color_fprintf(s->fp, branch_color_local, "%d", num_ours);
-		color_fprintf(s->fp, header_color, ", behind ");
+		color_fprintf(s->fp, header_color, _(", behind "));
 		color_fprintf(s->fp, branch_color_remote, "%d", num_theirs);
 	}
=20
--=20
1.7.2.3
