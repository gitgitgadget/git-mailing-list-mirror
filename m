From: "Blucher, Guy" <Guy.Blucher@dsto.defence.gov.au>
Subject: git gui and commit-msg hook
Date: Thu, 17 Jan 2008 09:43:03 +1030
Message-ID: <054F21930D24A0428E5B4588462C7AEDC5F8DC@ednex512.dsto.defence.gov.au>
References: <054F21930D24A0428E5B4588462C7AEDC5F8DB@ednex512.dsto.defence.gov.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jan 17 00:13:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFHS6-00035C-0e
	for gcvg-git-2@gmane.org; Thu, 17 Jan 2008 00:13:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751102AbYAPXNS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2008 18:13:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752299AbYAPXNS
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jan 2008 18:13:18 -0500
Received: from digger1.defence.gov.au ([203.5.217.4]:47663 "EHLO
	digger1.defence.gov.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750858AbYAPXNR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Jan 2008 18:13:17 -0500
Received: from ednmsw511.dsto.defence.gov.au (ednmsw511.dsto.defence.gov.au [131.185.68.12])
	by digger1.defence.gov.au (8.13.8/8.13.8) with ESMTP id m0GNBseb016653
	for <git@vger.kernel.org>; Thu, 17 Jan 2008 09:41:54 +1030 (CST)
Received: from fmbex510.dsto.defence.gov.au (fmbex510.dsto.defence.gov.au) by 
    ednmsw511.dsto.defence.gov.au (Clearswift SMTPRS 5.2.9) with ESMTP id 
    <T84938a1d8183b9440c16d0@ednmsw511.dsto.defence.gov.au> for 
    <git@vger.kernel.org>; Thu, 17 Jan 2008 09:43:05 +1030
Received: from fmbex511.dsto.defence.gov.au ([131.185.134.21]) by 
    fmbex510.dsto.defence.gov.au with Microsoft SMTPSVC(6.0.3790.1830); 
    Thu, 17 Jan 2008 10:13:04 +1100
Received: from ednex514.dsto.defence.gov.au ([131.185.2.174]) by 
    fmbex511.dsto.defence.gov.au with Microsoft SMTPSVC(6.0.3790.1830); 
    Thu, 17 Jan 2008 10:13:04 +1100
Received: from ednex512.dsto.defence.gov.au ([131.185.2.172]) by 
    ednex514.dsto.defence.gov.au with Microsoft SMTPSVC(6.0.3790.1830); 
    Thu, 17 Jan 2008 09:43:03 +1030
Content-class: urn:content-classes:message
X-MimeOLE: Produced By Microsoft Exchange V6.5
In-Reply-To: <054F21930D24A0428E5B4588462C7AEDC5F8DB@ednex512.dsto.defence.gov.au>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: git gui and commit-msg hook sec:u
Thread-Index: AchYjxGgbpdz3VHaSRmMcD0rjMns7wABgLlw
X-OriginalArrivalTime: 16 Jan 2008 23:13:03.0986 (UTC) 
    FILETIME=[58991D20:01C85895]
X-TM-AS-Product-Ver: SMEX-7.0.0.1526-5.0.1023-15672.000
X-TM-AS-Result: No-3.188600-0.000000-31
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70768>

Hi,

Is the commit-msg hook supposed to work when using git gui to do a
commit?

I've just setup a commit-msg hook in my local repository.  It works as
advertised from the command-line when using git commit, but if I use git
gui to do the commit, then the hook is ignored.

I also have a pre-commit hook in my repository which runs fine when
using 'git gui' or 'git commit'.  

All I want to do is verify that the text of a commit message follows
some "corporate standard", perhaps I can do this using the pre-commit
hook instead, but commit-msg seems to be the best fit?  

Regards,
Guy.

IMPORTANT: This email remains the property of the Australian Defence Organisation and is subject to the jurisdiction of section 70 of the CRIMES ACT 1914.  If you have received this email in error, you are requested to contact the sender and delete the email.
