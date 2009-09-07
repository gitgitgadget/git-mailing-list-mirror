From: "Dave Rodgman" <dav1dr@eml.cc>
Subject: git rebase --interactive problems
Date: Mon, 07 Sep 2009 13:31:56 +0100
Message-ID: <1252326716.7497.1333578429@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 07 14:33:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MkdOA-0006Ys-QK
	for gcvg-git-2@lo.gmane.org; Mon, 07 Sep 2009 14:32:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753193AbZIGMb4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Sep 2009 08:31:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753176AbZIGMb4
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Sep 2009 08:31:56 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:39240 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753088AbZIGMbz (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Sep 2009 08:31:55 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 9DE7469173
	for <git@vger.kernel.org>; Mon,  7 Sep 2009 08:31:56 -0400 (EDT)
Received: from web6.messagingengine.com ([10.202.2.215])
  by compute2.internal (MEProxy); Mon, 07 Sep 2009 08:31:56 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:from:to:mime-version:content-transfer-encoding:content-type:subject:date; s=smtpout; bh=xQW/CebJSG0wgK/f197og6AS3Zk=; b=Gcw4cOxmq2WLz0CTU2KVweaxVr18yKLtkQRZ7VKw0SWDIKK1K0XT30qYqDyxwHQIjfi0EJk2Go7F/kstWuaefgVGXlFquqMBRS1zOYlZhIrFt4CW1z/fm0e9WBRbN8CViezXytuLK9ylr9P1OhDpEDW1DvbIrI85ZPAbYvJqifA=
Received: by web6.messagingengine.com (Postfix, from userid 99)
	id 5B19F3B26F; Mon,  7 Sep 2009 08:31:56 -0400 (EDT)
X-Sasl-Enc: Mo5C3ito5NdBmUJMeKvjM4gXHHOKjwCxprBra125I1Ia 1252326716
X-Mailer: MessagingEngine.com Webmail Interface
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127923>

When I try to do even the simplest rebase --interactive, I get a cryptic
error message:

$ git rebase -i HEAD~2
<do nothing in the editor that appears, just save>

I then get:

/usr/lib/git-core/git-rebase--interactive: 1: arithmetic expression:
expecting primary: "-c ^[^#]
2+-c ^[^#]
0"

and all I can do is git rebase --abort

Am I doing something wrong, or is this a bug? I am using git 1.6.4.2

thanks

Dave
