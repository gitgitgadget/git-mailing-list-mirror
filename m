From: Pedro Melo <melo@simplicidade.org>
Subject: Parent-less branches
Date: Fri, 2 May 2008 22:05:01 +0100
Message-ID: <F26CE1A6-FE85-4AC6-BCE6-B41085A09F0F@simplicidade.org>
Mime-Version: 1.0 (Apple Message framework v753)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 02 23:06:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Js2S3-0007r9-Qt
	for gcvg-git-2@gmane.org; Fri, 02 May 2008 23:05:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932562AbYEBVFK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 May 2008 17:05:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932556AbYEBVFK
	(ORCPT <rfc822;git-outgoing>); Fri, 2 May 2008 17:05:10 -0400
Received: from mail.sl.pt ([212.55.140.13]:58471 "EHLO sl.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1763028AbYEBVFJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 May 2008 17:05:09 -0400
Received: (qmail 9104 invoked from network); 2 May 2008 21:05:05 -0000
Received: from unknown (HELO [192.168.1.67]) (melo@[81.193.202.135])
          (envelope-sender <melo@simplicidade.org>)
          by mail-sl (qmail-ldap-1.03) with SMTP
          for <git@vger.kernel.org>; 2 May 2008 21:05:05 -0000
Received-SPF: none (mail-sl: domain of melo@simplicidade.org does not designate permitted sender hosts)
Jabber-Id: melo@simplicidade.org
X-Mailer: Apple Mail (2.753)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81034>

Hi,

inside an existing repository I want to create a new branch without a  
parent commit. Is there a set of commands to do this? Usually only  
the initial commit of a

The idea is to use that branch to track an external source tarball.  
 From time to time, I would checkout the branch and dump a new  
tarball with fresh source code, commit it to the branch and merge  
again with my master.

I could create the setup this setup if I create a separate repo for  
each external source tarball and then fetch them into my main  
repository. But I don't need those repos after that so I'm just  
wondering if there is a way to create the empty branch directly.

Thanks,
-- 
Pedro Melo
Blog: http://www.simplicidade.org/notes/
XMPP ID: melo@simplicidade.org
Use XMPP!
