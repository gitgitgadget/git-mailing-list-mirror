From: Mike Hommey <mh@glandium.org>
Subject: git-svn fetch updating master
Date: Wed, 15 Aug 2007 20:12:28 +0200
Organization: glandium.org
Message-ID: <20070815181228.GA6363@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Aug 15 20:13:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ILNMm-0003BZ-Ji
	for gcvg-git@gmane.org; Wed, 15 Aug 2007 20:13:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754146AbXHOSNI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 15 Aug 2007 14:13:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753362AbXHOSNH
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Aug 2007 14:13:07 -0400
Received: from vawad.err.no ([85.19.200.177]:57586 "EHLO vawad.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758423AbXHOSNG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Aug 2007 14:13:06 -0400
Received: from aputeaux-153-1-87-165.w86-205.abo.wanadoo.fr ([86.205.105.165] helo=namakemono.glandium.org)
	by vawad.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.62)
	(envelope-from <mh@glandium.org>)
	id 1ILNMX-0004HC-RB
	for git@vger.kernel.org; Wed, 15 Aug 2007 20:13:00 +0200
Received: from mh by namakemono.glandium.org with local (Exim 4.67)
	(envelope-from <mh@glandium.org>)
	id 1ILNM4-0001f3-5E
	for git@vger.kernel.org; Wed, 15 Aug 2007 20:12:28 +0200
Content-Disposition: inline
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.16 (2007-06-11)
X-Spam-Status: (score 0.0): Status=No hits=0.0 required=5.0 tests=none version=3.1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55931>

Hi,

I was wondering why the master branch was hardcoded to be updated in
post_fetch_checkout() in git-svn. Why not allow to use another branch ?

Mike
