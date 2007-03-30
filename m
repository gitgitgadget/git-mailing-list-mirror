From: Olivier Galibert <galibert@pobox.com>
Subject: Could git status know about -M ?
Date: Fri, 30 Mar 2007 02:09:49 +0200
Message-ID: <20070330000949.GB41089@dspnet.fr.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 30 02:30:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HX50J-0004Vo-2Y
	for gcvg-git@gmane.org; Fri, 30 Mar 2007 02:30:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934373AbXC3AaE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Mar 2007 20:30:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934378AbXC3AaD
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Mar 2007 20:30:03 -0400
Received: from dspnet.fr.eu.org ([213.186.44.138]:4345 "EHLO dspnet.fr.eu.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934373AbXC3AaB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Mar 2007 20:30:01 -0400
X-Greylist: delayed 1211 seconds by postgrey-1.27 at vger.kernel.org; Thu, 29 Mar 2007 20:30:01 EDT
Received: by dspnet.fr.eu.org (Postfix, from userid 1007)
	id 58236A3556; Fri, 30 Mar 2007 02:09:49 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43490>

Right now git status shows renames only if the deleted file is
strictly identical to the added file.  If you do an even minor
modification (say, change a "" include to a <> one) it becomes a
del/add pair which is way less readable.  Easily fixable?

  OG.
