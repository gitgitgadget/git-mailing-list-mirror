From: Kacper Kornet <kornet@camk.edu.pl>
Subject: [BUG?] git-cvsimport: path to cvspsfile
Date: Wed, 23 Sep 2009 20:27:56 +0200
Message-ID: <20090923182756.GA12430@onyx.camk.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 23 20:37:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MqWiQ-0007tv-F9
	for gcvg-git-2@lo.gmane.org; Wed, 23 Sep 2009 20:37:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753281AbZIWShO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Sep 2009 14:37:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752707AbZIWShN
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Sep 2009 14:37:13 -0400
Received: from moat.camk.edu.pl ([148.81.175.50]:40534 "EHLO moat.camk.edu.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752353AbZIWShM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Sep 2009 14:37:12 -0400
X-Greylist: delayed 558 seconds by postgrey-1.27 at vger.kernel.org; Wed, 23 Sep 2009 14:37:12 EDT
Received: by moat.camk.edu.pl (Postfix, from userid 99)
	id 4652551002D; Wed, 23 Sep 2009 20:27:56 +0200 (CEST)
Received: from onyx.camk.edu.pl (onyx.camk.edu.pl [192.168.1.167])
	by moat.camk.edu.pl (Postfix) with SMTP id 3207951002C
	for <git@vger.kernel.org>; Wed, 23 Sep 2009 20:27:56 +0200 (CEST)
Received: (nullmailer pid 16026 invoked by uid 1293);
	Wed, 23 Sep 2009 18:27:56 -0000
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128990>

Hi,

When I use:

git cvs-import -C <dir> -P <cvspsfile>

it looks for <cvpsfile> relative to <dir>, not the working directory.
Is it a bug or a feature?

Best wishes,
-- 
  Kacper
