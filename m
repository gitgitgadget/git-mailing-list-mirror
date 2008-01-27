From: Jakub Narebski <jnareb@gmail.com>
Subject: Submodules use case: web development based on modular CMS
Date: Sun, 27 Jan 2008 01:39:56 +0100
Message-ID: <200801270139.57830.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 27 01:40:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JIvZh-00026p-Id
	for gcvg-git-2@gmane.org; Sun, 27 Jan 2008 01:40:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753313AbYA0AkK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jan 2008 19:40:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753380AbYA0AkJ
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Jan 2008 19:40:09 -0500
Received: from ug-out-1314.google.com ([66.249.92.175]:17092 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753189AbYA0AkH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jan 2008 19:40:07 -0500
Received: by ug-out-1314.google.com with SMTP id z38so750837ugc.16
        for <git@vger.kernel.org>; Sat, 26 Jan 2008 16:40:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=dh8QrUTb/pd56VJX82cMpOJc8nOM3InaAOkr0N7Q1Ys=;
        b=sfYApQkfbgj866nfqja8MAOYUfggVT4UU26q241GP88tOiWvoY9sFD6EW0F4KFdSXCIUURplIbcU1wfgzpy0EoJJuyvRdhkwawGTjbN067IQhUzAYFCZS2OfKrb57rm/nyjfcuORW9z2+8gEjoRZtqCI33WLu4CbgZicMn6eAIg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=xF2g3yDY0bd3Rq4Y+/IHYdWOlO/VzHAce+khakAficHmgvhfUydJtfa/OuQrj9Gr5e4nYaZSgCwqdfGZ4bMJ1FSeR2cJVY+5SBe9Ss6aaYpwejAqVRHfvRHZVyHBZHggA3oK1Oh/GgECT0OHZkyUBToa0argi/3Nl8ZeNYfX+iQ=
Received: by 10.66.243.4 with SMTP id q4mr1200061ugh.5.1201394405410;
        Sat, 26 Jan 2008 16:40:05 -0800 (PST)
Received: from ?192.168.1.11? ( [83.8.247.37])
        by mx.google.com with ESMTPS id s7sm12104880uge.86.2008.01.26.16.40.02
        (version=SSLv3 cipher=OTHER);
        Sat, 26 Jan 2008 16:40:03 -0800 (PST)
User-Agent: KMail/1.9.3
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71795>

A bit of time ago I have stumbled upon the following blog entry 
(question): "Agaric wants version control that lets Drupal core and 
contrib replace entire directories within our checkouts"[1]
  http://tinyurl.com/yv3jp4

Here the author want to use version control system for customized 
version of CMS system, namely:
 * Drupal core
 * selected Drupal contributed modules ("inside" Drupal core)
 * own work (theme, custom modules) (also "inside" Drupal core)
And of course he wants to have development branches: dev, test and live, 
and want to always checkout correct versions of Drupal, Drupal modules 
and own work.

Somebody (in comments) proposed using Subversion externals; I have 
proposed using Git submodules (subproject) support.  Nevertheless while 
I have at one time manage PHPNuke portal using CVS and vendor branches, 
and even had half-written automatic fast checkout/fast export script, 
I haven't worked with submodules in Git, nor with using Git to manage 
web site.

Comments (here, and as comments to mentioned blog article) about how 
such thing should be done with Git very appreciated. (And for example 
how Git submodules differ from svn:externals and why git way is 
better ;-)).


P.S. BTW. Drupal is considering moving from CVS to some other SCM, see
http://groups.drupal.org/revision-control-systems .  Perhaps Git would 
be the choice?  Is anybody here active in Drupal development?  Is for 
example their Version Control API too CVS-centric (single file history 
centric)?

[1]http://agaricdesign.com/note/agaric-wants-version-control-lets-drupal-core-and-contrib-replace-entire-directories-within-our-checkouts
-- 
Jakub Narebski
Poland
