From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: [Census] So who uses git?
Date: Wed, 1 Feb 2006 15:52:05 +1300
Message-ID: <46a038f90601311852ie8cfac0rbe92779edea4da1b@mail.gmail.com>
References: <46a038f90601251810m1086d353ne8c7147edee4962a@mail.gmail.com>
	 <46a038f90601272133o53438987ka6b97c21d0cdf921@mail.gmail.com>
	 <1138446030.9919.112.camel@evo.keithp.com>
	 <7vzmlgt5zt.fsf@assigned-by-dhcp.cox.net>
	 <1138529385.9919.185.camel@evo.keithp.com>
	 <43DCA495.9040301@gorzow.mm.pl> <20060130225107.GA3857@limbo.home>
	 <Pine.LNX.4.64.0601311314030.7301@g5.osdl.org>
	 <20060131220148.GA19411@steel.home> <20060201013901.GA16832@mail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Alex Riesen <raa.lkml@gmail.com>,
	Linus Torvalds <torvalds@osdl.org>,
	Radoslaw Szkodzinski <astralstorm@gorzow.mm.pl>,
	Keith Packard <keithp@keithp.com>,
	Junio C Hamano <junkio@cox.net>, cworth@cworth.org,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Feb 01 03:52:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F486N-00032T-Mn
	for gcvg-git@gmane.org; Wed, 01 Feb 2006 03:52:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030211AbWBACwI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 31 Jan 2006 21:52:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030217AbWBACwI
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Jan 2006 21:52:08 -0500
Received: from wproxy.gmail.com ([64.233.184.201]:59782 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030211AbWBACwG convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Jan 2006 21:52:06 -0500
Received: by wproxy.gmail.com with SMTP id 71so50045wri
        for <git@vger.kernel.org>; Tue, 31 Jan 2006 18:52:05 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=TaT0lMuo2/IKfv16VbxaGFZbxsvWsus/VJl7Iz1FknHW01CccrwO0hkHT9si3zmbfsl14ZeOiO82Jo8/dTn6mYC259Ud+4f5kidYTMiW8TojZ0nOznGgKx953Unw2KqrONf9PX+7csGaVz1xSi4hSZpWSB7yTAVKunu8CKMib78=
Received: by 10.54.153.5 with SMTP id a5mr10262277wre;
        Tue, 31 Jan 2006 18:52:05 -0800 (PST)
Received: by 10.54.70.12 with HTTP; Tue, 31 Jan 2006 18:52:05 -0800 (PST)
To: Ray Lehtiniemi <rayl@mail.com>
In-Reply-To: <20060201013901.GA16832@mail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15380>

On 2/1/06, Ray Lehtiniemi <rayl@mail.com> wrote:
> by various VAR companies.  the tree in question has ~20,000 files
> totalling nearly 1.4 GB
...
>   reiserfs$ time git update-index --refresh

If you have such a tree, your workflow _must_ be such that you know
exactly what files you have changed. Asking any tool to go out and
"find which of my 20K files has changed" is doable, but it's just
magic that it works on recent linuxes.

> for comparison, one of our sandboxes is sitting on an NTFS file system,
> accessed via SMB:

you have the samba stack, network, SMB/CIFS stack and NTFS itself in
the middle. Replace the ethernet with carrier pigeons for a more
complete picture ;-)

Perhaps a local git/cygwin on NTFS  would be more reasonable to benchmark?

cheers,


martin
