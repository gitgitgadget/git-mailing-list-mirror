From: Nate Parsons <parsons.nate@gmail.com>
Subject: git-svn error
Date: Thu, 23 Sep 2010 10:30:22 -0400
Message-ID: <AANLkTi=5ficziLK8cfikotoxkgUDLfhAM_RLzCOcOv5U@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Thu Sep 23 16:31:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oymp1-00064X-4a
	for gcvg-git-2@lo.gmane.org; Thu, 23 Sep 2010 16:30:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755545Ab0IWOap (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Sep 2010 10:30:45 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:39198 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751576Ab0IWOap (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Sep 2010 10:30:45 -0400
Received: by iwn5 with SMTP id 5so1530446iwn.19
        for <git@vger.kernel.org>; Thu, 23 Sep 2010 07:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:from:date
         :message-id:subject:to:content-type;
        bh=WyS00C+qLxZxg29ffCt6Eetd3I8WQUdl0wCdCTUnU9A=;
        b=hhin2Wh28kTxd5hx/ucj5uJzQ55Nl0X08USG1hN+ZN5UlZzlmaV4JBMi4pdaQjsi1U
         39eLtpDP1FZIzlxulB6uJANOzlZNVx25PK3HDb5YocfaHCl+YJ6iyeciYnSdKa1HwQAs
         CcwaCPSV5fGxJPaHwwSrADcCC1RzPtRlH++j0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        b=ZUigysZ12SWFdn+LX3XhpRPGsj9koMW88ezpxewhPonG97sQWvdi1m48k/fJB+6Hjh
         65JJ76NYjmFzvimGMa1pyZQIfaOwQq7hKZ8fTyzA6/lbsEyANrcSbpLq9waYiudqp5Ay
         UKzWigQEk09t6I3v5hd9r4a/3uyTdtDrF/tjo=
Received: by 10.231.14.8 with SMTP id e8mr2183920iba.16.1285252243348; Thu, 23
 Sep 2010 07:30:43 -0700 (PDT)
Received: by 10.231.113.141 with HTTP; Thu, 23 Sep 2010 07:30:22 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156871>

Hi all,

I'm experiencing an error message importing a new svn repository using
cygwin git, version 1.7.2.3

> fatal: refs/remotes/trunk: not a valid SHA1
> update-ref refs/heads/master refs/remotes/trunk: command returned error: 128

My .git/config file (nothing looks amiss to me):
[core]
	repositoryformatversion = 0
	filemode = true
	bare = false
	logallrefupdates = true
	ignorecase = true
[svn-remote "svn"]
	url = <redacted>
	fetch = iem/procedures/iem:refs/remotes/trunk
	branches = iem/procedures/Z_Folders/*:refs/remotes/*

It appears that this error was seen before in an older version that
didn't deal with extra "/"s appropriately, but I don't see that issue
here.

Thanks,
-Nate
