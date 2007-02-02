From: Ray Lehtiniemi <rayl@mail.com>
Subject: a slight anomaly in '--unified=0' diff output for one particular
 commit?
Date: Fri, 02 Feb 2007 09:19:31 -0700
Message-ID: <200702020919.31801.rayl@mail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 02 17:26:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HD1F2-00038h-Su
	for gcvg-git@gmane.org; Fri, 02 Feb 2007 17:26:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945972AbXBBQ0U (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Feb 2007 11:26:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945976AbXBBQ0U
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Feb 2007 11:26:20 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:21181 "EHLO
	pd2mo2so.prod.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1945972AbXBBQ0T (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Feb 2007 11:26:19 -0500
Received: from pd5mr4so.prod.shaw.ca
 (pd5mr4so-qfe3.prod.shaw.ca [10.0.141.168]) by l-daemon
 (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
 with ESMTP id <0JCU001MRGAQL4C0@l-daemon> for git@vger.kernel.org; Fri,
 02 Feb 2007 09:25:38 -0700 (MST)
Received: from pn2ml2so.prod.shaw.ca ([10.0.121.146])
 by pd5mr4so.prod.shaw.ca (Sun Java System Messaging Server 6.2-7.05 (built Sep
 5 2006)) with ESMTP id <0JCU00E7ZGAQESW0@pd5mr4so.prod.shaw.ca> for
 git@vger.kernel.org; Fri, 02 Feb 2007 09:25:38 -0700 (MST)
Received: from ray.lehtiniemi.com ([68.147.121.172])
 by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
 with ESMTP id <0JCU008QWG0MYAW1@l-daemon> for git@vger.kernel.org; Fri,
 02 Feb 2007 09:19:34 -0700 (MST)
Received: from linux.local (headplay [68.179.52.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)	by ray.lehtiniemi.com (Postfix)
 with ESMTP id A647325522B	for <git@vger.kernel.org>; Fri,
 02 Feb 2007 09:19:33 -0700 (MST)
Content-disposition: inline
User-Agent: KMail/1.9.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38512>


hi all

i get the same output for both these commands in the git repository using 
v1.5.0-rc3-1-ge4b0e4a. 

  # git show --unified=1 9299c4f147bcff603eef187eb04fe38153571d30
  # git show --unified=0 9299c4f147bcff603eef187eb04fe38153571d30

in both cases, i get the following single line of context at the end of the 
diff:

  glossary.html : glossary.txt sort_glossary.pl


i'm also not sure the numbers in the '@@@' line look correct for 
the 'unified=0' case...



the context at the top of the diff behaves as expected.  i checked a few other 
commits (merge and non-merge types), and they all behaved perfectly with both 
unified settings.  it's just this one commit that seems funny when 
using --unified=0


can anyone reproduce?

ray
