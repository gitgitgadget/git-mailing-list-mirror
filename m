From: Allan Wind <allan_wind@lifeintegrity.com>
Subject: gc changes permissions of files
Date: Sat, 14 Jun 2008 23:59:17 -0400
Message-ID: <20080615035917.GA13414@lifeintegrity.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 15 06:28:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K7jqn-0008Fp-Fy
	for gcvg-git-2@gmane.org; Sun, 15 Jun 2008 06:28:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750820AbYFOE0z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Jun 2008 00:26:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750816AbYFOE0z
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Jun 2008 00:26:55 -0400
Received: from aeol.lifeintegrity.com ([209.135.157.90]:49523 "EHLO
	lifeintegrity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750778AbYFOE0z (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jun 2008 00:26:55 -0400
X-Greylist: delayed 1656 seconds by postgrey-1.27 at vger.kernel.org; Sun, 15 Jun 2008 00:26:55 EDT
Received: from vent.lifeintegrity.com (pool-71-174-251-18.bstnma.fios.verizon.net [71.174.251.18])
	by submission.lifeintegrity.com (Postfix) with ESMTP id ECB2FD5C1E3
	for <git@vger.kernel.org>; Sun, 15 Jun 2008 03:59:18 +0000 (UTC)
Received: by vent.lifeintegrity.com (Postfix, from userid 1000)
	id A267C304362; Sat, 14 Jun 2008 23:59:17 -0400 (EDT)
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85061>

Is anyone looking into fixing gc so it does not change permission on 
files?  I would think it should consider current permissions of files 
before umask.

I believe Nigel reported this issue with:
http://thread.gmane.org/gmane.comp.version-control.git/79213/focus=79237
and still seeing issues with 1.5.5.4.


/Allan
