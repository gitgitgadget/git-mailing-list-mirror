From: Libor Pechacek <lpechacek@suse.cz>
Subject: git-config does not check validity of variable names
Date: Sat, 8 Jan 2011 15:46:44 +0100
Message-ID: <20110108144644.GA11019@localhost.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 08 15:47:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pba4R-0001Yj-Mg
	for gcvg-git-2@lo.gmane.org; Sat, 08 Jan 2011 15:47:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752798Ab1AHOqu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Jan 2011 09:46:50 -0500
Received: from cantor2.suse.de ([195.135.220.15]:50182 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752161Ab1AHOqt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Jan 2011 09:46:49 -0500
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.221.2])
	by mx2.suse.de (Postfix) with ESMTP id 7FF5C5FC9F
	for <git@vger.kernel.org>; Sat,  8 Jan 2011 15:46:48 +0100 (CET)
Content-Disposition: inline
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164822>

Hello,

I've noticed that git-config accepts variable names in the form "a=b" for its
"get" operation.  That means "git config a=b" does not write anything to its
output and exists with status 1.

According to the man page only alphanumeric characters and - are allowed in
variable names.  Would it make sense to spit out an error message when the user
supplies an invalid variable name like the above?

Libor
-- 
Libor Pechacek
SUSE L3 Team, Prague
