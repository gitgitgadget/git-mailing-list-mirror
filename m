From: Junio C Hamano <gitster@pobox.com>
Subject: What's in git.git (Jul 2009, #02; Wed, 29)
Date: Wed, 29 Jul 2009 14:19:42 -0700
Message-ID: <7v63dbrxu9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 29 23:20:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MWGZC-0001xw-GV
	for gcvg-git-2@gmane.org; Wed, 29 Jul 2009 23:20:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753980AbZG2VTt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jul 2009 17:19:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753953AbZG2VTs
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Jul 2009 17:19:48 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:51764 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753798AbZG2VTs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jul 2009 17:19:48 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 07EB716312;
	Wed, 29 Jul 2009 17:19:47 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 40DC916310; Wed, 29 Jul 2009
 17:19:43 -0400 (EDT)
X-maint-at: 0a53e9ddeaddad63ad106860237bbf53411d11a7
X-master-at: e6580020057afd207b7cfb9c96905f99e13cfe4d
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 8ADE1C0C-7C85-11DE-8883-AEF1826986A2-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124391>

I took advices from the list and merged tests that have been parked in
'pu' during the 1.6.4 cycle to 'master'.  Even though I did not see much
feedback to the pt_BR translation of the tutorial, I decided to merge it
as well, since I do not read/speak the language.

We have reasonably solid topics that have been cooking in 'next' for quite
some time.  Hopefully the 1.6.5 cycle will be short and smooth.

* The 'master' branch has these since the last announcement.

Alex Riesen (1):
  Add a reminder test case for a merge with F/D transition

Heiko Voigt (2):
  cvsimport: add test illustrating a bug in cvsps
  cvsimport: extend testcase about patchset order to contain branches

Junio C Hamano (3):
  t/t9600: remove exit after test_done
  Start 1.6.5 cycle
  request-pull: optionally show a patch as well

Michael Haggerty (5):
  Start a library for cvsimport-related tests
  Use CVS's -f option if available (ignore user's ~/.cvsrc file)
  Test contents of entire cvsimported "master" tree contents
  Add some tests of git-cvsimport's handling of vendor branches
  Add a test of "git cvsimport"'s handling of tags and branches

Thadeu Lima de Souza Cascardo (1):
  Translate the tutorial to Brazillian Portuguese
