From: "Jason Pyeron" <jpyeron@pdinc.us>
Subject: Trying to understand the web dav details
Date: Sat, 5 Jan 2013 20:32:09 -0500
Organization: PD Inc
Message-ID: <151C51E6FBD848739A43A2C17D78DD68@black>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "'git'" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jan 06 03:09:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Trfg8-0003Wq-Ac
	for gcvg-git-2@plane.gmane.org; Sun, 06 Jan 2013 03:09:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755034Ab3AFCJJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jan 2013 21:09:09 -0500
Received: from projects.pdinc.us ([67.90.184.26]:47201 "EHLO mail.pdinc.us"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754959Ab3AFCJI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jan 2013 21:09:08 -0500
X-Greylist: delayed 1951 seconds by postgrey-1.27 at vger.kernel.org; Sat, 05 Jan 2013 21:09:07 EST
Received: from black (nsa1.pdinc.us [67.90.184.2])
	(authenticated bits=0)
	by mail.pdinc.us (8.12.11.20060308/8.12.11) with ESMTP id r061ZqT9011483
	for <git@vger.kernel.org>; Sat, 5 Jan 2013 20:35:52 -0500
X-Mailer: Microsoft Office Outlook 11
Thread-Index: Ac3rraUwukeVcQcNR7e4aJWGHuRM1w==
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.4913
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212745>

When doing a clone by https (reverse proxied to http) the first request is

GET /git/project/info/refs?service=git-upload-pack

How does the ?service=xxxx get translated in to the action performed on the web
server?

I ask because I have 2 projects, one works the other does not.

I am using httpd-2.0.52-49.ent.centos4 and git-1.7.9.6-1.

I am not even sure what to tell more about or where to look next.

--
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
-                                                               -
- Jason Pyeron                      PD Inc. http://www.pdinc.us -
- Principal Consultant              10 West 24th Street #100    -
- +1 (443) 269-1555 x333            Baltimore, Maryland 21218   -
-                                                               -
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
This message is copyright PD Inc, subject to license 20080407P00.
