From: Christoph Bartoschek <bartoschek@gmx.de>
Subject: Migrating from SVN
Date: Mon, 22 Mar 2010 11:18:18 +0100
Organization: =?UTF-8?B?VW5pdmVyc2l0w6R0?= Bonn
Message-ID: <aosj77-m7e.ln1@burns.bruehl.pontohonk.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 22 11:23:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ntemz-0004qs-7o
	for gcvg-git-2@lo.gmane.org; Mon, 22 Mar 2010 11:23:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753839Ab0CVKXL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Mar 2010 06:23:11 -0400
Received: from lo.gmane.org ([80.91.229.12]:53677 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752867Ab0CVKXK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Mar 2010 06:23:10 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Ntemp-0004m5-Mf
	for git@vger.kernel.org; Mon, 22 Mar 2010 11:23:07 +0100
Received: from bg-1.or.uni-bonn.de ([131.220.141.100])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 22 Mar 2010 11:23:07 +0100
Received: from bartoschek by bg-1.or.uni-bonn.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 22 Mar 2010 11:23:07 +0100
X-Injected-Via-Gmane: http://gmane.org/
Followup-To: gmane.comp.version-control.git
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: bg-1.or.uni-bonn.de
User-Agent: KNode/4.3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142914>

Hi,

we consider migrating from Subversion to Git. However we are not sure how to 
cleanly migrate the history from Subversion to Git. Till now we have such a 
structure in a single Subversion repository:

project_A
project_B
project_C
project_D
project_E

Via svn:externals we form two products:

product_1/project_A
          project_B
          project_C

product_2/project_B
          project_C
          project_D
          project_E

Now we are merging both products into one such that the structure should be 

product/project_A
        project_B
        project_C
        project_D
        project_E

I think this makes migration to Git easier as we can now work with only one 
Git repository. We also circumvent the usage of the unmature submodule 
support in Git.

How can I now import our Subversion projects into the Git repository such 
that for each project the history is kept and ideally the whole history is 
linearized by the subversion revision numbers?

Thanks
Christoph
