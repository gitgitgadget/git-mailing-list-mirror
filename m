From: Mike Hommey <mh@glandium.org>
Subject: Advanced aliases with arguments (?)
Date: Sun, 4 Nov 2007 01:40:20 +0100
Organization: glandium.org
Message-ID: <20071104004020.GA30487@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 04 01:41:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IoTYA-0001nn-Tq
	for gcvg-git-2@gmane.org; Sun, 04 Nov 2007 01:41:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756956AbXKDAk7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Nov 2007 20:40:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756065AbXKDAk7
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Nov 2007 20:40:59 -0400
Received: from vawad.err.no ([85.19.200.177]:59975 "EHLO vawad.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755137AbXKDAk7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Nov 2007 20:40:59 -0400
Received: from aputeaux-153-1-38-67.w82-124.abo.wanadoo.fr ([82.124.130.67] helo=namakemono.glandium.org)
	by vawad.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.62)
	(envelope-from <mh@glandium.org>)
	id 1IoTXo-0000R2-CK
	for git@vger.kernel.org; Sun, 04 Nov 2007 01:40:57 +0100
Received: from mh by namakemono.glandium.org with local (Exim 4.68)
	(envelope-from <mh@glandium.org>)
	id 1IoTXI-0007x6-By
	for git@vger.kernel.org; Sun, 04 Nov 2007 01:40:20 +0100
Content-Disposition: inline
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.16 (2007-06-11)
X-Spam-Status: (score 2.0): Status=No hits=2.0 required=5.0 tests=RCVD_IN_SORBS_DUL version=3.1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63329>

Hi,

I read on http://git.or.cz/gitwiki/Aliases that

        Starting with version 1.5.3, git supports appending the
        arguments to commands prefixed with "!", too. If you need to
        perform a reordering, or to use an argument twice, you can use
        this trick:

        [alias]
                example = !sh -c "ls $1 $0"


AFAICT, it doesn't work with the 1.5.3.5 I use. Is it false advertising
or was there some regression ?

Mike
