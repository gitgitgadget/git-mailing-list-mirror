From: Heiko Voigt <git-list@hvoigt.net>
Subject: [PATCH v3 0/2] cvsimport: add test illustrating a bug in cvsps
Date: Wed, 18 Mar 2009 18:33:22 +0100
Message-ID: <49C13062.4020400@hvoigt.net>
References: <49A2EFC6.5000104@hvoigt.net> <49A37ED1.5090506@alum.mit.edu> <49AC1E88.1010709@hvoigt.net> <49B4FCDA.4030106@hvoigt.net> <49B52F74.1090006@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, ydirson@altern.org,
	git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Mar 18 18:35:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjzfM-0006pD-Qw
	for gcvg-git-2@gmane.org; Wed, 18 Mar 2009 18:34:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753712AbZCRRd2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Mar 2009 13:33:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753115AbZCRRd1
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Mar 2009 13:33:27 -0400
Received: from darksea.de ([83.133.111.250]:55569 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751361AbZCRRd0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Mar 2009 13:33:26 -0400
Received: (qmail 20237 invoked from network); 18 Mar 2009 18:33:12 +0100
Received: from unknown (HELO macbook.lan) (127.0.0.1)
  by localhost with SMTP; 18 Mar 2009 18:33:12 +0100
User-Agent: Thunderbird 2.0.0.19 (Macintosh/20081209)
In-Reply-To: <49B52F74.1090006@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113632>

This is an updated version of the first patch and an addition to ensure
correct handling of branches in fixes. 

The commit message of the first patch did not describe the problem
correctly. 

The second patch adds branches to the testcase so a possible bugfix in
cvsps can be made sure that it retains a correct ordering on branches. I
would like to keep the commits seperate for a better illustration of the
purpose of this test.

There also a new bugfix for cvsps following this patch series.
