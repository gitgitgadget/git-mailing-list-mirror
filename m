From: John Keeping <john@keeping.me.uk>
Subject: [PATCH v2 1/2] git-fast-import(1): combine documentation of
 --[no-]relative-marks
Date: Wed, 9 Jan 2013 19:44:38 +0000
Message-ID: <cf4a4a10c1de73491048e8283582bdbf8c79c75e.1357760256.git.john@keeping.me.uk>
References: <cover.1357760256.git.john@keeping.me.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	"Eric S. Raymond" <esr@thyrsus.com>, git@vger.kernel.org,
	David Michael Barr <b@rr-dav.id.au>,
	Pete Wyckoff <pw@padd.com>, Thomas Rast <trast@student.ethz.ch>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 09 20:51:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tt1gr-0006n9-8h
	for gcvg-git-2@plane.gmane.org; Wed, 09 Jan 2013 20:51:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932405Ab3AITvh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jan 2013 14:51:37 -0500
Received: from coyote.aluminati.org ([72.9.247.114]:43370 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932231Ab3AITvg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jan 2013 14:51:36 -0500
X-Greylist: delayed 402 seconds by postgrey-1.27 at vger.kernel.org; Wed, 09 Jan 2013 14:51:36 EST
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id BDBD66064D3;
	Wed,  9 Jan 2013 19:44:53 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -2.9
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_00=-1.9] autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZN5tczYfiPTR; Wed,  9 Jan 2013 19:44:53 +0000 (GMT)
Received: from aardwolf.aluminati.org (aardwolf.aluminati.org [10.0.7.189])
	by coyote.aluminati.org (Postfix) with ESMTP id 25D0E606539;
	Wed,  9 Jan 2013 19:44:52 +0000 (GMT)
Received: from localhost (localhost [127.0.0.1])
	by aardwolf.aluminati.org (Postfix) with ESMTP id D2BBA330E3B;
	Wed,  9 Jan 2013 19:44:51 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at aluminati.org
Received: from aardwolf.aluminati.org ([127.0.0.1])
	by localhost (aardwolf.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pYYcYOJAATi0; Wed,  9 Jan 2013 19:44:51 +0000 (GMT)
Received: from serenity.lan (mink.aluminati.org [10.0.7.180])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by aardwolf.aluminati.org (Postfix) with ESMTPSA id ECA5D330E32;
	Wed,  9 Jan 2013 19:44:40 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <cover.1357760256.git.john@keeping.me.uk>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213089>

The descriptions of '--relative-marks' and '--no-relative-marks' make
more sense when read together instead of as two independent options.
Combine them into a single description block.

Signed-off-by: John Keeping <john@keeping.me.uk>
---
 Documentation/git-fast-import.txt | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-fast-import.txt b/Documentation/git-fast-import.txt
index 3da5cc2..75ce808 100644
--- a/Documentation/git-fast-import.txt
+++ b/Documentation/git-fast-import.txt
@@ -83,19 +83,17 @@ OPTIONS
 	Like --import-marks but instead of erroring out, silently
 	skips the file if it does not exist.
 
---relative-marks::
+--[no-]relative-marks::
 	After specifying --relative-marks the paths specified
 	with --import-marks= and --export-marks= are relative
 	to an internal directory in the current repository.
 	In git-fast-import this means that the paths are relative
 	to the .git/info/fast-import directory. However, other
 	importers may use a different location.
++
+Relative and non-relative marks may be combined by interweaving
+--(no-)-relative-marks with the --(import|export)-marks= options.
 
---no-relative-marks::
-	Negates a previous --relative-marks. Allows for combining
-	relative and non-relative marks by interweaving
-	--(no-)-relative-marks with the --(import|export)-marks=
-	options.
 
 --cat-blob-fd=<fd>::
 	Write responses to `cat-blob` and `ls` queries to the
-- 
1.8.1.468.g3d9f9b6
