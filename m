From: "=?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?=" 
	<pclouds@gmail.com>
Subject: pseudo initial empty commit and tag for git-log and git-describe?
Date: Wed, 20 Sep 2006 20:58:15 +0700
Message-ID: <fcaeb9bf0609200658p3f04df7oe91ddb971787bd70@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Wed Sep 20 15:58:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GQ2ap-0006Ws-W3
	for gcvg-git@gmane.org; Wed, 20 Sep 2006 15:58:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751510AbWITN6R (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Sep 2006 09:58:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751514AbWITN6R
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Sep 2006 09:58:17 -0400
Received: from wx-out-0506.google.com ([66.249.82.234]:28628 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751510AbWITN6Q (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Sep 2006 09:58:16 -0400
Received: by wx-out-0506.google.com with SMTP id s9so272688wxc
        for <git@vger.kernel.org>; Wed, 20 Sep 2006 06:58:15 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Z0bOYMLsqk82C5CRB9eOrCSTayfy4QhvLse/BX3QTfK3kTUbzajFSV8YBS4vtQBR8PH8SvLQ5xMeEaJ+SIgIsCzp6qFtdiemExexmiCL10NNppZRvvhhKMSrjG1b34d+ccfcrKsBFZaWEZAHKyhpyXOYcnzcH9koHgCPgi/Z54U=
Received: by 10.70.92.12 with SMTP id p12mr21100581wxb;
        Wed, 20 Sep 2006 06:58:15 -0700 (PDT)
Received: by 10.70.45.19 with HTTP; Wed, 20 Sep 2006 06:58:15 -0700 (PDT)
To: git@vger.kernel.org
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27345>

I'm still uncomfortable with git-log -p unable to show the first
commit (git-whatchanged too). Also git-describe refuses to work
without any tag. I'm thinking about adding a pseudo empty commit
together with a tag so that these commands work. The commit and tag
will be created at runtime. They do not actually exist in the object
database. I haven't thought about how to implement it yet.
Any other ideas?
-- 
Duy
