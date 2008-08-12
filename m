From: =?ISO-8859-15?Q?Dirk_S=FCsserott?= <newsletter@dirk.my1.cc>
Subject: How to show an annotated tag's timestamp?
Date: Tue, 12 Aug 2008 21:40:41 +0200
Message-ID: <48A1E739.3010803@dirk.my1.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Aug 12 22:29:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KT0U3-0006bn-1F
	for gcvg-git-2@gmane.org; Tue, 12 Aug 2008 22:28:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751155AbYHLU1n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Aug 2008 16:27:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751179AbYHLU1n
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Aug 2008 16:27:43 -0400
Received: from smtprelay08.ispgateway.de ([80.67.29.8]:35485 "EHLO
	smtprelay08.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751007AbYHLU1n (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Aug 2008 16:27:43 -0400
X-Greylist: delayed 2816 seconds by postgrey-1.27 at vger.kernel.org; Tue, 12 Aug 2008 16:27:43 EDT
Received: from [84.176.76.41] (helo=[192.168.2.100])
	by smtprelay08.ispgateway.de with esmtpa (Exim 4.68)
	(envelope-from <newsletter@dirk.my1.cc>)
	id 1KSzjY-00039H-Vd
	for git@vger.kernel.org; Tue, 12 Aug 2008 21:40:45 +0200
User-Agent: Thunderbird 2.0.0.16 (Windows/20080708)
X-Df-Sender: 757646
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92135>

I'd like to display *when* a certain annotated tag was
created, i.e. its timestamp. I know two ways but am looking
for a third one:

Gitk: When clicking the yellow tag item (called 'testtag'
in my case) it says:
-------------
object 9a04a26d3e5ea09be32934f50020d0286ebe7325
type commit
tag testtag
tagger <tagger's name> <tagger's email-address> 1218568300 +0200
-------------
Well, I can convert 1218568300 into some human readable string,
but that's not convenient.

So I tried 'git show testtag'. It says:
-------------
(*) tag testtag
(*) Tagger: <tagger's name> <tagger's email-address>
(*) Date:   Tue Aug 12 21:17:17 2008 +0200
(*)
(*) testtag
commit 0a62b3380d21bf65270490619da4a2efd6d2ca7a
Author: ...
Date:   Thu Apr 24 18:49:38 2008 +0200
[...]
-------------

... followed by the whole commit message and diff of the
commit that's pointed to by the tag. That's too much for
my purpose.

Is there a way to output only when and by whom the tag
was created (incl. the tag's messsage), i.e. the lines
above marked with (*)?

AHA,
   Dirk
