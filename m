From: Max Kirillov <max@max630.net>
Subject: [question] && chaining vs shell loops
Date: Sun, 29 Mar 2015 18:48:41 +0300
Message-ID: <20150329154840.GA8771@wheezy.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 29 17:48:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YcFSB-0003me-Jm
	for gcvg-git-2@plane.gmane.org; Sun, 29 Mar 2015 17:48:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751740AbbC2Psh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Mar 2015 11:48:37 -0400
Received: from p3plsmtpa09-07.prod.phx3.secureserver.net ([173.201.193.236]:59162
	"EHLO p3plsmtpa09-07.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750960AbbC2Psh (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 29 Mar 2015 11:48:37 -0400
Received: from wheezy.local ([82.181.81.240])
	by p3plsmtpa09-07.prod.phx3.secureserver.net with 
	id 9ToW1q0035B68XE01Tob13; Sun, 29 Mar 2015 08:48:36 -0700
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266438>

Hi.

As far as I can see, loops in shell ignore non-zero exit
codes of the bodies which are not last. For example, exit
code of command 'for f in false true; do $f; done' is 0,
even if there was false.

How should one workaround it in test scripts, is there any
established approach?

-- 
Max
