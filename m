From: "Ron Parker" <ron.parker@mobot.org>
Subject: RE: git as a backup tool?
Date: Mon, 14 May 2007 17:53:15 -0500
Message-ID: <769697AE3E25EF4FBC0763CD91AB1B0201D496EA@MBGMail01.mobot.org>
References: <Pine.LNX.4.64.0705141334120.20215@anakin>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
To: "Geert Uytterhoeven" <geert@linux-m68k.org>, <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 15 00:53:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HnjPw-0007jI-Cm
	for gcvg-git@gmane.org; Tue, 15 May 2007 00:53:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755004AbXENWxU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 May 2007 18:53:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755554AbXENWxU
	(ORCPT <rfc822;git-outgoing>); Mon, 14 May 2007 18:53:20 -0400
Received: from mbgmail01.mobot.org ([63.78.97.14]:37904 "EHLO
	mbgmail01.mobot.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755004AbXENWxT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 May 2007 18:53:19 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
In-Reply-To: <Pine.LNX.4.64.0705141334120.20215@anakin>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: git as a backup tool?
Thread-Index: AceWHe5DK4A/2YauTPGmTqBmPaCDXQAW8JMg
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47299>


> Geert Uytterhoeven wrote:

> Has anyone considered using git as a backup tool?  I.e.

At the very least you would have a lot of chgrp/chown work to do after a
"restore".  Git stores file mode, but not ownership information, ACL's
or extended attributes.

I found this out when I tried using git to backup part of BOINC
development server.  Various files and directories had to have different
ownership and extended attributes (for SELinux).
-- 
Ron Parker
