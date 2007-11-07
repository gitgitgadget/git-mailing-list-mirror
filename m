From: Mike Hommey <mh@glandium.org>
Subject: git rebase --skip
Date: Wed, 7 Nov 2007 23:21:05 +0100
Organization: glandium.org
Message-ID: <20071107222105.GA31666@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 07 23:22:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IptHW-0004vc-DS
	for gcvg-git-2@gmane.org; Wed, 07 Nov 2007 23:21:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758738AbXKGWVi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Nov 2007 17:21:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758713AbXKGWVi
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Nov 2007 17:21:38 -0500
Received: from vawad.err.no ([85.19.200.177]:50312 "EHLO vawad.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758599AbXKGWVh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Nov 2007 17:21:37 -0500
Received: from aputeaux-153-1-97-76.w86-217.abo.wanadoo.fr ([86.217.119.76] helo=namakemono.glandium.org)
	by vawad.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.62)
	(envelope-from <mh@glandium.org>)
	id 1IptHB-0001be-7s
	for git@vger.kernel.org; Wed, 07 Nov 2007 23:21:35 +0100
Received: from mh by namakemono.glandium.org with local (Exim 4.68)
	(envelope-from <mh@glandium.org>)
	id 1IptGj-0008GY-D6
	for git@vger.kernel.org; Wed, 07 Nov 2007 23:21:05 +0100
Content-Disposition: inline
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.16 (2007-06-11)
X-Spam-Status: (score 2.0): Status=No hits=2.0 required=5.0 tests=RCVD_IN_SORBS_DUL version=3.1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63874>

Hi,

I use git-rebase quite regularly, and I haven't used git-rebase --skip
after a failed merge without first resetting the working tree. I was
wondering if it wouldn't make sense to automatically do the reset when
running git-rebase --skip.

Mike
