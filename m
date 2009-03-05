From: Junio C Hamano <gitster@pobox.com>
Subject: What's in git.git (Mar 2009, #02; Thu, 05)
Date: Thu, 05 Mar 2009 02:07:03 -0800
Message-ID: <7vfxhs2shk.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 05 11:08:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LfAVN-0006zA-KP
	for gcvg-git-2@gmane.org; Thu, 05 Mar 2009 11:08:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752385AbZCEKHN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Mar 2009 05:07:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751692AbZCEKHM
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Mar 2009 05:07:12 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:49310 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751227AbZCEKHL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Mar 2009 05:07:11 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 3CE0A9F326;
	Thu,  5 Mar 2009 05:07:08 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 287039F325; Thu,
  5 Mar 2009 05:07:05 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-maint-at: bdfd739dac4c109ce360d38d0572d8717a46e795
X-master-at: 836769e875ecf47e83137a39de5937652e0e861e
X-Pobox-Relay-ID: 62CD5524-096D-11DE-A032-CFA5EBB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112282>

The release is out, and immediately after that somebody spots a minor
bug.

If things go as planned, tomorrow we will see a mass graduation to the
master branch of topics that have been cooking in next during the pre
release freeze period.

* The 'maint' branch has these fixes since v1.6.2

John Tapsell (1):
  Make the 'lock file' exists error more informative

Junio C Hamano (1):
  Beginning of 1.6.2 maintenance track


* The 'master' branch has these since v1.6.2 in addition to the above.

Carlos Manuel Duclos Vergara (1):
  git-archive: add --output=<file> to send output to a file

Christian Couder (1):
  rev-list: estimate number of bisection step left

Jeff King (1):
  improve missing repository error message

John Tapsell (3):
  Modify description file to say what this file is
  Google has renamed the imap folder
  Improve error message for git-filter-branch

Keith Cascio (2):
  Use DIFF_XDL_SET/DIFF_OPT_SET instead of raw bit-masking
  Fix neglect of diff_setup()/diff_setup_done() symmetry.
