From: Frans Pop <elendil@planet.nl>
Subject: Feature request: option to not fetch tags for 'git remote' branches
Date: Wed, 24 Mar 2010 21:54:28 +0100
Message-ID: <201003242154.29245.elendil@planet.nl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 24 21:55:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NuXbW-00047r-32
	for gcvg-git-2@lo.gmane.org; Wed, 24 Mar 2010 21:55:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932996Ab0CXUyc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Mar 2010 16:54:32 -0400
Received: from Cpsmtpm-eml106.kpnxchange.com ([195.121.3.10]:54935 "EHLO
	CPSMTPM-EML106.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753869Ab0CXUya (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 24 Mar 2010 16:54:30 -0400
Received: from aragorn.fjphome.nl ([77.166.180.99]) by CPSMTPM-EML106.kpnxchange.com with Microsoft SMTPSVC(7.0.6001.18000);
	 Wed, 24 Mar 2010 21:54:29 +0100
User-Agent: KMail/1.9.9
Content-Disposition: inline
X-OriginalArrivalTime: 24 Mar 2010 20:54:29.0266 (UTC) FILETIME=[32480720:01CACB94]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143125>

I'm sometimes asked to build a kernel or rebase patches against a certain 
development repository. No problem, happy to do that.

Except that some of those repos have huge numbers of tags that I'm not 
interested in and which only muddy the tags from the "origin" repo and my 
own.

I mostly want to remove the remote again ASAP and having to semi-manually 
remove the unwanted tags afterwards is a nuisance.

Example (on top of kernel mainline):
$ git remote add -t master iwlwifi \
	git://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-2.6.git
This results in the addition of 326 'master-<date>' tags, 70 'merge-<date>' 
tags and 6 'snapshot-<date>' tags.
Similar effects for example from Ingo's "tip" repository.

It would be great to be able to tell 'git remote' to skip tags and only 
fetch the requested branch. A --no-tags option maybe?

AFAIK this is currently not possible, although I'd happy to be proven 
wrong.

Cheers,
FJP
