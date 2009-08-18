From: "Ferry Huberts" <ferry.huberts@pelagic.nl>
Subject: [MSysGit] Windows & executable bit
Date: Tue, 18 Aug 2009 11:42:03 +0200 (CEST)
Message-ID: <45321.77.61.241.211.1250588523.squirrel@hupie.xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: msysgit@googlegroups.com
X-From: git-owner@vger.kernel.org Tue Aug 18 11:42:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdLCo-0000Tm-8A
	for gcvg-git-2@lo.gmane.org; Tue, 18 Aug 2009 11:42:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753075AbZHRJmG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Aug 2009 05:42:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751559AbZHRJmF
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Aug 2009 05:42:05 -0400
Received: from hupie.xs4all.nl ([82.95.241.251]:56818 "EHLO
	Lighthouse.internal.Hupie.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751111AbZHRJmE (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 18 Aug 2009 05:42:04 -0400
Received: by Lighthouse.internal.Hupie.com (Postfix, from userid 48)
	id 009BD58CA44; Tue, 18 Aug 2009 11:42:03 +0200 (CEST)
Received: from 77.61.241.211
        (SquirrelMail authenticated user ferry.huberts@pelagic.nl)
        by hupie.xs4all.nl with HTTP;
        Tue, 18 Aug 2009 11:42:03 +0200 (CEST)
User-Agent: SquirrelMail/1.4.8-5.el5.centos.7
X-Priority: 3 (Normal)
Importance: Normal
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126364>

Hi list,

Our project is (also) using msysgit.
Recently we changed the permissions on a file
(a Linux shell script) by this (gitk) patch:

----------------------------- xxxx/SQC/SQC.sh -----------------------------
old mode 100644
new mode 100755

We did this on a Linux machine.

Now on a Windows machine we pull in the change:
This causes problems when checking out the branch on which the change was
made: after a checkout the status of SQC.sh is always 'modified' and we can't
convince git to reset it. I actually succeeded _once_ but can not remember how
I did it.
The file is _always_ dirty.

Is this a bug?

I have to note that when I re-clone the repo I don't have the problem. So it
seems to be somewhere in the 'update the working copy' code?


Ferry
