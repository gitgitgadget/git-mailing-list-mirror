From: Thomas Koch <thomas@koch.ro>
Subject: intend-to-edit flag
Date: Thu, 04 Jul 2013 19:56:40 +0200
Message-ID: <2240842.MQEMCLPV8Z@x121e>
Reply-To: thomas@koch.ro
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 04 19:56:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uunlz-0001nL-0j
	for gcvg-git-2@plane.gmane.org; Thu, 04 Jul 2013 19:56:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756886Ab3GDR4r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Jul 2013 13:56:47 -0400
Received: from koch.ro ([88.198.2.104]:38254 "EHLO koch.ro"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756626Ab3GDR4q (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Jul 2013 13:56:46 -0400
Received: from 44-25.106-92.cust.bluewin.ch ([92.106.25.44] helo=x121e.localnet)
	by koch.ro with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:256)
	(Exim 4.80)
	(envelope-from <thomas@koch.ro>)
	id 1Uunlt-0006eb-6m
	for git@vger.kernel.org; Thu, 04 Jul 2013 19:56:45 +0200
User-Agent: KMail/4.10.4 (Linux/3.9-1-amd64; KDE/4.10.4; x86_64; ; )
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229603>

Hi,

we're evaluating Git to be used in our companies Tool. But a hard requirement 
is the possibility to set an "intend-to-edit" flag on a file (better path).
Notice that I did not use the word "lock"! :-)

One easy implementation might be a special branch "XYZ-locks" that contains an 
empty blob for every flagged file. So our tool just needs to check, whether a 
blob exists for the path that's intended to edit, tries to push a commit that 
touches the file and only allows editing if the push succeeds.

Does anybody have a better idea, maybe with notes?

Thank you,

Thomas Koch, http://www.koch.ro
