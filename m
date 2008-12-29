From: Thomas Amsler <tpamsler@ucdavis.edu>
Subject: gitweb $export_ok question
Date: Mon, 29 Dec 2008 12:26:02 -0800
Message-ID: <9B3762519053E645820D9CEBD18B3734023A9FBA00@XEDAMAIL2.ex.ad3.ucdavis.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Dec 29 21:40:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LHOuV-0003dG-Gn
	for gcvg-git-2@gmane.org; Mon, 29 Dec 2008 21:40:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753642AbYL2UiV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Dec 2008 15:38:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753595AbYL2UiU
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Dec 2008 15:38:20 -0500
Received: from mx3.ucdavis.edu ([128.120.32.33]:60120 "EHLO mx3.ucdavis.edu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753474AbYL2UiT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 Dec 2008 15:38:19 -0500
X-Greylist: delayed 735 seconds by postgrey-1.27 at vger.kernel.org; Mon, 29 Dec 2008 15:38:18 EST
Received: from exhub.ex.ad3.ucdavis.edu ([169.237.229.110])
	by mx3.ucdavis.edu (8.13.7/8.13.1/it-defang-5.4.0) with ESMTP id mBTKQ2cP027281
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=FAIL)
	for <git@vger.kernel.org>; Mon, 29 Dec 2008 12:26:02 -0800 (PST)
Received: from XEDAMAIL2.ex.ad3.ucdavis.edu ([169.237.229.117]) by
 exhub1.ex.ad3.ucdavis.edu ([169.237.229.110]) with mapi; Mon, 29 Dec 2008
 12:26:02 -0800
Thread-Topic: gitweb $export_ok question
Thread-Index: AQHJafOe/P7RtqWoT0Oz0hRHHfa2cw==
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US
X-Virus-Scanned: ClamAV 0.93.3/8712/Tue Dec  2 09:14:43 2008
	clamav-milter version 0.93.3 on av6
X-Virus-Status: Clean
X-Scanned-By: MIMEDefang 2.57 on 128.120.32.33
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104125>

Hello,

I am trying to get the gitweb $export_ok to  work. According the installation instructions:

Alternatively, you can configure gitweb to only list and allow
viewing of the explicitly exported repositories, via the



GITWEB_EXPORT_OK build configuration variable (or the $export_ok
variable in gitweb config file). If it evaluates to true, gitweb
shows repositories only if this file exists in its object database
(if directory has the magic file named $export_ok).



... I set $export_ok = "true" in my /etc/gitweb.conf file. I don't know what "file" needs to be added to a repository in order for it to show up again in gitweb. I have tried several things, like specifying the file name in /etc/gitweb.con:

$export_ok ="magic-file-name"

etc. but that doesn't seem to work.

What am I doing wrong here?