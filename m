From: "McKown, John" <John.McKown@healthmarkets.com>
Subject: three questions: proper forum? & reverting changes to the working
 directory
Date: Thu, 8 Nov 2012 08:26:22 -0600
Message-ID: <A6B9336CDB62BB46B9F8708E686A7EA0115BAA1404@NRHMMS8P02.uicnrh.dom>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: "'git@vger.kernel.org'" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Nov 08 15:31:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TWT97-0007u2-0k
	for gcvg-git-2@plane.gmane.org; Thu, 08 Nov 2012 15:31:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756066Ab2KHObf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Nov 2012 09:31:35 -0500
Received: from mail1.healthmarkets.com ([75.31.122.33]:5815 "EHLO
	NRHMED8P01.healthmarkets.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755695Ab2KHObd convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Thu, 8 Nov 2012 09:31:33 -0500
X-Greylist: delayed 309 seconds by postgrey-1.27 at vger.kernel.org; Thu, 08 Nov 2012 09:31:33 EST
Received: from NRHMHB8P01.uicnrh.dom (10.174.7.30) by mail1.healthmarkets.com
 (10.173.1.33) with Microsoft SMTP Server (TLS) id 8.2.255.0; Thu, 8 Nov 2012
 08:26:22 -0600
Received: from NRHMMS8P02.uicnrh.dom ([fe80::b1b1:4330:ff7f:383b]) by
 NRHMHB8P01.uicnrh.dom ([::1]) with mapi; Thu, 8 Nov 2012 08:26:23 -0600
Thread-Topic: three questions: proper forum? & reverting changes to the
 working directory
Thread-Index: Ac29vQb60XfBIAuuTyGvdLgb1cKcig==
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209159>

1) is this the proper forum for asking general git usage questions, such as "how to"? If not, what is?

2) I am unsure that I did things the "proper" way. I have a git maintained subdirectory. I made some changes and saved them in the working directory, but did not "git add" or "git commit" them. I then decided that I really messed up what I was doing (basically reformatting some source code). So to revert the changes back to what was last committed, I did a "git reset --hard HEAD". I think this is the proper way. But I picked up that command in the section of the documentation which was talking about abandoning a "git merge" attempt. What I did worked, but is it the proper way? If not, what is? 

3) More generically, suppose I have a file in my working directory that I want to put back the way it was "n" commits ago. The best that I can see, so far, is "git show HEAD~n:file >|file", replacing the "n" and "file" with appropriate values. 

-- 
John McKown
Systems Engineer IV
IT

Administrative Services Group

HealthMarkets(r)

9151 Boulevard 26 * N. Richland Hills * TX 76010
(817) 255-3225 phone *
john.mckown@healthmarkets.com * www.HealthMarkets.com

Confidentiality Notice: This e-mail message may contain confidential or proprietary information. If you are not the intended recipient, please contact the sender by reply e-mail and destroy all copies of the original message. HealthMarkets(r) is the brand name for products underwritten and issued by the insurance subsidiaries of HealthMarkets, Inc. -The Chesapeake Life Insurance Company(r), Mid-West National Life Insurance Company of TennesseeSM and The MEGA Life and Health Insurance Company.SM
