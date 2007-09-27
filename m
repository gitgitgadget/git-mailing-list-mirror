From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: git-quiltimport and non-existent patches
Date: Thu, 27 Sep 2007 11:59:51 +0200 (CEST)
Message-ID: <Pine.LNX.4.62.0709271154440.10467@pademelon.sonytel.be>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-584337861-1371598280-1190887191=:10467"
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
	Geoff Levand <geoffrey.levand@am.sony.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 27 12:00:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IaqA7-00006Z-82
	for gcvg-git-2@gmane.org; Thu, 27 Sep 2007 12:00:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753268AbXI0J7z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Sep 2007 05:59:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753029AbXI0J7z
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Sep 2007 05:59:55 -0400
Received: from vervifontaine.sonytel.be ([80.88.33.193]:60111 "EHLO
	vervifontaine.sonycom.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753142AbXI0J7y (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Sep 2007 05:59:54 -0400
Received: from pademelon.sonytel.be (piraat.sonytel.be [43.221.60.197])
	by vervifontaine.sonycom.com (Postfix) with ESMTP id 1525E58ABD;
	Thu, 27 Sep 2007 11:59:52 +0200 (MEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59278>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---584337861-1371598280-1190887191=:10467
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

	Hi,

Unlike quilt itself, git-quiltimport doesn't ignore non-existent patches.
Instead it bails out badly, leaving a .dotest directory that must be removed
manually. This is with git 1.5.3.2.

It would be nice if git-quiltimport would just warn about non-existent patches,
just like quilt.  This will make it work with `markers' we put in our quilt
series files. Commenting out the markers is no solution as `quilt series'
doesn't show commented-out patches.

Thanks!

With kind regards,
 
Geert Uytterhoeven
Software Architect

Sony Network and Software Technology Center Europe
The Corporate Village · Da Vincilaan 7-D1 · B-1935 Zaventem · Belgium
 
Phone:    +32 (0)2 700 8453	
Fax:      +32 (0)2 700 8622	
E-mail:   Geert.Uytterhoeven@sonycom.com	
Internet: http://www.sony-europe.com/
 	
Sony Network and Software Technology Center Europe	
A division of Sony Service Centre (Europe) N.V.	
Registered office: Technologielaan 7 · B-1840 Londerzeel · Belgium	
VAT BE 0413.825.160 · RPR Brussels	
Fortis Bank Zaventem · Swift GEBABEBB08A · IBAN BE39001382358619
---584337861-1371598280-1190887191=:10467--
