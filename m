From: Tim Shimmin <tes@sgi.com>
Subject: git pull a subtree, embedded trees
Date: Wed, 13 Sep 2006 23:05:19 +1000
Organization: SGI
Message-ID: <4508020F.2050604@sgi.com>
Reply-To: tes@sgi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Wed Sep 13 15:06:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GNURl-0007Jl-8J
	for gcvg-git@gmane.org; Wed, 13 Sep 2006 15:06:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750770AbWIMNF2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Sep 2006 09:05:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750786AbWIMNF2
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Sep 2006 09:05:28 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:62155 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1750770AbWIMNF1 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Sep 2006 09:05:27 -0400
Received: from larry.melbourne.sgi.com (larry.melbourne.sgi.com [134.14.52.130])
	by omx2.sgi.com (8.12.11/8.12.9/linux-outbound_gateway-1.1) with SMTP id k8DFeJ98032473
	for <@external-mail-relay.sgi.com:git@vger.kernel.org>; Wed, 13 Sep 2006 08:40:20 -0700
Received: from [134.14.52.207] (pmmelb207.melbourne.sgi.com [134.14.52.207]) by larry.melbourne.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) via ESMTP id XAA05646 for <git@vger.kernel.org>; Wed, 13 Sep 2006 23:05:20 +1000
User-Agent: Thunderbird 1.5.0.4 (Macintosh/20060530)
To: git <git@vger.kernel.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26910>

Hi,

I'm new to git and have a couple of novice questions.

* Is it possible to only pull in a subtree from
a repository.
Moreover, is it possible to have a subtree based on another
repository.
For example, have a topdir directory with subdirs,
s1, s2, s3 and s4. And then have say, s2 linked to
a repository rs2 and s3 linked to rs3, so that
one can update s2 and s3 from these other repositories but
having the rest of the tree linked from a main repository.

* Are there any tools for dumping out the contents of the
git objects in the .git/objects directory.
By dumping out, I mean an ascii representation of the data
fields for the commit and tree objects in particular.
I've written a simple small program to dump out the index
entries (cache entries).
I just want to see what is exactly stored in the .git
binary files and how they change when I do various git
operations.

Thanks a bunch.

--Tim
