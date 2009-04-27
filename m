From: Bob Dobbs <bob@hindbrain.net>
Subject: how to arrange source control?
Date: Mon, 27 Apr 2009 10:45:41 -0400
Message-ID: <20090427144541.GA14698@ralph>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 27 16:56:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LySG5-00072y-6T
	for gcvg-git-2@gmane.org; Mon, 27 Apr 2009 16:56:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755620AbZD0O4Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Apr 2009 10:56:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755502AbZD0O4Y
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Apr 2009 10:56:24 -0400
Received: from iz.toadhaul.org ([68.115.225.206]:47801 "EHLO iz.toadhaul.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755330AbZD0O4X (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Apr 2009 10:56:23 -0400
X-Greylist: delayed 641 seconds by postgrey-1.27 at vger.kernel.org; Mon, 27 Apr 2009 10:56:23 EDT
Received: from ralph (ralph192 [192.168.1.201])
	by iz.toadhaul.org (Postfix) with ESMTP id 5B4513D0108
	for <git@vger.kernel.org>; Mon, 27 Apr 2009 10:45:42 -0400 (EDT)
Received: by ralph (Postfix, from userid 1000)
	id 49EAE36E20B; Mon, 27 Apr 2009 10:45:41 -0400 (EDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117674>


If I have all my (source and executables) under one directory, like:

rootdir
   libs
      lib1
      lib2
      lib3
      ....
   app1
      release
      debug
      data
      ....
   app2
      ....
   app3
      ....
   ....

what is the best way to use git? Should I run "git add ." in 'rootdir' or run it in each application and library? These libraries
are used by all of the applications.

thanks,
Bob
