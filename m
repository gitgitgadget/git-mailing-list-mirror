From: Niklas Frykholm <niklas@grin.se>
Subject: Cygwin git and windows network shares
Date: Fri, 16 Jun 2006 14:58:34 +0200
Message-ID: <4492AAFA.20807@grin.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri Jun 16 14:57:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FrDtH-0001wq-6u
	for gcvg-git@gmane.org; Fri, 16 Jun 2006 14:57:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751388AbWFPM5c (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Jun 2006 08:57:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751391AbWFPM5c
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Jun 2006 08:57:32 -0400
Received: from ux2.a1.sth.ownit.se ([84.246.88.11]:44771 "EHLO mail.ownit.se")
	by vger.kernel.org with ESMTP id S1751388AbWFPM5b (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 Jun 2006 08:57:31 -0400
Received: from localhost (loopback [127.0.0.1])
	by mail.ownit.se (Postfix) with ESMTP id D6E5C73031
	for <git@vger.kernel.org>; Fri, 16 Jun 2006 14:57:30 +0200 (CEST)
Received: from mail.ownit.se ([127.0.0.1])
 by localhost (mystique.ownit.se [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 19802-01-61 for <git@vger.kernel.org>;
 Fri, 16 Jun 2006 14:57:27 +0200 (CEST)
Received: from [192.168.0.50] (84-55-65-2.rev.sth.ownit.se [84.55.65.2])
	by mail.ownit.se (Postfix) with ESMTP id C5F8673082
	for <git@vger.kernel.org>; Fri, 16 Jun 2006 14:57:25 +0200 (CEST)
User-Agent: Thunderbird 1.5.0.4 (Windows/20060516)
To: git@vger.kernel.org
X-Virus-Scanned: amavisd-new at ownit.nu
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21941>

I'm trying to use cygwin git (compiled from the 1.4.0 tarball) to create 
repository on a windows network share, but I get an error message.

    $ cd //computer/git/project
    $ git init-db
    defaulting to local storage area
    Could not rename the lock file?

The repository seems to be left in an inconsistent state after this:

    $ git clone //computer/git/project/
    fatal: no matching remote head
    fetch-pack from '//computer/git/project/.git' failed.

When working only with local files, I do not get these errors. Does 
anyone know the cause of this error/any way around it?

// Niklas
