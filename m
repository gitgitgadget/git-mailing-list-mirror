From: "Chris Lee" <clee@kde.org>
Subject: Re: Simple UI question...
Date: Sun, 7 Jan 2007 03:38:27 -0800
Message-ID: <204011cb0701070338i5f8a8b4bw8b39050aeb192edb@mail.gmail.com>
References: <204011cb0701070302y54837c5bp967e2cddd3fb655d@mail.gmail.com>
	 <20070107111305.GD10351@spearce.org>
	 <204011cb0701070321w18942a3w7fb4f7ecd26fc457@mail.gmail.com>
	 <20070107112944.GF10351@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jan 07 12:38:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H3WMD-0006bY-VD
	for gcvg-git@gmane.org; Sun, 07 Jan 2007 12:38:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932511AbXAGLi2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 7 Jan 2007 06:38:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932514AbXAGLi2
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Jan 2007 06:38:28 -0500
Received: from wx-out-0506.google.com ([66.249.82.225]:13768 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932511AbXAGLi1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jan 2007 06:38:27 -0500
Received: by wx-out-0506.google.com with SMTP id h27so7678444wxd
        for <git@vger.kernel.org>; Sun, 07 Jan 2007 03:38:27 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=U51RRGdEFOjfa6mibRXoCOBkQuRcZGqWuknGyg/2wbBENKBSd81XVRps1HRM6UJVw2Rqfpw11+T0N6AJohZEf1yvxtvd5Hg6XEXyJ9cLxc/cqWCrG+aJUrKPQtFxmzV2p5DszcRUZKx4Y7TCxT2Ka1XU0E3z0jq1rjb3h1HpC0U=
Received: by 10.90.29.2 with SMTP id c2mr1489029agc.1168169907376;
        Sun, 07 Jan 2007 03:38:27 -0800 (PST)
Received: by 10.90.81.19 with HTTP; Sun, 7 Jan 2007 03:38:27 -0800 (PST)
To: "Shawn O. Pearce" <spearce@spearce.org>
In-Reply-To: <20070107112944.GF10351@spearce.org>
Content-Disposition: inline
X-Google-Sender-Auth: 46d67da77228e0dc
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36163>

On 1/7/07, Shawn O. Pearce <spearce@spearce.org> wrote:
> Chris Lee <clee@kde.org> wrote:
> > I assume 'removing everything in the working tree' counts as "local
> > modifications"? :)
>
> Yes!  That's what's going wrong.  Don't do "rm -rf *".  Let Git take
> care of the empty directories for you.  If Git deletes all source
> files in that directory (as they don't belong in this version that
> you are checking out) it will also delete the now empty directory.
>
> The only time it fails is if you are on Windows and some process
> has the directory busy.  :-)

So, if I were starting with an empty working directory, and I had just
synced over the .git folder from the place where I'm doing the actual
importing - how would I populate the working directory with a copy of
the contents of the tree from (say)
07058310db903317faa300b93004a5a2e0fc2dcc ?
