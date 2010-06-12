From: Bernd Schubert <bernd.schubert@fastmail.fm>
Subject: need help with "stg clone"
Date: Sat, 12 Jun 2010 20:37:21 +0200
Message-ID: <201006122037.21656.bernd.schubert@fastmail.fm>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 12 20:37:55 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ONVad-0003Ag-2Q
	for gcvg-git-2@lo.gmane.org; Sat, 12 Jun 2010 20:37:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751826Ab0FLShZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jun 2010 14:37:25 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:48671 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751610Ab0FLShY (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 12 Jun 2010 14:37:24 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id EC202F48B9
	for <git@vger.kernel.org>; Sat, 12 Jun 2010 14:37:23 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Sat, 12 Jun 2010 14:37:23 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:subject:date:mime-version:content-type:content-transfer-encoding:message-id; s=smtpout; bh=NCpEDQAaZRuM7/QENqLBNrvgDcA=; b=nN3yibTlUt2+krg5MEsqzn0faO0jCVlL97r1PNYXnKgZ1McxCAzUpjYyX44FGpuwVhb/FMCgEu26YsuD5/ncxFeMUlveFDgwDOFNQ50mWVz6s6V5vdLbmVSu23h5Uf1zhobvoW2hRu1u7fHfPRZibqNByFk/4kO4hQGL6ME3XBo=
X-Sasl-enc: SSBX2F4PyIfQ/eOIVqVn3l2ccu5HCrEAxLLCNoYh6EVc 1276367843
Received: from bathl.localnet (stgt-4d038cfa.pool.mediaWays.net [77.3.140.250])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 8A5BE4B2149
	for <git@vger.kernel.org>; Sat, 12 Jun 2010 14:37:23 -0400 (EDT)
User-Agent: KMail/1.12.4 (Linux/2.6.31-22-generic; KDE/4.3.5; x86_64; ; )
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149027>

Hello all, 

I just try to switch from hg and hg-mq to git and now "stg clone" does not 
work as expected and I also don't find the answer anywhere.

If I clone with "stg clone dir other-dir", I expect and need that in 
"other-dir" still all patches can be pushed and popped from the branch. But 
that does not work

bernd@bathl lustre-1.8.3-ddn>stg applied
improve_autogen.patch
bug21581.patch
lustre-ddn-version.patch
disable_lru_resize.patch
bug22729_size_t.patch


# So a number of patches are applied to the Lustre branch. Now lets clone 
that:

cd ..
stg clone lustre-1.8.3-ddn/ ../lustre-1.8.3-ddn1-build
cd ../lustre-1.8.3-ddn1-build


# And now stg does not work anymore in that directory
bernd@bathl lustre-1.8.3-ddn1-build>stg series
bernd@bathl lustre-1.8.3-ddn1-build>

# Aaarg where are my patches?
git log
...

(shows all patches applied)


So either I'm doing something wrong, or stacked git will not suitable for my 
needs.

Any ideas or help would be greatly appreciated.


Thanks,
Bernd
