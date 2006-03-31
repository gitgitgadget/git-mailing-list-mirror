From: "David Ho" <davidkwho@gmail.com>
Subject: Re: Moving a file back to an earlier revision.
Date: Fri, 31 Mar 2006 17:03:45 -0500
Message-ID: <4dd15d180603311403o1f78ee56j707346e887463168@mail.gmail.com>
References: <4dd15d180603311313t7781f2ebk616276e9134f6472@mail.gmail.com>
	 <Pine.LNX.4.64.0603311324040.27203@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 01 00:04:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FPRim-0004id-19
	for gcvg-git@gmane.org; Sat, 01 Apr 2006 00:03:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751395AbWCaWDx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 31 Mar 2006 17:03:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751407AbWCaWDw
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Mar 2006 17:03:52 -0500
Received: from zproxy.gmail.com ([64.233.162.194]:44552 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751395AbWCaWDw convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Mar 2006 17:03:52 -0500
Received: by zproxy.gmail.com with SMTP id k1so983900nzf
        for <git@vger.kernel.org>; Fri, 31 Mar 2006 14:03:45 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=bAJot6irui2pm+hBqlxfy/yEbOOE9IyPC3NrlRF65t+uB5ZZcU8vzVB7rPzaUDJHCJCAiXB91FpHNETUm+VKp1/Ac9Ytk6FFQGQZ+4Z7i5jzw7ba4H/K6cYkPZsKHhjCIbu71sRrAgLEhG3LtK9jsgb6T3OTuCwF6cizKNbM7us=
Received: by 10.64.193.16 with SMTP id q16mr457854qbf;
        Fri, 31 Mar 2006 14:03:45 -0800 (PST)
Received: by 10.65.22.11 with HTTP; Fri, 31 Mar 2006 14:03:45 -0800 (PST)
To: "Linus Torvalds" <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0603311324040.27203@g5.osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18237>

On 3/31/06, Linus Torvalds <torvalds@osdl.org> wrote:
> Don't revert.
>
> Just pick the point you want to start testing his patch at (with gitk, for
> example, just cut-and-paste the sha1), and do
>
>         git checkout -b test-better-fix <sha1>
>
> which creates a new branch ("test-better-fix") that starts at that point,
> and checks it out.

I forget to mention I have also in my branch changes necessary to run
on my board.  So what I did was

git-branch test-better-fix my-branch
git-checkout test-better-fix
git-diff commit(my-fixes)..commit(original) filename | git-apply
git-commit

>
> Then, just apply the patch, and off you go. You now have _both_ his patch
> and your own series in separate branches, so you can cherry-pick and do
> other things (like do a "diff" between branches - which can sometimes be
> useful too to verify that the two branches end up fixing all the same
> problems).
>

Yes, good point.

Thanks, David
