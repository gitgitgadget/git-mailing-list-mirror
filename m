From: Holger =?utf-8?B?V2Vpw58=?= <holger@zedat.fu-berlin.de>
Subject: [PATCH] Documentation: show-ref <pattern>s are optional
Date: Mon, 29 Mar 2010 13:02:37 +0200
Organization: Freie =?utf-8?Q?Universit=C3=A4t?= Berlin
Message-ID: <20100329110237.GE14869@CIS.FU-Berlin.DE>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Mar 29 13:03:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NwCk0-0003dC-0k
	for gcvg-git-2@lo.gmane.org; Mon, 29 Mar 2010 13:02:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755403Ab0C2LCi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 29 Mar 2010 07:02:38 -0400
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66]:46241 "EHLO
	outpost1.zedat.fu-berlin.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755299Ab0C2LCi (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 Mar 2010 07:02:38 -0400
Received: from relay1.zedat.fu-berlin.de ([130.133.4.67])
          by outpost1.zedat.fu-berlin.de (Exim 4.69)
          for git@vger.kernel.org with esmtp
          (envelope-from <holger@cis.fu-berlin.de>)
          id <1NwCjt-0002ws-BQ>; Mon, 29 Mar 2010 13:02:37 +0200
Received: from mail.cis.fu-berlin.de ([160.45.11.138])
          by relay1.zedat.fu-berlin.de (Exim 4.69)
          for git@vger.kernel.org with esmtp
          (envelope-from <holger@cis.fu-berlin.de>)
          id <1NwCjt-0001Ju-8z>; Mon, 29 Mar 2010 13:02:37 +0200
Received: by Mail.CIS.FU-Berlin.DE (Exim 4.69)
          for git@vger.kernel.org with local
          (envelope-from <holger@cis.fu-berlin.de>)
          id <1NwCjt-00AS24-72>; Mon, 29 Mar 2010 13:02:37 +0200
Mail-Followup-To: Git List <git@vger.kernel.org>
Content-Disposition: inline
X-Operating-System: IRIX64 6.5.30f
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Originating-IP: 160.45.11.138
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143455>

Specifying one or more <pattern> parameters is optional when calling
show-ref, so mark them as such using brackets in the manual.

Signed-off-by: Holger Wei=C3=9F <holger@zedat.fu-berlin.de>
---
 Documentation/git-show-ref.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-show-ref.txt b/Documentation/git-show-re=
f.txt
index df17d49..3f9d9c6 100644
--- a/Documentation/git-show-ref.txt
+++ b/Documentation/git-show-ref.txt
@@ -10,7 +10,7 @@ SYNOPSIS
 [verse]
 'git show-ref' [-q|--quiet] [--verify] [--head] [-d|--dereference]
 	     [-s|--hash[=3D<n>]] [--abbrev[=3D<n>]] [--tags]
-	     [--heads] [--] <pattern>...
+	     [--heads] [--] [<pattern>...]
 'git show-ref' --exclude-existing[=3D<pattern>] < ref-list
=20
 DESCRIPTION
--=20
1.7.0.3
