From: Mark Burton <markb@ordern.com>
Subject: Leave git-shell in $(bindir) ?
Date: Wed, 2 Jul 2008 17:21:32 +0100
Organization: Order N Ltd.
Message-ID: <20080702172132.5de5e025@crow>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 02 18:28:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KE5Bu-0006jY-5G
	for gcvg-git-2@gmane.org; Wed, 02 Jul 2008 18:28:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754573AbYGBQ1Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jul 2008 12:27:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754779AbYGBQ1Y
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Jul 2008 12:27:24 -0400
Received: from c2bthomr09.btconnect.com ([213.123.20.127]:2488 "EHLO
	c2bthomr09.btconnect.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754389AbYGBQ1X (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jul 2008 12:27:23 -0400
X-Greylist: delayed 348 seconds by postgrey-1.27 at vger.kernel.org; Wed, 02 Jul 2008 12:27:23 EDT
Received: from crow.ordern.com (host86-128-141-55.range86-128.btcentralplus.com [86.128.141.55])
	by c2bthomr09.btconnect.com
	with ESMTP id BHO93213;
	Wed, 2 Jul 2008 17:21:32 +0100 (BST)
Received: from crow (localhost [127.0.0.1])
	by crow.ordern.com (Postfix) with ESMTP id C018F190EC4
	for <git@vger.kernel.org>; Wed,  2 Jul 2008 17:21:32 +0100 (BST)
X-Mailer: Claws Mail 3.5.0 (GTK+ 2.12.0; x86_64-unknown-linux-gnu)
X-Junkmail-Status: score=10/50, host=c2bthomr09.btconnect.com
X-Junkmail-SD-Raw: score=unknown,
	refid=str=0001.0A090207.486BAB0D.01FF,ss=1,fgs=0,
	ip=86.128.141.55,
	so=2007-10-30 19:00:17,
	dmn=5.4.3/2008-02-01
X-Junkmail-IWF: false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87156>


Hi,

I see that the bulk of git programs are moving out of $(bindir).

Should git-shell be one of those that stay to make it easy to reference from /etc/passwd or scripts?

Cheers,

Mark
