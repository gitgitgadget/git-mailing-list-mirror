From: "Eric Jaffe" <jaffe.eric@gmail.com>
Subject: git-status too verbose?
Date: Sat, 4 Mar 2006 12:52:17 -0500
Message-ID: <38b80e980603040952j15152a21h2c903bd011d7e905@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Sat Mar 04 18:52:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FFavZ-0001eF-H4
	for gcvg-git@gmane.org; Sat, 04 Mar 2006 18:52:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932245AbWCDRwT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Mar 2006 12:52:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932263AbWCDRwT
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Mar 2006 12:52:19 -0500
Received: from nproxy.gmail.com ([64.233.182.203]:9400 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932245AbWCDRwT convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Sat, 4 Mar 2006 12:52:19 -0500
Received: by nproxy.gmail.com with SMTP id l37so650627nfc
        for <git@vger.kernel.org>; Sat, 04 Mar 2006 09:52:17 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=IJeLQFTCxTgiq3D03oR2xgnQOyLSmeoBsUp8ARWhKLK00Z7kRtJ8x5+4bIxyQnQN7PhOlWl44at/gfIp9eoy1bbE99TR+aZmguopt9omwGU7JPwWY9YQLqZfVsMC0jBA9iAejY7ZG+x0/UH6O4s+IiOFuoZln53+QtP3te+7ay0=
Received: by 10.48.3.15 with SMTP id 15mr1633483nfc;
        Sat, 04 Mar 2006 09:52:17 -0800 (PST)
Received: by 10.48.247.7 with HTTP; Sat, 4 Mar 2006 09:52:17 -0800 (PST)
To: git@vger.kernel.org
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17191>

I was wondering if anyone else thinks that git-status should be more
like "git-diff --name-status". That is,
  # A a/newfile.c
  # M a/oldfile.c

instead of
  # new file: a/newfile.c
  # modified: a/oldfile.c

This would be similar to cg-status and "svn status", etc.

--
Eric Jaffe <jaffe.eric@gmail.com>
