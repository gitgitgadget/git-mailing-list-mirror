From: Joshua Stoutenburg <jehoshua02@gmail.com>
Subject: New setup, trying to clone . . .
Date: Thu, 15 Sep 2011 23:59:30 -0700
Message-ID: <CAOZxsToJk45UHGAuno-r=B76+SUg5icbYvUsY5EfgcGv_UkxHg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Sep 16 08:59:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R4SOg-0002ag-CF
	for gcvg-git-2@lo.gmane.org; Fri, 16 Sep 2011 08:59:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752909Ab1IPG7d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Sep 2011 02:59:33 -0400
Received: from mail-ew0-f43.google.com ([209.85.215.43]:45011 "EHLO
	mail-ew0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751394Ab1IPG7c (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Sep 2011 02:59:32 -0400
Received: by ewy20 with SMTP id 20so2438631ewy.2
        for <git@vger.kernel.org>; Thu, 15 Sep 2011 23:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=UuhaOwxpJ0dKB5yqnu2ONh4UTlcmzCk8hRYjAnyWns4=;
        b=C967ONikmyTrgr7KfgJJr4oip27R6iXOM29ShERyf4kvBqw8Vzvp28p0PXzy/d6wED
         DINhj3Cf2dDmcaYvtmPEuEvwSJwqI8Pl2xPyfw7FUluQm/8FKN7tiX/MlWBrCYiXcbDL
         BgxUFhLwQEWlYFWsoIx9G5tif7SfWcSQqKmfc=
Received: by 10.213.3.153 with SMTP id 25mr791694ebn.15.1316156370449; Thu, 15
 Sep 2011 23:59:30 -0700 (PDT)
Received: by 10.213.16.195 with HTTP; Thu, 15 Sep 2011 23:59:30 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181527>

Hey guys,

I'm following these instructions:  http://progit.org/book/ch4-4.html

Everything has gone fine up until about halfway down the page, where it says:

>  At this point, the others can clone it down and push changes back up just as easily:
>  $ git clone git@gitserver:/opt/git/project.git

Of course, replacing [git@gitserver:/opt/git/project.git] according to
my setup, and I change directory to an empty directory apart from the
original project, then I try the command, I get the following output:

At this point, the others can clone it down and push changes back up
just as easily:

$ git clone gituser@192.168.1.102:/git/project.git
Cloning into project...
Connection closed by 192.168.1.102
fatal: The remote end hung up unexpectedly

Any ideas what's going on here?
