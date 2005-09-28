From: Chuck Lever <cel@citi.umich.edu>
Subject: index file screwed up
Date: Wed, 28 Sep 2005 11:06:24 -0400
Organization: Network Appliance, Inc.
Message-ID: <433AB170.90608@citi.umich.edu>
Reply-To: cel@citi.umich.edu
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------080307030805010608090200"
X-From: git-owner@vger.kernel.org Wed Sep 28 17:08:43 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EKdVs-0006VL-Ks
	for gcvg-git@gmane.org; Wed, 28 Sep 2005 17:06:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751045AbVI1PGZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Sep 2005 11:06:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751048AbVI1PGZ
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Sep 2005 11:06:25 -0400
Received: from citi.umich.edu ([141.211.133.111]:19463 "EHLO citi.umich.edu")
	by vger.kernel.org with ESMTP id S1751041AbVI1PGZ (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 Sep 2005 11:06:25 -0400
Received: from [141.211.133.33] (dexter.citi.umich.edu [141.211.133.33])
	by citi.umich.edu (Postfix) with ESMTP id 7C96E1BBD4
	for <git@vger.kernel.org>; Wed, 28 Sep 2005 11:06:24 -0400 (EDT)
User-Agent: Mozilla Thunderbird 1.0.6-1.4.1 (X11/20050719)
X-Accept-Language: en-us, en
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9430>

This is a multi-part message in MIME format.
--------------080307030805010608090200
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

i was working with a version of git that had a bug in add_cache_entry() 
that introduced a sorting error in my index.

[cel@dexter main]$ stg refresh -f
Refreshing patch "git-switch-branch"...AUTHORS: unmerged 
(098c1d3e9fe5c39b859ccff6c7d36d2c193d1b62)
AUTHORS: unmerged (098c1d3e9fe5c39b859ccff6c7d36d2c193d1b62)
COPYING: unmerged (d60c31a97a544b53039088d14fe9114583c0efc3)
COPYING: unmerged (d60c31a97a544b53039088d14fe9114583c0efc3)
INSTALL: unmerged (8d2bebd9d1824f1b7af5cfe6fbd11f9cbfde6d74)
INSTALL: unmerged (8d2bebd9d1824f1b7af5cfe6fbd11f9cbfde6d74)
MANIFEST.in: unmerged (581d0be2a5fb3569b06681b7d559f1279aa4104b)
MANIFEST.in: unmerged (581d0be2a5fb3569b06681b7d559f1279aa4104b)
README: unmerged (184ded8e08cb92a14b79c79f9919469ba352ab70)
README: unmerged (184ded8e08cb92a14b79c79f9919469ba352ab70)
...
fatal: git-write-tree: verify_merged: not able to write tree
stg refresh: git-write-tree failed

[cel@dexter main]$


how do i recover?

--------------080307030805010608090200
Content-Type: text/x-vcard; charset=utf-8;
 name="cel.vcf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="cel.vcf"

begin:vcard
fn:Chuck Lever
n:Lever;Charles
org:Network Appliance, Incorporated;Linux NFS Client Development
adr:535 West William Street, Suite 3100;;Center for Information Technology Integration;Ann Arbor;MI;48103-4943;USA
email;internet:cel@citi.umich.edu
title:Member of Technical Staff
tel;work:+1 734 763 4415
tel;fax:+1 734 763 4434
tel;home:+1 734 668 1089
x-mozilla-html:FALSE
url:http://www.monkey.org/~cel/
version:2.1
end:vcard


--------------080307030805010608090200--
