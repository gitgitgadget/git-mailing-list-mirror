From: Chas Emerick <cemerick@snowtide.com>
Subject: Shallow submodule update/clone?
Date: Mon, 19 Jan 2009 11:59:53 -0500
Message-ID: <78F609E2-8FB4-452B-A54D-2929710E6773@snowtide.com>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 19 18:19:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOxm0-00069y-I4
	for gcvg-git-2@gmane.org; Mon, 19 Jan 2009 18:18:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752755AbZASRR2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Jan 2009 12:17:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752740AbZASRR2
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Jan 2009 12:17:28 -0500
Received: from smtp172.iad.emailsrvr.com ([207.97.245.172]:40325 "EHLO
	smtp172.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752656AbZASRR1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Jan 2009 12:17:27 -0500
X-Greylist: delayed 1043 seconds by postgrey-1.27 at vger.kernel.org; Mon, 19 Jan 2009 12:17:27 EST
Received: from relay7.relay.iad.mlsrvr.com (localhost [127.0.0.1])
	by relay7.relay.iad.mlsrvr.com (SMTP Server) with ESMTP id BB9451DDA36
	for <git@vger.kernel.org>; Mon, 19 Jan 2009 12:00:02 -0500 (EST)
Received: by relay7.relay.iad.mlsrvr.com (Authenticated sender: cemerick-AT-snowtide.com) with ESMTPSA id 8001B1DA248
	for <git@vger.kernel.org>; Mon, 19 Jan 2009 12:00:02 -0500 (EST)
X-Mailer: Apple Mail (2.930.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106367>

Is there a way to cause 'git submodule update' to perform a shallow  
clone of some or all of a repo's submodules?

Ideally, I'd like to be able to specify that particular submodules be  
shallowly cloned all the time (perhaps by specifying a default --depth  
when doing 'git submodule add ...').  Just an idea, there.

Cheers,

- Chas
