From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] GIT 1.6.2.1
Date: Sun, 15 Mar 2009 21:52:22 -0700
Message-ID: <7vwsaqysqh.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 16 05:55:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lj4qy-0000t8-Ax
	for gcvg-git-2@gmane.org; Mon, 16 Mar 2009 05:55:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751391AbZCPEwc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Mar 2009 00:52:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751338AbZCPEwc
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Mar 2009 00:52:32 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:40447 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750956AbZCPEwb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Mar 2009 00:52:31 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id C761E6DC9;
	Mon, 16 Mar 2009 00:52:29 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id F27AA6DC8; Mon,
 16 Mar 2009 00:52:23 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 40FB9088-11E6-11DE-8F76-C5D912508E2D-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113308>

The latest maintenance release GIT 1.6.2.1 is available at the
usual places:

  http://www.kernel.org/pub/software/scm/git/

  git-1.6.2.1.tar.{gz,bz2}			(source tarball)
  git-htmldocs-1.6.2.1.tar.{gz,bz2}		(preformatted docs)
  git-manpages-1.6.2.1.tar.{gz,bz2}		(preformatted docs)

The RPM binary packages for a few architectures are found in:

  RPMS//git-*-1.6.2.1-1.fc9.$arch.rpm	(RPM)

----------------------------------------------------------------

GIT v1.6.2.1 Release Notes
==========================

Fixes since v1.6.2
------------------

* .gitignore learned to handle backslash as a quoting mechanism for
  comment introduction character "#".

* timestamp output in --date=relative mode used to display timestamps that
  are long time ago in the default mode; it now uses "N years M months
  ago", and "N years ago".

* git-add -i/-p now works with non-ASCII pathnames.

* "git hash-object -w" did not read from the configuration file from the
  correct .git directory.

* git-send-email learned to correctly handle multiple Cc: addresses.
