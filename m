From: "Philip Oakley" <philipoakley@iee.org>
Subject: .gitignore for large files?
Date: Sat, 23 Jul 2011 21:00:48 +0100
Organization: OPDS
Message-ID: <B27BF8C0758741A68E1631A7308E17C6@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
To: "Git List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jul 23 22:12:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QkiZA-0003JI-0i
	for gcvg-git-2@lo.gmane.org; Sat, 23 Jul 2011 22:12:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752246Ab1GWUMr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Jul 2011 16:12:47 -0400
Received: from out1.ip01ir2.opaltelecom.net ([62.24.128.237]:64969 "EHLO
	out1.ip01ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751920Ab1GWUMp (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 23 Jul 2011 16:12:45 -0400
X-Greylist: delayed 703 seconds by postgrey-1.27 at vger.kernel.org; Sat, 23 Jul 2011 16:12:45 EDT
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AgkFABwoK05Z8rUp/2dsb2JhbAAsBRMBATQiAQEuAgkDASRFAQEEHgcIJSMCAQIDAYoOnTR4iHYIn3OeWoVgXwSHJpwr
X-IronPort-AV: E=Sophos;i="4.67,253,1309734000"; 
   d="scan'208";a="360097966"
Received: from host-89-242-181-41.as13285.net (HELO PhilipOakley) ([89.242.181.41])
  by out1.ip01ir2.opaltelecom.net with SMTP; 23 Jul 2011 21:00:46 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6109
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177703>

Has there been any discussion in the past on a method for ignoring large 
files via the .gitignore process?

It does appear to be a moderately common problem for folk to accidentally 
commit a large file which bloats their repository and they want rid of it, 
which causes history re-writes and such palaver.

Perhaps a simple '>' and '<' option (the latter to cover null or minimal 
files?) with a --warn postfix may be possible. Just an initial thought.

Where would the 'right place' be for me to look at the git code if it was 
beneficial.

Philip Oakley
(UK: Scotland) 
