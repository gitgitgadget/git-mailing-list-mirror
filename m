From: "Stefan Pfetzing" <stefan.pfetzing@gmail.com>
Subject: Re: [osol-bugs] access() behaves strange when used as root
Date: Wed, 24 May 2006 16:08:21 +0200
Message-ID: <f3d7535d0605240708k7e55cc3fu8c2e8ad744f738c9@mail.gmail.com>
References: <f3d7535d0605230818l6ecb9b87gd38afc75941c5fdd@mail.gmail.com>
	 <20060523153415.GB3638@greyarea>
	 <20060523154213.GB21587@totally.trollied.org>
	 <f3d7535d0605231035p6e2d8ef8qefefe43a8b11e739@mail.gmail.com>
	 <44734FCC.6040709@sun.com>
	 <f3d7535d0605232220g402f7df0xb82d6afeb6b226fd@mail.gmail.com>
	 <447460C1.6070305@sun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Wed May 24 16:09:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fiu2Q-0006KN-O0
	for gcvg-git@gmane.org; Wed, 24 May 2006 16:08:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932308AbWEXOIX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 24 May 2006 10:08:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932309AbWEXOIX
	(ORCPT <rfc822;git-outgoing>); Wed, 24 May 2006 10:08:23 -0400
Received: from wr-out-0506.google.com ([64.233.184.238]:56444 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932308AbWEXOIW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 24 May 2006 10:08:22 -0400
Received: by wr-out-0506.google.com with SMTP id 69so1579915wra
        for <git@vger.kernel.org>; Wed, 24 May 2006 07:08:21 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=I0IfIPg6w1qvkiv0tAP2KuC4iwk0gB2r4maBf+1gUH85q2A9+aMVcBxW81u4DxMEqxbK0FB9cVq14CmcHEfrmn+NJMkHxVSBTuJC6D0M5TVMsBoSAt45VTMtB41PeRyB5mLqrGfsv8Z37uJJcZjp803N5eL93d2a8jBnjcVTupE=
Received: by 10.64.83.10 with SMTP id g10mr3734243qbb;
        Wed, 24 May 2006 07:08:21 -0700 (PDT)
Received: by 10.64.253.10 with HTTP; Wed, 24 May 2006 07:08:21 -0700 (PDT)
To: "Git Mailing List" <git@vger.kernel.org>
In-Reply-To: <447460C1.6070305@sun.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20687>

Hi Alan,

2006/5/24, Alan Coopersmith <Alan.Coopersmith@sun.com>:

> Compilers also fall in the class of things I've never understood why
> people would ever run as root.   Far too complex and completely unnecessary.
> "make all" as a normal user, and then if you absolutely must, "make install"
> as root.  (After running "make -n install" first to see what it will do.)

Yes thats completely true, but it still leaves the point if you want
to manage some
of your config files with git.

bye

Stefan

-- 
       http://www.dreamind.de/
Oroborus and Debian GNU/Linux Developer.
