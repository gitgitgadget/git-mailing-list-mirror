From: Franck <vagabon.xyz@gmail.com>
Subject: Re: [QUESTION] Access to a huge GIT repository.
Date: Mon, 21 Nov 2005 21:11:27 +0100
Message-ID: <cda58cb80511211211l2ff6ff12j@mail.gmail.com>
References: <cda58cb80511160424j1acac7c6j@mail.gmail.com>
	 <Pine.LNX.4.64.0511160837000.13959@g5.osdl.org>
	 <cda58cb80511170236p4a7e2baay@mail.gmail.com>
	 <Pine.LNX.4.64.0511170817480.13959@g5.osdl.org>
	 <cda58cb80511171347yef4f090g@mail.gmail.com>
	 <Pine.LNX.4.64.0511171443000.13959@g5.osdl.org>
	 <cda58cb80511190423w1e46bf5bu@mail.gmail.com>
	 <Pine.LNX.4.64.0511190953520.13959@g5.osdl.org>
	 <7vzmo04dpl.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Linus Torvalds <torvalds@osdl.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Nov 21 21:12:33 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EeI0i-0004JJ-8u
	for gcvg-git@gmane.org; Mon, 21 Nov 2005 21:11:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750701AbVKUUL3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 21 Nov 2005 15:11:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750777AbVKUUL3
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Nov 2005 15:11:29 -0500
Received: from zproxy.gmail.com ([64.233.162.204]:44071 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750701AbVKUUL2 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Nov 2005 15:11:28 -0500
Received: by zproxy.gmail.com with SMTP id 14so928246nzn
        for <git@vger.kernel.org>; Mon, 21 Nov 2005 12:11:27 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=N2EG0KbtoSvDQqW85cVrBik0zKKNtA9xrhG1BhBehBVAcWxhOAPdRH1Xwd2hvjAwTGXAwUlfFRtqjQMTOSD37yTnieEC4OtBcn/cEEVVjhScWMBep6RKaGssXMFw6oDXT4vvhaZpKMDcApwkoQudwXkfYQhVPs5pT1DwxheP94g=
Received: by 10.36.247.9 with SMTP id u9mr200239nzh;
        Mon, 21 Nov 2005 12:11:27 -0800 (PST)
Received: by 10.36.47.8 with HTTP; Mon, 21 Nov 2005 12:11:27 -0800 (PST)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vzmo04dpl.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12476>

2005/11/19, Junio C Hamano <junkio@cox.net>:
> Linus Torvalds <torvalds@osdl.org> writes:
>
> > So "git repack" should _never_ call git-redundant-pack. It's always either
> > wrong or pointless.
>
> Right-o.
>

Ok, it works now. My new git repository is only 60Mo. But :), I would
like to make up my public repository based on this "light" repository.
And if someone has the big repository, I would like him to be able to
pull my public repo into his one. But since I used grafting to "cut"
my light repo and .git/info/grafts file is not copied during
push/pull/clone operations it's not going to work. Is it a scheme that
could work ?

Moreover, I'm wondering if my public repository really needs to store
big repo's pack files as it is described in git tutorial ?

Thanks
--
               Franck
