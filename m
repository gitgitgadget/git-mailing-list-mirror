From: Mike Hommey <mh@glandium.org>
Subject: git-fsck/lost-found's speed vs git-prune's
Date: Tue, 18 Sep 2007 11:09:26 +0200
Organization: glandium.org
Message-ID: <20070918090926.GA8927@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 18 11:10:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXZ61-0006Qw-44
	for gcvg-git-2@gmane.org; Tue, 18 Sep 2007 11:10:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754184AbXIRJKL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2007 05:10:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754159AbXIRJKK
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Sep 2007 05:10:10 -0400
Received: from vawad.err.no ([85.19.200.177]:45046 "EHLO vawad.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753812AbXIRJKJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Sep 2007 05:10:09 -0400
Received: from aputeaux-153-1-18-194.w82-124.abo.wanadoo.fr ([82.124.60.194] helo=namakemono.glandium.org)
	by vawad.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.62)
	(envelope-from <mh@glandium.org>)
	id 1IXZ5l-0000IX-PR
	for git@vger.kernel.org; Tue, 18 Sep 2007 11:10:09 +0200
Received: from mh by namakemono.glandium.org with local (Exim 4.67)
	(envelope-from <mh@glandium.org>)
	id 1IXZ5C-0002Lj-Im
	for git@vger.kernel.org; Tue, 18 Sep 2007 11:09:26 +0200
Content-Disposition: inline
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.16 (2007-06-11)
X-Spam-Status: (score 0.0): Status=No hits=0.0 required=5.0 tests=none version=3.1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58557>

Hi,

I was wondering if that was to be expected for git-fsck to be
significantly slower than git-prune (by several orders of magnitude) ?

$ time git-lost-found

real    8m22.167s
user    6m44.153s
sys     1m16.613s

$ time git-prune

real    0m0.376s
user    0m0.304s
sys     0m0.000s

Mike
