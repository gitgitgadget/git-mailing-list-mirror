From: Jared Hance <jaredhance@gmail.com>
Subject: [PATCH] Document git-instaweb start/stop/restart
Date: Mon, 2 Aug 2010 14:20:38 -0400
Message-ID: <4bf62aed1371d6b30c736e6b1a58a742676257c7.1280773180.git.jaredhance@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 02 20:20:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ofzd2-0007Bp-TE
	for gcvg-git-2@lo.gmane.org; Mon, 02 Aug 2010 20:20:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754286Ab0HBSUo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Aug 2010 14:20:44 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:39282 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754268Ab0HBSUn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Aug 2010 14:20:43 -0400
Received: by qwh6 with SMTP id 6so1733605qwh.19
        for <git@vger.kernel.org>; Mon, 02 Aug 2010 11:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:mime-version:content-type:content-disposition:user-agent;
        bh=FDoTv/QJuCZ0bECTo2S7/4vEjCPRkiv0RBy+SZTblRc=;
        b=c2JsxbzB47lalGie8i1/eFIXDFmStnZ6WH/kJ+tvm51OswY7YUsJ/BdpUh+W9ri9JB
         5nKxj3Dw6zvew+2H93DW2oTN2UntOVaIoW4LSI90Nn9nHvOIDzwCtIbIUO0QUGazZkQ4
         wqk44ZTcvA1XzWHKs3TrMlP437li0daUudI6Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        b=Z+9FFvi7zm/Y2A3eT60+HTivanxcOatEDJ+Jcl5YVhN9TNK13KDo3p/X/29SNuE87h
         SemOctxIWihLivn1zpZv0wSCXjFKovaZ5xBYN2s5cm/isKKi0hxqqJ8KAHW7km4glFtO
         JV7FgCtGQVkdp4BlLqwwozad3jddhrVY3QnnA=
Received: by 10.229.181.198 with SMTP id bz6mr366237qcb.114.1280773242435;
        Mon, 02 Aug 2010 11:20:42 -0700 (PDT)
Received: from localhost.localdomain (cpe-174-101-209-27.cinci.res.rr.com [174.101.209.27])
        by mx.google.com with ESMTPS id r1sm372302qcq.22.2010.08.02.11.20.41
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 02 Aug 2010 11:20:41 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-12-10)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152432>

The flags --start, --stop, and --restart can be used without the "--".
Document this feature.

Signed-off-by: Jared Hance <jaredhance@gmail.com>
---

I'm not quite sure that the convention is on how these should be
documented. 

 Documentation/git-instaweb.txt |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-instaweb.txt b/Documentation/git-instaweb.txt
index 2c3c4d2..e70cea9 100644
--- a/Documentation/git-instaweb.txt
+++ b/Documentation/git-instaweb.txt
@@ -49,15 +49,18 @@ OPTIONS
 	linkgit:git-web--browse[1] for more information about this. If
 	the script fails, the URL will be printed to stdout.
 
+start::
 --start::
 	Start the httpd instance and exit.  This does not generate
 	any of the configuration files for spawning a new instance.
 
+stop::
 --stop::
 	Stop the httpd instance and exit.  This does not generate
 	any of the configuration files for spawning a new instance,
 	nor does it close the browser.
 
+restart::
 --restart::
 	Restart the httpd instance and exit.  This does not generate
 	any of the configuration files for spawning a new instance.
-- 
1.7.2
