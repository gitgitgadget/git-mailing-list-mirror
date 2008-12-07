From: Matt Kraai <kraai@ftbfs.org>
Subject: Remove feature_grep in gitweb?
Date: Sat, 6 Dec 2008 21:22:30 -0800
Message-ID: <20081207052230.GD4357@ftbfs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 07 06:24:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L9C7k-0005j3-Cv
	for gcvg-git-2@gmane.org; Sun, 07 Dec 2008 06:24:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751021AbYLGFWs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Dec 2008 00:22:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751069AbYLGFWs
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Dec 2008 00:22:48 -0500
Received: from neon.ftbfs.org ([83.168.236.214]:37539 "EHLO neon.ftbfs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750927AbYLGFWs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Dec 2008 00:22:48 -0500
Received: from pool-71-119-193-199.lsanca.dsl-w.verizon.net ([71.119.193.199] helo=macbookpro.ftbfs.org)
	by neon.ftbfs.org with esmtpa (Exim 4.63)
	(envelope-from <kraai@ftbfs.org>)
	id 1L9C6J-00020u-AR
	for git@vger.kernel.org; Sat, 06 Dec 2008 21:22:43 -0800
Received: from kraai by macbookpro.ftbfs.org with local (Exim 4.69)
	(envelope-from <kraai@ftbfs.org>)
	id 1L9C6A-00060K-Fx
	for git@vger.kernel.org; Sat, 06 Dec 2008 21:22:30 -0800
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Spam-Score-Int: -41
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102489>

Howdy,

A feature_grep subroutine is defined in gitweb.perl, but unlike the
other feature_* subroutines there, it doesn't appear to be used
anywhere.  Should it be removed?

-- 
Matt                                                 http://ftbfs.org/
