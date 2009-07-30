From: Vlad Didenko <vdidenko@Getcollc.com>
Subject: Exclude a directory while merging
Date: Thu, 30 Jul 2009 07:12:24 -0500
Message-ID: <C696F858.CEB0%vdidenko@Getcollc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jul 30 14:18:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MWUa9-0003tv-Lj
	for gcvg-git-2@gmane.org; Thu, 30 Jul 2009 14:18:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751620AbZG3MRx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Jul 2009 08:17:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751483AbZG3MRw
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Jul 2009 08:17:52 -0400
Received: from itxmail01.getcollc.com ([66.250.141.200]:2906 "EHLO
	itxmail01.getco.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751439AbZG3MRw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 30 Jul 2009 08:17:52 -0400
X-Greylist: delayed 323 seconds by postgrey-1.27 at vger.kernel.org; Thu, 30 Jul 2009 08:17:52 EDT
Received: from ITXMAIL02.getco.com ([10.100.128.52]) by itxmail01.getco.com
 ([10.100.128.51]) with mapi; Thu, 30 Jul 2009 07:12:27 -0500
Thread-Topic: Exclude a directory while merging
Thread-Index: AcoRDv8RIoJc3GtnYkGANk1mYFJPQw==
Accept-Language: en-US
Content-Language: en
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124460>

Colleagues,

Is there an easy way to exclude a directory from a merge operation.
Specifically:

We have a "master" branch. We also have an "other" branch. There is a
directory XYZ in the other branch which is not in the master. I need to
merge everything but XYZ into master. Something like that:

git checkout master
git merge other --exclude XYZ

Is that possible?

Thank you!
Vlad


This e-mail and its attachments are intended only for the individual or entity to whom it is addressed and may contain information that is confidential, privileged, inside information, or subject to other restrictions on use or disclosure. Any unauthorized use, dissemination or copying of this transmission or the information in it is prohibited and may be unlawful. If you have received this transmission in error, please notify the sender immediately by return e-mail, and permanently delete or destroy this e-mail, any attachments, and all copies (digital or paper). Unless expressly stated in this e-mail, nothing in this message should be construed as a digital or electronic signature.
