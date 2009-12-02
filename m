From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: What is the status of merging with whitespace conflicts?
Date: Wed, 2 Dec 2009 11:34:16 +0100
Message-ID: <46a038f90912020234g3094cccbxd8ca80c7c0b32ca4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Dec 02 11:34:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFmXS-00074V-6T
	for gcvg-git-2@lo.gmane.org; Wed, 02 Dec 2009 11:34:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753351AbZLBKeN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Dec 2009 05:34:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753284AbZLBKeM
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Dec 2009 05:34:12 -0500
Received: from mail-bw0-f227.google.com ([209.85.218.227]:50382 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753275AbZLBKeL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Dec 2009 05:34:11 -0500
Received: by bwz27 with SMTP id 27so42757bwz.21
        for <git@vger.kernel.org>; Wed, 02 Dec 2009 02:34:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type;
        bh=goAwTt73wauAFfX+orbf6G5/X5/1ciOcJ2M57XR0+6M=;
        b=AWEgdFTEv6a6wJn3+jtkMHVganb8q+j0cpirPWaNlO8LxPO3/zCkTfZG9mi/327WdJ
         niZp8tJIhhbPaMMRURViOfEUBUjqI+N/cF6hyJDwWHlntslhBkScJ4b8cMgszoPO00mn
         1q7B1qbg8UG56JdLYBC8DBciFNa4EGKRyD26E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=MrAaVk6wdzEKvpIs09gB2rriFZlgm06T+BCFV7+8nK9evPylicSDZvOXqklNimkwAb
         N38ZjUf17JFJWle3xivD7DDqAYIDERE4QlxLVdFYODxVVvExPOLR13j1gNELGQEfyCvg
         Ql0WvbRETHFNca0US6EzU7mTxTnntpUttJGLA=
Received: by 10.204.156.24 with SMTP id u24mr7144263bkw.172.1259750056719; 
	Wed, 02 Dec 2009 02:34:16 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134328>

A project I hack on [Moodle] is relatively lax when it comes to
trailing whitespace (relatively: we clean it up when we spot it,
sometimes ws sneaks in!).

Most of the time, this has no impact. If you have done some whitespace
cleanups on your branch, however, merging from upstream means endless,
pointless conflicts. Looking at the git merge manpage, and searching
the archives doesn't show anything promising.

Perhaps we have a merge tool that makes it easy to spot-and-resolve
pure whitespace conflicts? In the middle of the merge, there _are_
some actual code conflicts, but it's hard to see them...

cheers,


m
-- 
 martin.langhoff@gmail.com
 martin@laptop.org -- School Server Architect
 - ask interesting questions
 - don't get distracted with shiny stuff  - working code first
 - http://wiki.laptop.org/go/User:Martinlanghoff
