From: E R <pc88mxer@gmail.com>
Subject: keeping track of what a branch is for
Date: Thu, 19 Mar 2009 12:36:44 -0500
Message-ID: <3a69fa7c0903191036u24bbf613had88dbebb24335c4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 19 18:38:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkMCC-0008L6-4K
	for gcvg-git-2@gmane.org; Thu, 19 Mar 2009 18:38:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752762AbZCSRgs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Mar 2009 13:36:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752511AbZCSRgs
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Mar 2009 13:36:48 -0400
Received: from mail-qy0-f118.google.com ([209.85.221.118]:59145 "EHLO
	mail-qy0-f118.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752441AbZCSRgr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Mar 2009 13:36:47 -0400
Received: by qyk16 with SMTP id 16so814941qyk.33
        for <git@vger.kernel.org>; Thu, 19 Mar 2009 10:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=+sNcYMXTXf81uroygGZ3ZXazmAzMTAWVgUW+Bf34mjc=;
        b=efY6fXUrKQ/USgZSg+vnGiOUQ/pbd4ktCMcHEpqwUt/K1ve5L6q+4699zxyEXqChCS
         3JK0wwix6/YZPinjNj7O/jZND8pltOjo0vFDixh4hwnMnWY0VjLQ3y3sS3+Uvz2Mj596
         wsnw/wOsXhzPqBjMxfYnllVVVEwXfpxP1kpqg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=ZM0DcILHDW1zOL7CBMx93DDuwuOFmywzUo10jDTEdxj9cDeGQo0LcEACbLcAshUa0r
         5PhJy5vbN/yxqulMBAoyDi7o6gUczIYvYWa23RM4ojTlO4+MWBh3KrnpJE1JS+G0iP/B
         zZpD9N5Yx7uszMQ4c6EzmLL58IF3bAl3QRxOo=
Received: by 10.220.99.6 with SMTP id s6mr1476338vcn.96.1237484204422; Thu, 19 
	Mar 2009 10:36:44 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113797>

Ok - here's another one...

I've started to create a lot of branches (like one per feature I'm
working on), but I'm starting to have trouble keeping track of what
each branch is for. Also, I'd like to keep track of a todo list for
each branch.

Is there a good way to keep track of these details with git? Using a
repository file kinda works except when merging back into the master
branch.
