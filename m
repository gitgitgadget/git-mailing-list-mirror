From: Franck <vagabon.xyz@gmail.com>
Subject: Re: [RFC] shallow clone
Date: Tue, 31 Jan 2006 12:11:53 +0100
Message-ID: <cda58cb80601310311v45531fb5u@mail.gmail.com>
References: <7voe1uchet.fsf@assigned-by-dhcp.cox.net>
	 <Pine.LNX.4.63.0601301220420.6424@wbgn013.biozentrum.uni-wuerzburg.de>
	 <43DDFF5C.30803@hogyros.de> <7v64o18qn4.fsf@assigned-by-dhcp.cox.net>
	 <cda58cb80601310037s58989b26s@mail.gmail.com>
	 <7vvew03hls.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 31 12:12:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F3tQf-0006uh-Qo
	for gcvg-git@gmane.org; Tue, 31 Jan 2006 12:12:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750760AbWAaLLz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 31 Jan 2006 06:11:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750762AbWAaLLz
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Jan 2006 06:11:55 -0500
Received: from zproxy.gmail.com ([64.233.162.201]:1045 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750760AbWAaLLy convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Jan 2006 06:11:54 -0500
Received: by zproxy.gmail.com with SMTP id 14so1271529nzn
        for <git@vger.kernel.org>; Tue, 31 Jan 2006 03:11:53 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=OLLH+KhH6rTFp0a3NAYn9fssmh7+SGMln6gFRdD7YTxUPAS8qKAGwCgYHPJCWz/0re6VMR6bAvUaZt/ImNWf3iDtBht2Ws2NrCPXzhgiJUQY9KrV7q04CYeHp+wUprkmDWtUmuSTwTWjVSEocTYt5ZQFArd9WSbQkahwHejlV8A=
Received: by 10.36.252.76 with SMTP id z76mr2452358nzh;
        Tue, 31 Jan 2006 03:11:53 -0800 (PST)
Received: by 10.36.49.12 with HTTP; Tue, 31 Jan 2006 03:11:53 -0800 (PST)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vvew03hls.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15309>

2006/1/31, Junio C Hamano <junkio@cox.net>:
> Franck <vagabon.xyz@gmail.com> writes:
>
> > I built my public repository from a cautorized one and everybody who
> > is pulling from mine is aware of the lack of the full history but they
> > actually don't care. If someone is pulling from my repo, he actually
> > wants to work on my project which do not need any old thing...
>
> Mind writing up a howto on the topic?

ok I'll try to sum-up something this week, hope my bad english will be
understandable...

>
>  - How things are set up using the current tool.
>  - How others initially clone from you.
>  - How others update (pull) from you.
>  - What are the pitfalls you and others need to avoid
>    (i.e. operations that involve old history)

actually I just discovered one thanks to your first email for this
thread about reverted commit...So I'm not very the one for this
section...

>
> I brought this up, because lack of official support of shallow
> cloning was cited as one of the showstopper for a project that
> once considered switching to git but didn't, from a mailing list
> research.

again I wasn't aware that this feature is really needed...

thanks
--
               Franck
