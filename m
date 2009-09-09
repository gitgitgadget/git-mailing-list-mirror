From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [ JGIT ] incompatiblity found in DirCache
Date: Wed, 9 Sep 2009 23:11:06 +0200
Message-ID: <200909092311.07145.robin.rosenberg.lists@dewire.com>
References: <4AA7FA2B.4090707@writeme.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Adam W. Hawks" <awhawks@writeme.com>, spearce@spearce.org
X-From: git-owner@vger.kernel.org Wed Sep 09 23:11:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MlURj-0001fU-BQ
	for gcvg-git-2@lo.gmane.org; Wed, 09 Sep 2009 23:11:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754214AbZIIVLI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Sep 2009 17:11:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754193AbZIIVLI
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Sep 2009 17:11:08 -0400
Received: from mail.dewire.com ([83.140.172.130]:1256 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753018AbZIIVLH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Sep 2009 17:11:07 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 3D4B1139DE4F;
	Wed,  9 Sep 2009 23:11:09 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TRFYJ9sMf+VN; Wed,  9 Sep 2009 23:11:08 +0200 (CEST)
Received: from sleipner.localnet (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id 0F689139DE46;
	Wed,  9 Sep 2009 23:11:08 +0200 (CEST)
User-Agent: KMail/1.11.2 (Linux/2.6.28-11-generic; KDE/4.2.2; i686; ; )
In-Reply-To: <4AA7FA2B.4090707@writeme.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128081>

onsdag 09 september 2009 20:55:39 skrev "Adam W. Hawks" <awhawks@writeme.com>:
> When using the DirCache interface to the index you can create a invalid/corrupt tree for git 1.6.5.
> 
> The problem seems to be you can add a path to the index that starts with a "/" and DirCache creates a entry with a mode but no path.
> This causes git 1.6.5 to fail with a corrupt tree.

I think there are more ways of entering bad stuff. Preventing a deliberate programmatic creation of invalid trees is probably not the most important
thing, but then again, validating the data to prevent e.g. the EGit plugin from doing it by mistake due to bugs could probably
be worthwhile.

-- robin
