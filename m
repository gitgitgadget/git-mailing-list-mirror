From: Dennis Huynh <dennis@brainstorm-digital.com>
Subject: problems installing git docs and gitweb on centos 5.5
Date: Wed, 29 Sep 2010 22:03:18 -0400
Message-ID: <4CA3EFE6.2010306@brainstorm-digital.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org, security@centos.org
X-From: git-owner@vger.kernel.org Thu Sep 30 04:17:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P18hs-00068u-60
	for gcvg-git-2@lo.gmane.org; Thu, 30 Sep 2010 04:17:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752440Ab0I3CRG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Sep 2010 22:17:06 -0400
Received: from omr12.networksolutionsemail.com ([205.178.146.62]:54922 "EHLO
	omr12.networksolutionsemail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751770Ab0I3CRF (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 Sep 2010 22:17:05 -0400
X-Greylist: delayed 823 seconds by postgrey-1.27 at vger.kernel.org; Wed, 29 Sep 2010 22:17:03 EDT
Received: from cm-omr7 (mail.networksolutionsemail.com [205.178.149.5] (may be forged))
	by omr12.networksolutionsemail.com (8.13.6/8.13.6) with ESMTP id o8U23IeD001727
	for <git@vger.kernel.org>; Wed, 29 Sep 2010 22:03:18 -0400
Authentication-Results: cm-omr7 smtp.user=dennis@brainstorm-digital.com; auth=pass (CRAM-MD5)
X-Authenticated-UID: dennis@brainstorm-digital.com
Received: from [38.117.157.152] ([38.117.157.152:4163] helo=[192.168.1.119])
	by cm-omr7 (envelope-from <dennis@brainstorm-digital.com>)
	(ecelerity 2.2.2.41 r(31179/31189)) with ESMTPA
	id 98/4A-02440-6EFE3AC4; Wed, 29 Sep 2010 22:03:18 -0400
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; en-US; rv:1.9.1.5) Gecko/20091204 Thunderbird/3.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157626>

Am I the only one having issues installing git docs?  I had the man 
pages installed perfect yesterday, but having so much trouble getting 
gitweb installed, I decided to start a build from scratch today and for 
the life of me cannot get the man pages installed again.  I do a yum 
update on my OS and when I go to install the dependencies I run into 
conflicts with python libraries.  I remove the python library and 
reinstall and yum stops complaining.  I then 'make install-doc' again 
and get an 'nbsp' not defined error.  I have everything installed I had 
yesterday when the man pages were installed successfully.  What changed 
from then until now?  I'm running CentOS 5.5 and git 1.7.3.  Am I the 
only one having these problems?  Is this a CentOS repository problem?

Also, is there anywhere I can get better documentation on installing 
gitweb and gitosis running properly?  If not, is there anything I can do 
to gain the experience that would assist me in better understanding this 
documentation.  I've been supporting linux for 8+ years now and cannot 
wrap my head around how to make this happen.  I've tried every tutorial 
on the web that would ease my experience in setting up the source and am 
reading the docs that come wrapped in the git source package over and 
over again.  I'd really hate to have to resort to SVN or CVS because my 
development team would like a subversion system up asap.  Please help!  
Much appreciated, and thanks for understanding.
