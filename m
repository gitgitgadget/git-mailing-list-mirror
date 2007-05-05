From: Guido Ostkamp <git@ostkamp.fastmail.fm>
Subject: Git branch bug
Date: Sat, 5 May 2007 18:24:03 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0705051823300.13988@bianca.dialin.t-online.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 05 18:37:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HkNGV-0005G7-3e
	for gcvg-git@gmane.org; Sat, 05 May 2007 18:37:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934044AbXEEQhn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 5 May 2007 12:37:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933262AbXEEQhn
	(ORCPT <rfc822;git-outgoing>); Sat, 5 May 2007 12:37:43 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:42185 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S934044AbXEEQhn (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 5 May 2007 12:37:43 -0400
X-Greylist: delayed 815 seconds by postgrey-1.27 at vger.kernel.org; Sat, 05 May 2007 12:37:43 EDT
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id E486721E69F
	for <git@vger.kernel.org>; Sat,  5 May 2007 12:24:29 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Sat, 05 May 2007 12:24:07 -0400
X-Sasl-enc: Lvpfo+6mx1lmGb4dLB6t7OvTAARpjzz9VKYKSBu3ScMU 1178382247
Received: from [192.168.2.101] (p549A01CD.dip0.t-ipconnect.de [84.154.1.205])
	by mail.messagingengine.com (Postfix) with ESMTP id 42D44137EF
	for <git@vger.kernel.org>; Sat,  5 May 2007 12:24:07 -0400 (EDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46263>

Hello,

I would like to report the following bug:

$ mkdir test
$ cd test
$ git init
Initialized empty Git repository in .git/
$ git branch experimental
fatal: Not a valid object name: 'master'.

So, it seems it is not possible to create a named branch on an empty 
repository.

I'm not subscribed to the list, so please keep me directly on CC for any 
reply, thanks.

Regards

Guido
