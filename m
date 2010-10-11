From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 2/4] Documentation: diff can compare blobs
Date: Mon, 11 Oct 2010 11:04:08 -0500
Message-ID: <20101011160408.GC25842@burratino>
References: <20101011150342.292ad725@chalon.bertin.fr>
 <AANLkTinqPiGf1nbo0oOvDD5edgLBdO8xZfjGeFC4q0MU@mail.gmail.com>
 <20101011161721.35940919@chalon.bertin.fr>
 <20101011160224.GA25842@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Santi =?utf-8?B?QsOpamFy?= <santi@agolina.net>, git@vger.kernel.org
To: Yann Dirson <dirson@bertin.fr>
X-From: git-owner@vger.kernel.org Mon Oct 11 18:07:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P5KuW-00047Y-EZ
	for gcvg-git-2@lo.gmane.org; Mon, 11 Oct 2010 18:07:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755331Ab0JKQH1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Oct 2010 12:07:27 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:38910 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755315Ab0JKQH0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Oct 2010 12:07:26 -0400
Received: by qyk10 with SMTP id 10so4456687qyk.19
        for <git@vger.kernel.org>; Mon, 11 Oct 2010 09:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=SkP/aUgjKOxbOhjfmt92a198i2TBVsSRRs6S60bM1U8=;
        b=lNzXm8GPu9hAfn5BY3/E/TauLCE7aE1yAbUJNmxoLYGBKGpp3sH7Fk3fipJIXKheEU
         8qV6G3cr9B5A7kzv34XlGwUS8XQMFbRRY/L9xTn96KLJ0Kaqp+4WOIioypv9YDHqstMN
         iAL6nprHzMy9+XrR0G2RbxAizntFr6jp1aKYo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=MG9nbvEiUV7wOwkTGLBqFdc4UBRuMorUoRCrcPvUg5GfvDrEOSVVElXAOA6kJNwMW5
         kfuYzGHgByaQNX/iIkKLROBSqEkMTKtgmEVX2uIhdQYFXpVS+sl+aaJGPHMkRDPs1MT5
         0rbCZmrAhjNVpMQh1OuKQ+pueWx40gecev1pc=
Received: by 10.224.87.76 with SMTP id v12mr4632371qal.395.1286813244476;
        Mon, 11 Oct 2010 09:07:24 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id t4sm5891327qcs.16.2010.10.11.09.07.23
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 11 Oct 2010 09:07:23 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20101011160224.GA25842@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158772>

Meanwhile, there is no plumbing command to compare two blobs.
Strange.

Reported-by: Yann Dirson <dirson@bertin.fr>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 Documentation/git-diff.txt |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-diff.txt b/Documentation/git-diff.txt
index 481a33c..db2c6c2 100644
--- a/Documentation/git-diff.txt
+++ b/Documentation/git-diff.txt
@@ -64,8 +64,9 @@ forced by --no-index.
 
 Just in case if you are doing something exotic, it should be
 noted that all of the <commit> in the above description, except
-for the last two forms that use ".." notations, can be any
-<tree-ish>.
+in the last two forms that use ".." notations, can be any
+<tree>.  The third form ('git diff <commit> <commit>') can also
+be used to compare two <blob> objects.
 
 For a more complete list of ways to spell <commit>, see
 "SPECIFYING REVISIONS" section in linkgit:gitrevisions[7].
-- 
1.7.2.3
