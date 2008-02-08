From: Paul Gardiner <osronline@glidos.net>
Subject: Any tricks for speeding up cvsps?
Date: Fri, 08 Feb 2008 09:24:44 +0000
Message-ID: <47AC1FDC.9000502@glidos.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 08 10:25:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNPUE-00007B-QU
	for gcvg-git-2@gmane.org; Fri, 08 Feb 2008 10:25:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759195AbYBHJYz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Feb 2008 04:24:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756558AbYBHJYz
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Feb 2008 04:24:55 -0500
Received: from mk-outboundfilter-1.mail.uk.tiscali.com ([212.74.114.37]:55445
	"EHLO mk-outboundfilter-1.mail.uk.tiscali.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752662AbYBHJYx (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 Feb 2008 04:24:53 -0500
X-Trace: 36483533/mk-outboundfilter-1.mail.uk.tiscali.com/PIPEX/$MX-ACCEPTED/pipex-infrastructure/62.241.162.32
X-SBRS: None
X-RemoteIP: 62.241.162.32
X-IP-MAIL-FROM: osronline@glidos.net
X-IP-BHB: Once
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Ao8CAH6uq0c+8aIg/2dsb2JhbACsCg
X-IP-Direction: IN
Received: from ranger.systems.pipex.net ([62.241.162.32])
  by smtp.pipex.tiscali.co.uk with ESMTP; 08 Feb 2008 09:24:50 +0000
Received: from [10.0.0.24] (80-42-19-184.dynamic.dsl.as9105.com [80.42.19.184])
	by ranger.systems.pipex.net (Postfix) with ESMTP id A9E62E000099
	for <git@vger.kernel.org>; Fri,  8 Feb 2008 09:24:47 +0000 (GMT)
User-Agent: Thunderbird 2.0.0.9 (Windows/20071031)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73057>

Hi,

I'm trying to convert a huge cvs repository. I've left cvsps running for 
days. First attempt, stderr filled my disc with warnings about tags that
couldn't be associated with any one commit, without producing anything
from stdout. I'm now redirecting stderr to /dev/null, but it still just
sits there producing nothing.  Is git-cvsimport infeasible for large
repositories, or are there tricks I might use?

P.
