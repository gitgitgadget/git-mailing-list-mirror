From: "mail@samtuke.com" <mail@samtuke.com>
Subject: Adding non-bare branches to a non-bare repository
Date: Thu, 3 Mar 2011 10:53:35 +0000
Message-ID: <201103031053.35864.mail@samtuke.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 03 12:54:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pv77F-0001Jt-GV
	for gcvg-git-2@lo.gmane.org; Thu, 03 Mar 2011 12:54:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753288Ab1CCLyk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Mar 2011 06:54:40 -0500
Received: from 78-105-174-214.zone3.bethere.co.uk ([78.105.174.214]:53897 "EHLO
	localhost6.localdomain6" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752035Ab1CCLyk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Mar 2011 06:54:40 -0500
X-Greylist: delayed 3708 seconds by postgrey-1.27 at vger.kernel.org; Thu, 03 Mar 2011 06:54:39 EST
Received: from localhost6.localdomain6 (localhost.localdomain [127.0.0.1])
	by localhost6.localdomain6 (8.14.4/8.14.4) with ESMTP id p23AraGw009512
	for <git@vger.kernel.org>; Thu, 3 Mar 2011 10:53:36 GMT
Received: (from samtuke@localhost)
	by localhost6.localdomain6 (8.14.4/8.14.4/Submit) id p23ArZPe009511
	for git@vger.kernel.org; Thu, 3 Mar 2011 10:53:35 GMT
X-Authentication-Warning: localhost6.localdomain6: samtuke set sender to mail@samtuke.com using -f
User-Agent: KMail/1.13.6 (Linux/2.6.35.11-83.fc14.x86_64; KDE/4.5.5; x86_64; ; )
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168388>

Hi,

My website is a non-bare git repository. I have a copy of the website for 
testing purposes which is a separate git repository. Currently these two 
repositories are not aware of each other, and I copy across files from one to 
the other in order to bring features from the test repo into the live site.

I would like to make the testing repository into a branch of the live website 
repository so that I can easily merge in changes from one to the other.

Both repositories need to be complete copies of files as they are web 
accessible and must be functional.

Is this possible?

In future I also need to make a third copy of the site to have a beta as well 
as an alpha testing copy of the website.

Thanks,

Sam.
