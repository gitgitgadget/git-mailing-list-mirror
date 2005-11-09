From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: HTTP redirection with git-clone/git-fetch ?
Date: Wed, 9 Nov 2005 23:31:36 +0100
Message-ID: <200511092331.36421.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Wed Nov 09 23:33:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EZyU2-0007eB-TT
	for gcvg-git@gmane.org; Wed, 09 Nov 2005 23:31:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751047AbVKIWbn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 Nov 2005 17:31:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751501AbVKIWbn
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Nov 2005 17:31:43 -0500
Received: from tuminfo2.informatik.tu-muenchen.de ([131.159.0.81]:33515 "EHLO
	tuminfo2.informatik.tu-muenchen.de") by vger.kernel.org with ESMTP
	id S1751048AbVKIWbl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Nov 2005 17:31:41 -0500
Received: from dhcp-3s-40.lrr.in.tum.de (dhcp-3s-40.lrr.in.tum.de [131.159.35.40])
	by mail.in.tum.de (Postfix) with ESMTP id 116F327D9
	for <git@vger.kernel.org>; Wed,  9 Nov 2005 23:31:38 +0100 (MET)
To: git@vger.kernel.org
User-Agent: KMail/1.8.2
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new/sophie/sophos at mailrelay1.informatik.tu-muenchen.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11425>

Hi,

git-clone fails silently with a HTTP URL where the server
responds with a redirection (ie. header line "Location:...").
I tried to add "-L" to the curl command line in git-clone.sh,
but this is only half of a fix. Afterwards I get:

defaulting to local storage area
error: Couldn't get http://repo/project.git/refs/heads/origin for heads/origin
Failed writing body
error: Could not interpret heads/origin as something to pull

This seems because git-fetch should understand redirections, too.
I am not familiar to the curl API. So perhaps another one can try to
fix this?

Josef
