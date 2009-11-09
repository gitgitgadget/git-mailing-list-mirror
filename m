From: sconeman <schoen@bu.edu>
Subject: get git not to care about permissions
Date: Mon, 9 Nov 2009 08:06:38 -0800 (PST)
Message-ID: <26268938.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 09 17:06:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N7WlQ-0003P9-Qr
	for gcvg-git-2@lo.gmane.org; Mon, 09 Nov 2009 17:06:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756111AbZKIQGd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Nov 2009 11:06:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756096AbZKIQGd
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Nov 2009 11:06:33 -0500
Received: from kuber.nabble.com ([216.139.236.158]:36732 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754412AbZKIQGd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Nov 2009 11:06:33 -0500
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <lists@nabble.com>)
	id 1N7WlK-0004VT-OH
	for git@vger.kernel.org; Mon, 09 Nov 2009 08:06:38 -0800
X-Nabble-From: schoen@bu.edu
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132490>


Hello,

I'm trying to set up git on a NetApp drive at my school, BU.  The NetApp
shares are configured with Windows permissions, and I forget the specifics
(which I can figure out if needed) about why this is the case, but basically
the deal is that if true UNIX permissions were to be used, Windows wouldn't
be able to read the drive.  As such, and because we use the Kerberos
ticketing system, the permissions for the drive are set up such that the
owners (myself and my team members) have full permissions, but nobody else
does.  Git doesn't like this and won't even create a bare repository.  Is
there any way I can get git to ignore permissions and just do what it needs
to do?

Thanks in advance for the help!

-Matt
-- 
View this message in context: http://old.nabble.com/get-git-not-to-care-about-permissions-tp26268938p26268938.html
Sent from the git mailing list archive at Nabble.com.
