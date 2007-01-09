From: "Guilhem Bonnefille" <guilhem.bonnefille@gmail.com>
Subject: Howto use StGit and git-svn at same time
Date: Tue, 9 Jan 2007 22:35:21 +0100
Message-ID: <8b65902a0701091335u160c6dfl81a523e4cd5adbee@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Jan 09 22:35:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4Ocv-0005UI-Cs
	for gcvg-git@gmane.org; Tue, 09 Jan 2007 22:35:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932451AbXAIVfX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 Jan 2007 16:35:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932452AbXAIVfX
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jan 2007 16:35:23 -0500
Received: from wr-out-0506.google.com ([64.233.184.224]:12806 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932451AbXAIVfW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jan 2007 16:35:22 -0500
Received: by wr-out-0506.google.com with SMTP id i21so3076457wra
        for <git@vger.kernel.org>; Tue, 09 Jan 2007 13:35:21 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=M7BMI4Mk0bpXqf3UrzpQdswq7K7rVYteGzknNKO7SLaIbmpDhsIwzxSClBRHOke7gYA0YvUbIn+p87BDT+zIsU9u4CmBCIiFqtpJ4Di3QrKQsbG43ARe5tdXe4IBT7G+vnIOp6OtxqE6vyA+tspGn0902cUlX0JTGo/oMQbx9r8=
Received: by 10.90.100.2 with SMTP id x2mr3503334agb.1168378521469;
        Tue, 09 Jan 2007 13:35:21 -0800 (PST)
Received: by 10.90.51.4 with HTTP; Tue, 9 Jan 2007 13:35:21 -0800 (PST)
To: git@vger.kernel.org
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36406>

Hi,

I'm a newbie and I'm using:
- git-svn to connect to a public SVN repo,
- StGit to manage my patches for the project hosted by this repo.

The current GIT repo was previously cloned from a GIT repo made with
git-cvsimport. But the project moved to SVN, so I removed the GIT repo
connected to the CVS.

I succesfully fetch the SVN, create a "work" local branch (connected
to remotes/trunk), and create some patches.
As the SVN evolved, I wish to retrieve info and update my patches.

So I tried a "stg pull" whihc failed because "origin" no more exists.
So, I tried a "git-rebase remotes/trunk".
Is it correct?

I'm actually unable to conclude, as the maintainer apply my patches
with some improves, so I have to solve lots of conflicts. But I would
appreciate if you can confirm me that the git-rebase is the good way
to update a "workspace" managed both by git-svn and StGit.

-- 
Guilhem BONNEFILLE
-=- #UIN: 15146515 JID: guyou@im.apinc.org MSN: guilhem_bonnefille@hotmail.com
-=- mailto:guilhem.bonnefille@gmail.com
-=- http://nathguil.free.fr/
