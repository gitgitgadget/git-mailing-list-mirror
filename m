From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Mozilla version control requirements and git
Date: Sun, 3 Sep 2006 21:43:57 -0400
Message-ID: <9e4733910609031843y79750bfcka5f0c350a6b24c9c@mail.gmail.com>
References: <9e4733910609020731k25ce3a0aw7a84542f8cd516f6@mail.gmail.com>
	 <46a038f90609021819v6d427f0eh69bc13b30ef6b692@mail.gmail.com>
	 <9e4733910609022029q9cb9ba9m87cbc37e8d6f4ad7@mail.gmail.com>
	 <ede6in$b9u$1@sea.gmane.org>
	 <9e4733910609030646k6c722068m30f0e05fccc9c3c5@mail.gmail.com>
	 <46a038f90609031440s33e66499x51026aa6062566d2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Jakub Narebski" <jnareb@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 04 03:44:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GK3VS-00021f-K9
	for gcvg-git@gmane.org; Mon, 04 Sep 2006 03:44:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932095AbWIDBn7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 3 Sep 2006 21:43:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932224AbWIDBn7
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Sep 2006 21:43:59 -0400
Received: from py-out-1112.google.com ([64.233.166.179]:2062 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932095AbWIDBn6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Sep 2006 21:43:58 -0400
Received: by py-out-1112.google.com with SMTP id n25so2384384pyg
        for <git@vger.kernel.org>; Sun, 03 Sep 2006 18:43:57 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=CtgV4Xx+lk1s5turHo9BqA/uijmQNbN7xlKgbwfS7Vjvq23AJmt0XtU2NAX2KyZw88gVnpEmq6dQEaQT59e670du1WrV5xscdjRR8A94w5ngMoEuw8LYSuXUFuhwZgRrj7WL9HS/PLxs9ulVRgZrWiO6lmsS04pDtzHFan3o8kE=
Received: by 10.35.65.17 with SMTP id s17mr6531506pyk;
        Sun, 03 Sep 2006 18:43:57 -0700 (PDT)
Received: by 10.35.60.14 with HTTP; Sun, 3 Sep 2006 18:43:57 -0700 (PDT)
To: "Martin Langhoff" <martin.langhoff@gmail.com>
In-Reply-To: <46a038f90609031440s33e66499x51026aa6062566d2@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26395>

On 9/3/06, Martin Langhoff <martin.langhoff@gmail.com> wrote:
> On 9/4/06, Jon Smirl <jonsmirl@gmail.com> wrote:
> > You can't really fake it. Many of the projects in Mozilla are
> > dependent on each other. If you break them up into separate
> > repositories you lose the ability to do a cross project commit. This
> > is common when you are changing an interface between the subprojects.
>
> In many projects this is handled by having tags and generally
> versioning modules and interfaces. Being independent gives the
> subprojects/modules a lot more freedom to work/branch on wild
> tangents, and the versioned interfaces mean that -- with the
> contraints of the versioned interfaces -- you can mix and match
> branches/releases of the different subprojects.
>
> In short, I'd definitely break those up :-)

Mozilla always ships as a complete system so there is no need to deal
with old versions of the pieces. Only the external interfaces are
frozen and versioned. This is similar to the Linux kernel. The user
space API is frozen, but when an internal device driver interface
changes all of the drivers in the kernel tree get updated in lock
step. Doing it this way removes a lot of overhead in maintaining
binary compatibility.

-- 
Jon Smirl
jonsmirl@gmail.com

-- 
VGER BF report: U 0.502564
