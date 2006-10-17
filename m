From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: VCS comparison table
Date: Tue, 17 Oct 2006 08:17:39 +0700
Message-ID: <fcaeb9bf0610161817tc521f8dmc815623b60c27afc@mail.gmail.com>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com>
	 <45340713.6000707@utoronto.ca>
	 <Pine.LNX.4.64.0610161625370.3962@g5.osdl.org>
	 <200610170155.10536.jnareb@gmail.com>
	 <Pine.LNX.4.63.0610170157270.14200@wbgn013.biozentrum.uni-wuerzburg.de>
	 <Pine.LNX.4.64.0610161714590.3962@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Oct 17 03:17:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZdad-0005oB-Ee
	for gcvg-git@gmane.org; Tue, 17 Oct 2006 03:17:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030198AbWJQBRl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Oct 2006 21:17:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030200AbWJQBRl
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Oct 2006 21:17:41 -0400
Received: from wx-out-0506.google.com ([66.249.82.236]:29648 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1030198AbWJQBRk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Oct 2006 21:17:40 -0400
Received: by wx-out-0506.google.com with SMTP id h28so2071322wxd
        for <git@vger.kernel.org>; Mon, 16 Oct 2006 18:17:40 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ED7qwkN9UixVyCpUd4yBh3tKrO4s0DBBU7gtH0N6q+QP7ogYnqT/t9UT2L2i6tdNS1lktMuSliNf+vAHykA3c4WJ/pawldHLCVzWAyIYhuWQjS/JiplGEBY0770fRNvmlfHTndtL6MmxBDPpHGCe2u7YL2tV1f7tB2Myq4hWvqE=
Received: by 10.70.117.3 with SMTP id p3mr12622421wxc;
        Mon, 16 Oct 2006 18:17:39 -0700 (PDT)
Received: by 10.70.46.13 with HTTP; Mon, 16 Oct 2006 18:17:39 -0700 (PDT)
To: git@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0610161714590.3962@g5.osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29011>

On 10/17/06, Linus Torvalds <torvalds@osdl.org> wrote:
> So then you can do just
>
>         git cat todo:TODO
>
> and you're done.
>
> [ So for the non-git people, what that will actually _do_ is to show the
>   TODO file in the "todo" branch - regardless of whether it is checked out
>   or not, and start a pager for you. ]
>
> I actually do this sometimes, but I've never done it for branches (and I
> do it seldom enough that I haven't added the alias). I do it for things
> like
>
>         git cat v2.6.16:Makefile
>
> to see what a file looked like in a certain tagged release.

This very useful syntax (<ent>:<path>) didn't get documented
"officially" anywhere. It was actually documented in commit log
v1.4.1^0~255^2. Maybe someone should copy and paste it to git
documentation? Maybe core-tutorial.txt or git-rev-parse.txt, is there
any better place?
-- 
Duy
