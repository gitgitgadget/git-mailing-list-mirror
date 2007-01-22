From: Andre Masella <andre@masella.no-ip.org>
Subject: Repository Security
Date: Mon, 22 Jan 2007 14:33:11 -0500
Message-ID: <200701221433.13257.andre@masella.no-ip.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Mon Jan 22 20:54:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H95Ev-0001Dd-IU
	for gcvg-git@gmane.org; Mon, 22 Jan 2007 20:54:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932410AbXAVTx6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 22 Jan 2007 14:53:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932414AbXAVTx6
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Jan 2007 14:53:58 -0500
Received: from toq12-srv.bellnexxia.net ([209.226.175.119]:51011 "EHLO
	toq12-srv.bellnexxia.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932410AbXAVTx6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jan 2007 14:53:58 -0500
X-Greylist: delayed 1240 seconds by postgrey-1.27 at vger.kernel.org; Mon, 22 Jan 2007 14:53:57 EST
Received: from masella.no-ip.org ([74.14.39.184])
          by tomts10-srv.bellnexxia.net
          (InterMail vM.5.01.06.13 201-253-122-130-113-20050324) with ESMTP
          id <20070122193316.ITBB17401.tomts10-srv.bellnexxia.net@masella.no-ip.org>
          for <git@vger.kernel.org>; Mon, 22 Jan 2007 14:33:16 -0500
Received: by masella.no-ip.org (Postfix, from userid 1003)
	id DAD535034C; Mon, 22 Jan 2007 14:33:14 -0500 (EST)
To: git@vger.kernel.org
User-Agent: KMail/1.9.5
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37441>

I've been using git for a while and really like it, but I have a concern about 
security.

As I understand it, none of the repository backends allow any per-user 
per-branch access control. SSH and HTTP come the closest with the right 
hooks, but since the repository is writeable by those users, there is little 
to stop them from changing the repository directly.

If this is truly the case, I was thinking of creating something similar to 
SVN's Apache plugin to provide more sophisticated access control. I'm leaning 
toward the HTTP remote (transport? backend? What's the right term?) because 
Apache can do many kinds of authentication. I could also make the HTTP less 
dumb, if I had a better idea what that might involve. This could also be a 
way to solve the requests for remote repository creation I see in the survey.

So, before I start, I would like to get ideas from others...or be told this is 
a waste of time. Thanks.
-- 
--Andre Masella (andre at masella.no-ip.org)
