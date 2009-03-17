From: Steve Wagner <lists@lanwin.de>
Subject: .gitk should created hidden in windows
Date: Tue, 17 Mar 2009 14:45:30 +0100
Message-ID: <49BFA97A.1030203@lanwin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Tue Mar 17 15:06:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjZvb-0007tN-9h
	for gcvg-git-2@gmane.org; Tue, 17 Mar 2009 15:05:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751703AbZCQOEa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Mar 2009 10:04:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751512AbZCQOEa
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Mar 2009 10:04:30 -0400
Received: from lanwin.de ([77.37.16.229]:54591 "EHLO vs5923.vserver4free.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751290AbZCQOE3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Mar 2009 10:04:29 -0400
X-Greylist: delayed 1100 seconds by postgrey-1.27 at vger.kernel.org; Tue, 17 Mar 2009 10:04:29 EDT
Received: from [10.10.11.46] (unknown [213.61.128.220])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by vs5923.vserver4free.de (Postfix) with ESMTP id 81AF9253DF;
	Tue, 17 Mar 2009 14:46:05 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; de; rv:1.8.1.19) Gecko/20081209 Lightning/0.9 Thunderbird/2.0.0.19 Mnenhy/0.7.6.666
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113471>

Hi Paul, i write this to the git mailing list because of the advice from
 Johannes Schindelin in the MSysGit Issue:

http://code.google.com/p/msysgit/issues/detail?id=143

The problem is that windows dose not hides files beginning with a dot as
it is in unix. So the .gitk file is created as visible in the windows
user profile. Problematic too is that i can no set the hidden attribute
to this file, because it is recreated every time i start gitk, so the
hidden attribute gets lost.

Can you control this and create the file with the hidden attribute on
windows?

Steve
