From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: New version of gitk
Date: Fri, 13 May 2005 01:06:18 +0200
Message-ID: <81b0412b050512160664965bfd@mail.gmail.com>
References: <17026.43676.670725.66502@cargo.ozlabs.ibm.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 13 00:59:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DWMdk-0001wt-0d
	for gcvg-git@gmane.org; Fri, 13 May 2005 00:58:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262175AbVELXG1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 May 2005 19:06:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262177AbVELXG0
	(ORCPT <rfc822;git-outgoing>); Thu, 12 May 2005 19:06:26 -0400
Received: from wproxy.gmail.com ([64.233.184.202]:65096 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262175AbVELXGU convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2005 19:06:20 -0400
Received: by wproxy.gmail.com with SMTP id 68so868947wra
        for <git@vger.kernel.org>; Thu, 12 May 2005 16:06:18 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=tCmaq458/Mvh4XwqThg3gjoCaoWAgCVRh6bcN60eksUnb4JadovkJMsXYPV8A7o4HBnUs1IK6tDZ02WZKS8UbY8pJFvJEF8tFqgW5PE7pkNScLDmYipvlGQgGI2Vym/jlP/u7RvPJ/1C8F01hKeb0g3+Ku/YCCIwiVrw4auILog=
Received: by 10.54.48.24 with SMTP id v24mr1240783wrv;
        Thu, 12 May 2005 16:06:18 -0700 (PDT)
Received: by 10.54.79.20 with HTTP; Thu, 12 May 2005 16:06:18 -0700 (PDT)
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <17026.43676.670725.66502@cargo.ozlabs.ibm.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On 5/12/05, Paul Mackerras <paulus@samba.org> wrote:
> I have just put a new version of gitk at:
> 
>         http://ozlabs.org/~paulus/gitk-0.9
> 

Very, very nice and useful. Thank you!

Btw, how does the tree look like with unconnected (unmerged) branches?
And the case where Linus just pointed HEAD to most recent commit?

There are some confusing interconnections in the tree, like around this commit:
"Author: David Woodhouse <dwmw2@shinybook.infradead.org>  2005-05-05 14:59:37
Committer: David Woodhouse <dwmw2@shinybook.infradead.org>  2005-05-05 14:59:37

Merge with master.kernel.org:/pub/scm/linux/kernel/git/torvalds/linux-2.6.git"
(Maybe show sha1's, just for reference?)

And I got the error below trying to run gitk in kernel git (latest).
Probably because I
closed window before the script finished something.

Error in startup script: invalid command name ".ctop.clist.canv"
    while executing
"$canv create line $x $linestarty($level) $x $canvy  -width 2 -fill
$colormap($id)"
    (procedure "drawgraph" line 40)
    invoked from within
"drawgraph $start" 
    invoked from within
"if {$start != {}} {
    drawgraph $start
}"
    (file "/home/raa/bin/gitk" line 703)

--
Alex
