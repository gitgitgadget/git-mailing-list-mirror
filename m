From: milki <milki@rescomp.berkeley.edu>
Subject: git-config: case insensitivity for subsections
Date: Wed, 17 Aug 2011 23:35:28 -0700
Message-ID: <20110818063528.GH13342@hal.rescomp.berkeley.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 18 08:41:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QtwIG-0006MS-Dh
	for gcvg-git-2@lo.gmane.org; Thu, 18 Aug 2011 08:41:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754888Ab1HRGl0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Aug 2011 02:41:26 -0400
Received: from hal.Rescomp.Berkeley.EDU ([169.229.70.150]:64319 "EHLO
	hal.rescomp.berkeley.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751772Ab1HRGlZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Aug 2011 02:41:25 -0400
X-Greylist: delayed 356 seconds by postgrey-1.27 at vger.kernel.org; Thu, 18 Aug 2011 02:41:25 EDT
Received: by hal.rescomp.berkeley.edu (Postfix, from userid 1070)
	id 137BE119E33; Wed, 17 Aug 2011 23:35:29 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179569>

In git-config(1):

There is also a case insensitive alternative [section.subsection]
syntax. In this syntax, subsection names follow the same restrictions
as for section names.

If I define [section.SUBSECTION] (aka, not all lowercase), I cannot
use: git config section.SUBSECTION.option, but rather only git config
section.subsection.option. Furthermore, If I also define a [section
"SUBSECTION"], the two sections are not merged.

I believe this differs from the case insensitity that is used for
sections: [section] and [SECTION] would be considered the same section.

Is this the proper behaviour for the case insensititve alternative for
subsections?

Thanks.

-- 
milki
