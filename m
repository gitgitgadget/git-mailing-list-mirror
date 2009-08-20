From: Marco Gualtieri <mgualt@math.utoronto.ca>
Subject: gitweb and symbolic links
Date: Wed, 19 Aug 2009 21:15:10 -0400
Message-ID: <2367E9DF-6FB1-48E6-AC9A-73E84C9D54E1@math.utoronto.ca>
Mime-Version: 1.0 (Apple Message framework v935.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 20 03:39:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdwcK-0000vQ-2n
	for gcvg-git-2@lo.gmane.org; Thu, 20 Aug 2009 03:39:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753834AbZHTBiw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Aug 2009 21:38:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753688AbZHTBiw
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Aug 2009 21:38:52 -0400
Received: from mail.math.toronto.edu ([128.100.68.68]:46045 "EHLO
	mail.math.toronto.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753693AbZHTBiv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Aug 2009 21:38:51 -0400
X-Greylist: delayed 1420 seconds by postgrey-1.27 at vger.kernel.org; Wed, 19 Aug 2009 21:38:51 EDT
Received: from mail.math.toronto.edu (localhost.localdomain [127.0.0.1])
	by localhost (Postfix) with SMTP id E28F41180D5
	for <git@vger.kernel.org>; Wed, 19 Aug 2009 21:15:11 -0400 (EDT)
Received: from [192.168.2.38] (bas15-toronto63-1279272099.dsl.bell.ca [76.64.36.163])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: mgualt)
	by mail.math.toronto.edu (Postfix) with ESMTP id 9A1AD1180CB
	for <git@vger.kernel.org>; Wed, 19 Aug 2009 21:15:11 -0400 (EDT)
X-Mailer: Apple Mail (2.935.3)
X-PMX-Version: 5.5.4.371499, Antispam-Engine: 2.7.1.369594, Antispam-Data: 2009.8.20.10317
X-PMX-Spam: Gauge=IIIIIIII, Probability=8%, Report='
 BODY_SIZE_1000_LESS 0, BODY_SIZE_2000_LESS 0, BODY_SIZE_300_399 0, BODY_SIZE_5000_LESS 0, BODY_SIZE_7000_LESS 0, RDNS_BROADBAND 0, RDNS_POOLED 0, RDNS_SUSP 0, RDNS_SUSP_SPECIFIC 0, TO_NO_NAME 0, __CT 0, __CTE 0, __CT_TEXT_PLAIN 0, __HAS_MSGID 0, __HAS_X_MAILER 0, __MIME_TEXT_ONLY 0, __MIME_VERSION 0, __MSGID_APPLEMAIL 0, __RDNS_BROADBAND_2 0, __RDNS_POOLED_5 0, __SANE_MSGID 0, __TO_MALFORMED_2 0'
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126601>

Hello,

I am wondering about a possibly easy bug which you may be aware of.

For some reason if I place a symbolic link in a directory under the  
project root,  gitweb is no longer able to find the project.  I was  
looking through the .cgi file but I don't know enough perl to fix the  
problem myself.

Let me know if this makes sense.
Cheers
Marco
