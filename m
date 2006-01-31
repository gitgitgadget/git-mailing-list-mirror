From: Franck <vagabon.xyz@gmail.com>
Subject: Re: [RFC] shallow clone
Date: Tue, 31 Jan 2006 09:37:38 +0100
Message-ID: <cda58cb80601310037s58989b26s@mail.gmail.com>
References: <7voe1uchet.fsf@assigned-by-dhcp.cox.net>
	 <Pine.LNX.4.63.0601301220420.6424@wbgn013.biozentrum.uni-wuerzburg.de>
	 <43DDFF5C.30803@hogyros.de> <7v64o18qn4.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Simon Richter <Simon.Richter@hogyros.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 31 09:38:00 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F3r1F-0007mh-Tq
	for gcvg-git@gmane.org; Tue, 31 Jan 2006 09:37:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030369AbWAaIhj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 31 Jan 2006 03:37:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965059AbWAaIhj
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Jan 2006 03:37:39 -0500
Received: from zproxy.gmail.com ([64.233.162.197]:26358 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965055AbWAaIhj convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Jan 2006 03:37:39 -0500
Received: by zproxy.gmail.com with SMTP id 14so1251905nzn
        for <git@vger.kernel.org>; Tue, 31 Jan 2006 00:37:38 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=LVAwGVbSXVUMQd14cl7B+KgwlQA5A8wVW0S6ZcVfeh5ypKggwUmjlMHucFwmWxbd+kb3WAztSdupKYvKsR4En3ErGNncUBh3xVdhboi3UvWaymcMbPD5ZoZccszqfZjLcGd4kXcVcLf5WGByPH7d3E63S+EgHRZ4YzjWmrfGsIw=
Received: by 10.37.13.2 with SMTP id q2mr5527021nzi;
        Tue, 31 Jan 2006 00:37:38 -0800 (PST)
Received: by 10.36.49.12 with HTTP; Tue, 31 Jan 2006 00:37:38 -0800 (PST)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v64o18qn4.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15303>

2006/1/30, Junio C Hamano <junkio@cox.net>:
> Simon Richter <Simon.Richter@hogyros.de> writes:
>
> >> - disallow fetching from this repo, and
> >
> > Why? It's perfectly acceptable to pull from an incomplete repo, as
> > long as you don't care about the old history.
>
> I agree.  As long as the cloned one can record itself as a
> shallow one (and with what epochs), I do not see a reason to
> forbid second generation clone from a shallow repository.
>

I agree too

> Cauterizing is not any more special than other grafts entries.
> If you have grafted historical kernel repository behind the
> official kernel repository with 2.6.12-rc2 epoch, I do not think
> of any reason to forbid people from cloning such with the
> grafts.
>

I built my public repository from a cautorized one and everybody who
is pulling from mine is aware of the lack of the full history but they
actually don't care. If someone is pulling from my repo, he actually
wants to work on my project which do not need any old thing...

Thanks
--
               Franck
