From: "Robin H\. Johnson" <robbat2@gentoo.org>
Subject: git-send-email fixes, cleanups and improvements
Date: Wed, 25 Apr 2007 19:37:14 -0700
Message-ID: <1177555043986-git-send-email-robbat2@gentoo.org>
Cc: Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 26 04:37:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HgtrT-00071Z-62
	for gcvg-git@gmane.org; Thu, 26 Apr 2007 04:37:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750897AbXDZChc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 Apr 2007 22:37:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932753AbXDZChb
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Apr 2007 22:37:31 -0400
Received: from b01.ext.isohunt.com ([208.71.112.51]:56925 "EHLO
	mail.isohunt.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754112AbXDZCh2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Apr 2007 22:37:28 -0400
Received: (qmail 15769 invoked from network); 26 Apr 2007 02:37:27 -0000
Received: from Unknown (HELO curie.orbis-terrarum.net) (24.81.201.182)
  (smtp-auth username robbat2@isohunt.com, mechanism login)
  by mail.isohunt.com (qpsmtpd/0.33-dev on beta01) with (AES256-SHA encrypted) ESMTPSA; Thu, 26 Apr 2007 02:37:27 +0000
Received: (qmail 18799 invoked from network); 25 Apr 2007 19:37:41 -0700
Received: from grubbs-int-e1000.local.orbis-terrarum.net (HELO grubbs-int.orbis-terrarum.net) (172.16.9.4)
  by curie-int-1.local.orbis-terrarum.net with SMTP; 25 Apr 2007 19:37:41 -0700
Received: (nullmailer pid 32441 invoked by uid 0);
	Thu, 26 Apr 2007 02:37:23 -0000
X-Mailer: git-send-email 1.5.2.rc0.43.g2f4c7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45599>

The following series of patches perform a number of fixes, cleanups and
improvements to git-send-email.

These were spurred by the dual factors of git-send-email losing some of my
email due to the envelope sender, as well as the malformatting of the headers
(due to the period after my middle initial) that caused strange breakages with
some sendmail binaries.

01/09  Document --dry-run parameter to send-email.
02/09  Prefix Dry- to the message status to denote dry-runs.
03/09  Debugging cleanup improvements
04/09  Change the scope of the $cc variable as it is not needed outside of send_message.
05/09  Perform correct quoting of recipient names.
06/09  Validate @recipients before using it for sendmail and Net::SMTP.
07/09  Ensure clean addresses are always used with Net::SMTP
08/09  Allow users to optionally specify their envelope sender.
09/09  Document --dry-run and envelope-sender for git-send-email.
