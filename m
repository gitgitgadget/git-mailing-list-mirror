From: Jan Weitzel <J.Weitzel@phytec.de>
Subject: git fetch refs and tags
Date: Tue, 23 Apr 2013 12:53:41 +0200
Organization: PHYTEC Messtechnik GmbH
Message-ID: <1366714421.2899.10.camel@lws-weitzel>
Reply-To: J.Weitzel@phytec.de
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: sitaramc@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 23 13:03:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUb0k-0008Cw-6F
	for gcvg-git-2@plane.gmane.org; Tue, 23 Apr 2013 13:03:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755426Ab3DWLDm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Apr 2013 07:03:42 -0400
Received: from mail.x-arc.de ([217.6.246.34]:52305 "EHLO root.phytec.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755006Ab3DWLDl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Apr 2013 07:03:41 -0400
X-Greylist: delayed 597 seconds by postgrey-1.27 at vger.kernel.org; Tue, 23 Apr 2013 07:03:41 EDT
Received: from idefix.phytec.de (idefix.phytec.de [172.16.0.10])
	by root.phytec.de (Postfix) with ESMTP id 467D3BF0EC;
	Tue, 23 Apr 2013 12:52:10 +0200 (CEST)
Received: from [172.16.10.7] ([127.0.0.1])
          by idefix.phytec.de (Lotus Domino Release 8.5.3FP3)
          with ESMTP id 2013042312531624-164750 ;
          Tue, 23 Apr 2013 12:53:16 +0200 
X-Mailer: Evolution 3.2.3-0ubuntu6 
X-MIMETrack: Itemize by SMTP Server on Idefix/Phytec(Release 8.5.3FP3|November 15, 2012) at
 23.04.2013 12:53:16,
	Serialize by Router on Idefix/Phytec(Release 8.5.3FP3|November 15, 2012) at
 23.04.2013 12:53:16,
	Serialize complete at 23.04.2013 12:53:16
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222141>

Hello,
I have the following problem: I have 2 bare git repositories one has
several branches and tags.
If I try this in the second repository:
git fetch -f ../main.git refs/heads/master:refs/heads/master 
I'm getting also tags from other branches, if I have an old object from
one of the other branches.
I would expect to have only tags pointing to master ref. (Although the
man pages points to the behaviour regarding dangling objects). Is there
a way to avoid this? I only find --no-tags which results in having no
tags at all. Or need I git purge to remove the old objects first?
My goal is to fetch only specific branches and the related tags.

Jan
