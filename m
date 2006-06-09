From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Figured out how to get Mozilla into git
Date: Fri, 9 Jun 2006 14:13:36 -0400
Message-ID: <9e4733910606091113vdc6ab06l2d3582cb82b8fd09@mail.gmail.com>
References: <9e4733910606081917l11354e49q25f0c4aea40618ea@mail.gmail.com>
	 <46a038f90606082006t5c6a5623q4b9cf7b036dad1e5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 09 20:13:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FolUL-000174-4J
	for gcvg-git@gmane.org; Fri, 09 Jun 2006 20:13:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751467AbWFISNi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 9 Jun 2006 14:13:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751446AbWFISNi
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Jun 2006 14:13:38 -0400
Received: from nz-out-0102.google.com ([64.233.162.207]:55323 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751467AbWFISNh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Jun 2006 14:13:37 -0400
Received: by nz-out-0102.google.com with SMTP id s18so1131837nze
        for <git@vger.kernel.org>; Fri, 09 Jun 2006 11:13:36 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=hxgCsvi206JhMzWX249eGhyrrM8BvTqwEBkBgie7t64cNz602yVZxqzn81K1AWub/LE7/jOG/8HXl+rcsz+pp9ZLWokZYX/PsrWvfvprKlKLPRHhFcU/USmQVTXGbAIErYFuJ1rtxs2sx37cvBjlme23JoFwzQNr4bthJpgLpgk=
Received: by 10.37.12.10 with SMTP id p10mr4511547nzi;
        Fri, 09 Jun 2006 11:13:36 -0700 (PDT)
Received: by 10.36.37.15 with HTTP; Fri, 9 Jun 2006 11:13:36 -0700 (PDT)
To: "Martin Langhoff" <martin.langhoff@gmail.com>
In-Reply-To: <46a038f90606082006t5c6a5623q4b9cf7b036dad1e5@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21536>

On 6/8/06, Martin Langhoff <martin.langhoff@gmail.com> wrote:
> mozilla.git$ du -sh .git/
> 2.0G    .git/

That looks too small. My svn git import is 2.7GB and the source CVS is
3.0GB. The svn import wasn't finished when I stopped it.

My cvsps process is still running from last night. The error file is
341MB. How big is it when the conversion is finished? My machine is
swapping to death.

I'm still attracted to the cvs2svn tool. It handled everything right
the first time and it only needs 100MB to run. It is also a lot
faster. cvsps and parsecvs both need gigabytes of RAM to run. I'll
look at cvs2svn some more but I still need to figure out more about
low level git and learn Python.

-- 
Jon Smirl
jonsmirl@gmail.com
