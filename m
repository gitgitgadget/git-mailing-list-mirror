From: alan <alan@clueserver.org>
Subject: Git Subversion problem
Date: Wed, 24 Jan 2007 09:40:27 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0701240935330.3282@blackbox.fnordora.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 24 18:40:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H9m6s-0000MA-GN
	for gcvg-git@gmane.org; Wed, 24 Jan 2007 18:40:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752051AbXAXRk3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 24 Jan 2007 12:40:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752056AbXAXRk3
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Jan 2007 12:40:29 -0500
Received: from 216-99-213-120.dsl.aracnet.com ([216.99.213.120]:46648 "EHLO
	clueserver.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752051AbXAXRk2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jan 2007 12:40:28 -0500
Received: by clueserver.org (Postfix, from userid 500)
	id A704AF50C92; Wed, 24 Jan 2007 09:40:27 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by clueserver.org (Postfix) with ESMTP id A2A76F508EC
	for <git@vger.kernel.org>; Wed, 24 Jan 2007 09:40:27 -0800 (PST)
X-X-Sender: alan@blackbox.fnordora.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37661>

I think I tracked down where my problem with using Git to pull subversion 
repositories came from.

It seems that if the repository has a file larger than what will fit in 
memory, it does not react well.  (Yes, I know that you should not check in 
huge data files into a repository, but accidents happen and Subversion 
does not make it easy to remove them.)

I can work around the problem at the moment, but it may be something that 
the person who maintains that chunk of git may want to look at.

-- 
"Invoking the supernatural can explain anything, and hence explains nothing."
                   - University of Utah bioengineering professor Gregory Clark
