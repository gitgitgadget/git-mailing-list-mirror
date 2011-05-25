From: Chris Wilson <cwilson@vigilantsw.com>
Subject: [PATCH] Remove a dead assignment
Date: Wed, 25 May 2011 11:06:32 -0400
Message-ID: <20110525150631.GA29161@localhost>
References: <20110524210758.GH16052@localhost>
 <20110524224525.GI16052@localhost>
 <vpqfwo3ush3.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	=?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed May 25 17:06:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPFfW-00015e-Ou
	for gcvg-git-2@lo.gmane.org; Wed, 25 May 2011 17:06:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933100Ab1EYPGi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 May 2011 11:06:38 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:51290 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932176Ab1EYPGh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 May 2011 11:06:37 -0400
Received: by pwi15 with SMTP id 15so3470264pwi.19
        for <git@vger.kernel.org>; Wed, 25 May 2011 08:06:37 -0700 (PDT)
Received: by 10.68.14.193 with SMTP id r1mr3354360pbc.386.1306335996921;
        Wed, 25 May 2011 08:06:36 -0700 (PDT)
Received: from localhost (c-76-126-142-103.hsd1.ca.comcast.net [76.126.142.103])
        by mx.google.com with ESMTPS id q5sm5728056pbs.11.2011.05.25.08.06.34
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 25 May 2011 08:06:35 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <vpqfwo3ush3.fsf@bauges.imag.fr>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174409>

On Wed, May 25, 2011 at 09:52:56AM +0200, Matthieu Moy wrote:
> Chris Wilson <cwilson@vigilantsw.com> writes:
> 
> > Oops, I see others putting the patches inline. Here you go.
> 
> Please, read Documentation/SubmittingPatches. Especially read about
> signed-off-by and the way patches should be formatted (git send-email
> would help).

Thanks, trying this again. Like I said before, the author should
investigate if this variable should have been used before removing it.

Signed-off-by: Chris Wilson <cwilson@vigilantsw.com>
---
 sh-i18n--envsubst.c |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/sh-i18n--envsubst.c b/sh-i18n--envsubst.c
index 7125093..5829463 100644
--- a/sh-i18n--envsubst.c
+++ b/sh-i18n--envsubst.c
@@ -67,9 +67,6 @@ static void subst_from_stdin (void);
 int
 main (int argc, char *argv[])
 {
-  /* Default values for command line options.  */
-  unsigned short int show_variables = 0;
-
   switch (argc)
        {
        case 1:
@@ -88,7 +85,6 @@ main (int argc, char *argv[])
          /* git sh-i18n--envsubst --variables '$foo and $bar' */
          if (strcmp(argv[1], "--variables"))
                error ("first argument must be --variables when two are given");
-         show_variables = 1;
       print_variables (argv[2]);
          break;
        default:
--
1.7.5.2.354.g19aea
