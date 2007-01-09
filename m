From: "Guilhem Bonnefille" <guilhem.bonnefille@gmail.com>
Subject: Re: Howto use StGit and git-svn at same time
Date: Tue, 9 Jan 2007 22:41:20 +0100
Message-ID: <8b65902a0701091341v5983c113tc5cd32c6c4c57719@mail.gmail.com>
References: <8b65902a0701091335u160c6dfl81a523e4cd5adbee@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Jan 09 22:41:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4Oii-00077l-Pz
	for gcvg-git@gmane.org; Tue, 09 Jan 2007 22:41:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932368AbXAIVlW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 Jan 2007 16:41:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932402AbXAIVlW
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jan 2007 16:41:22 -0500
Received: from wr-out-0506.google.com ([64.233.184.236]:15300 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932368AbXAIVlV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jan 2007 16:41:21 -0500
Received: by wr-out-0506.google.com with SMTP id i21so3080520wra
        for <git@vger.kernel.org>; Tue, 09 Jan 2007 13:41:21 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=htWdNn7tmK/4dtubgeSjrlx6U/rwnVB9zP0Co2AlKQp1qkqlDuXeUldFPNuyFFiBf/xxtUtYImewf4P0HjOdU2M0Ct9mh3W+fc1oOod7O3HhEcTg/iFaULiQ804NN+5cENFY41/yDznVqDploUMMO7Ud9I7AqBh1RfU64EmsZPI=
Received: by 10.90.29.2 with SMTP id c2mr3395617agc.1168378880803;
        Tue, 09 Jan 2007 13:41:20 -0800 (PST)
Received: by 10.90.51.4 with HTTP; Tue, 9 Jan 2007 13:41:20 -0800 (PST)
To: git@vger.kernel.org
In-Reply-To: <8b65902a0701091335u160c6dfl81a523e4cd5adbee@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36408>

Humh...
I finished the conflicts solving game. I think the way I choosed is
incorrect. Following gitk, it is now a big big bazaar in my commits
history.

Can you give me some tips about using both git-svn and stgit please?

On 1/9/07, Guilhem Bonnefille <guilhem.bonnefille@gmail.com> wrote:
> Hi,
>
> I'm a newbie and I'm using:
> - git-svn to connect to a public SVN repo,
> - StGit to manage my patches for the project hosted by this repo.
>
> The current GIT repo was previously cloned from a GIT repo made with
> git-cvsimport. But the project moved to SVN, so I removed the GIT repo
> connected to the CVS.
>
> I succesfully fetch the SVN, create a "work" local branch (connected
> to remotes/trunk), and create some patches.
> As the SVN evolved, I wish to retrieve info and update my patches.
>
> So I tried a "stg pull" whihc failed because "origin" no more exists.
> So, I tried a "git-rebase remotes/trunk".
> Is it correct?
>
> I'm actually unable to conclude, as the maintainer apply my patches
> with some improves, so I have to solve lots of conflicts. But I would
> appreciate if you can confirm me that the git-rebase is the good way
> to update a "workspace" managed both by git-svn and StGit.
>
> --
> Guilhem BONNEFILLE
> -=- #UIN: 15146515 JID: guyou@im.apinc.org MSN: guilhem_bonnefille@hotmail.com
> -=- mailto:guilhem.bonnefille@gmail.com
> -=- http://nathguil.free.fr/
>


-- 
Guilhem BONNEFILLE
-=- #UIN: 15146515 JID: guyou@im.apinc.org MSN: guilhem_bonnefille@hotmail.com
-=- mailto:guilhem.bonnefille@gmail.com
-=- http://nathguil.free.fr/
