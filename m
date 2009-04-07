From: Joerg Bornemann <joerg.bornemann@web.de>
Subject: Re: [PATCH] git-gui: fix use of undeclared variable diff_empty_count
Date: Tue, 07 Apr 2009 10:07:02 +0200
Message-ID: <49DB09A6.1070403@web.de>
References: <49DA5F20.4030800@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 07 10:09:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lr6Mn-0001jB-SD
	for gcvg-git-2@gmane.org; Tue, 07 Apr 2009 10:09:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752045AbZDGIHi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Apr 2009 04:07:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751458AbZDGIHh
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Apr 2009 04:07:37 -0400
Received: from smtp.nokia.com ([192.100.122.233]:52329 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751244AbZDGIHf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Apr 2009 04:07:35 -0400
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id n3787L28004033
	for <git@vger.kernel.org>; Tue, 7 Apr 2009 11:07:26 +0300
Received: from esebh102.NOE.Nokia.com ([172.21.138.183]) by esebh105.NOE.Nokia.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 7 Apr 2009 11:07:02 +0300
Received: from mgw-int02.ntc.nokia.com ([172.21.143.97]) by esebh102.NOE.Nokia.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 7 Apr 2009 11:07:01 +0300
Received: from [172.25.167.38] (bett-ws014.europe.nokia.com [172.25.167.38])
	by mgw-int02.ntc.nokia.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id n3786xkG027001
	for <git@vger.kernel.org>; Tue, 7 Apr 2009 11:07:00 +0300
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <49DA5F20.4030800@web.de>
X-OriginalArrivalTime: 07 Apr 2009 08:07:01.0888 (UTC) FILETIME=[D4E98000:01C9B757]
X-Nokia-AV: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115928>

This bug occurs with msysgit under mysterious circumstances. We have at
least two Windows machines where "git diff" works correctly but "git 
gui" is unable to get the actual diffs. Before commit 584fa9cc, git gui 
favoured the user with an infinite message box loop. This is what 
584fa9cc should've fixed: display a nice message to the user. Instead I 
see the Tcl error message box, complaining about the missing variable 
diff_empty_count.
