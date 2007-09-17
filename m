From: "pradeep singh" <pradeep.rautela@gmail.com>
Subject: Re: Git pull fails on a repository > 1.5G.
Date: Mon, 17 Sep 2007 15:09:44 +0530
Message-ID: <a901b49a0709170239t39123a27t3ff3462855c7eb57@mail.gmail.com>
References: <a901b49a0709170159g477525bcr5383a1a051ae5e3d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Dhirendra Singh Kholia" <dhiru.kholia@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 17 11:39:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXD54-0005x1-AI
	for gcvg-git-2@gmane.org; Mon, 17 Sep 2007 11:39:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752869AbXIQJjq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2007 05:39:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752724AbXIQJjq
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Sep 2007 05:39:46 -0400
Received: from py-out-1112.google.com ([64.233.166.182]:34416 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753021AbXIQJjp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2007 05:39:45 -0400
Received: by py-out-1112.google.com with SMTP id u77so3049467pyb
        for <git@vger.kernel.org>; Mon, 17 Sep 2007 02:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=Y178YwQyo5Ix7fOynkiJd81KNMcCRv5vLgQ5GH3GGa4=;
        b=XLmTmCbYlMB9nfAElWmq8KQLCsyxOxiJmbekJZ2R2porJkwDy+8xXuWdOliuWsv8CRlTA1YFEhs2XNhl+cQamXnJZs565IbtxJ+tD8ayF66OXJtBkjJE6MiEj3JHv4/fGiRzHyfWss74OXIxlHfu/1TEQfjMOqlJ1wTOq/mH+WQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=KoRqA1IoYFfOPi07iGONT7JzDXBUNm3bDCY7QzvbcoAmmvA3E1X8y4AadankHG2yfzUQn/b76AqMkR0yvxWg1vMUn8omXAcFC4oezcQiZNMbTiWmsvuawQGwUlXSlutFlUx6/TqzhdkMBRttxqjGX791RjidMWqqEK+G3L34cb8=
Received: by 10.35.96.6 with SMTP id y6mr6075267pyl.1190021984834;
        Mon, 17 Sep 2007 02:39:44 -0700 (PDT)
Received: by 10.35.93.15 with HTTP; Mon, 17 Sep 2007 02:39:44 -0700 (PDT)
In-Reply-To: <a901b49a0709170159g477525bcr5383a1a051ae5e3d@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58410>

PS:- please CC me , as i am not subscribed to git list.
On 9/17/07, pradeep singh <pradeep.rautela@gmail.com> wrote:
> Hi All,
>
> I am using git at work for a rather big repository. Size is around
> 1.5-1.8Gigs now.
> My git version is 1.5.2.4.
>
> The remote repo has some changes to a file with some simple printk's
> some some code changes.
>
> I have my git repo in /mnt/reiser/project .
>
> I changed to the my repo.
>
> i did a git-pull ssh://user1@10.100.205.34/opt/test/project test .[to
> pull from another test machine].
>
> I got some conflicts in a file but in some important files it did not update it.
>
> Any hints whats wrong with my technique or is there something wrong with git?

Just to add.
If i pull tags with
$git-pull ssh://user1@10.100.205.34/opt/test/project test
i get them.
doing a git-merge v-1.0b does not reflect any changes but a git-branch
new_test v-1.0b makes new_test branch which has the changes.
Again git-merge new_test fails miserably, it says no conflicts though
there are conflicts.

What is happening here? :-/

I am puzzled.
Can anybody please help me???

thanks

-- 
Pradeep
