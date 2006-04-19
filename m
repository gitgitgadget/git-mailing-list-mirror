From: "Josh Boyer" <jwboyer@gmail.com>
Subject: Default refspec for branches
Date: Wed, 19 Apr 2006 07:58:58 -0500
Message-ID: <625fc13d0604190558tf0e8b69n5f5a830a3131f1d4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Wed Apr 19 14:59:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FWCGt-0003Wh-Re
	for gcvg-git@gmane.org; Wed, 19 Apr 2006 14:59:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750744AbWDSM7A (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 19 Apr 2006 08:59:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750742AbWDSM7A
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Apr 2006 08:59:00 -0400
Received: from uproxy.gmail.com ([66.249.92.175]:51693 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750749AbWDSM67 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Apr 2006 08:58:59 -0400
Received: by uproxy.gmail.com with SMTP id c2so810517ugf
        for <git@vger.kernel.org>; Wed, 19 Apr 2006 05:58:58 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=fTEi1/oW5+yTMxK/4gkvR0n6RnBXryZgew1Fth+6LUTqIiQVjBkUdw5q7c9e9RttnVkKMegVCA9T2AKOp0GYenvvgI1shOaJ7PnCAyN5TH0KrPr+gUIgYcIky/OJh/TkSmuAcfWsXw5GmydzjeQ+vP63eE3uc1REFx+vFz14F6A=
Received: by 10.78.32.14 with SMTP id f14mr88713huf;
        Wed, 19 Apr 2006 05:58:58 -0700 (PDT)
Received: by 10.78.15.16 with HTTP; Wed, 19 Apr 2006 05:58:58 -0700 (PDT)
To: git@vger.kernel.org
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18922>

Is there a way to change the default refspec that git pull uses on a
per branch basis?  I know that you can create .git/remotes/<foo> and
do 'git pull <foo>' to pull from whatever is listed in there, but that
isn't quite what I'm looking for.

What I'd like to be able to do is create a branch and have 'git pull'
simply pull from the remote tree.  I tried listing multiple refspecs
in .git/remotes/origin, but git didn't seem to like that.

For example, I clone Linus' tree.  Then I create a branch called mtd. 
When I'm working in that branch, I want 'git pull' to pull from
git://git.infradead.org/mtd-2.6.git.

Any ideas?

josh
