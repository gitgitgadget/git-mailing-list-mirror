From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: git-format-patch possible regressions
Date: Thu, 25 May 2006 22:21:31 +0200
Message-ID: <e5bfff550605251321t7378b427p68ffe2e16a54b3ff@mail.gmail.com>
References: <e5bfff550605251223g2cf8cfb9vfa18d016b369188d@mail.gmail.com>
	 <7vhd3dubd9.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, "Linus Torvalds" <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Thu May 25 22:21:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FjML3-0005Dm-LF
	for gcvg-git@gmane.org; Thu, 25 May 2006 22:21:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751211AbWEYUVh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 25 May 2006 16:21:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751258AbWEYUVf
	(ORCPT <rfc822;git-outgoing>); Thu, 25 May 2006 16:21:35 -0400
Received: from wr-out-0506.google.com ([64.233.184.232]:55999 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751253AbWEYUVd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 May 2006 16:21:33 -0400
Received: by wr-out-0506.google.com with SMTP id i24so2010079wra
        for <git@vger.kernel.org>; Thu, 25 May 2006 13:21:32 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=n3NMXdbflizenLy9B0JPh4/kRl8xiJP5jiQqhbZzis5pj4ZEHwIn0CWWG3O6rbfdQHP1sxAvQ4vFy/+bebhIqos4rRcwTEaJezzG3cfSPpc8qRRCyRaZFQ9ThSe/sQ1SeP2jNbaRI7nIMFqT4eDwkQc1Kd4d0Jx74Inwg2aLMdE=
Received: by 10.65.43.20 with SMTP id v20mr4637955qbj;
        Thu, 25 May 2006 13:21:31 -0700 (PDT)
Received: by 10.64.142.14 with HTTP; Thu, 25 May 2006 13:21:31 -0700 (PDT)
To: "Junio C Hamano" <junkio@cox.net>
In-Reply-To: <7vhd3dubd9.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20760>

> > Both regressions brake qgit. The first one is easy to fix (--signoff  --> -s)
>
> I do not think -s does what you want.  It means "do not generate
> diff" to the diff family, but format-patch overrides it and
> forces generating patch+stat output, so you do not see what it
> is doing.
>

Sorry, I was fooled by git-format-patch.txt documentation.


> > 2) Unhandled ranges list
> >
> > The second one is not so easy.
>
> This is a real regression; I was hoping Porcelain writers were
> paying attention of what are coming, but obviously the
> description in "What's in git.git" messages and discussion on
> the list were not detailed enough.  My apologies.
>

Sorry also for this, normally I read "What's in git.git" but perhaps I
missed this.


>
> As an easy alternative, we could give --start-number=<n> to
> format-patch so that you can do the iteration yourself instead
> of having format-patch to iterate over the list.
>
>

You beat me for few minutes ;-)

     Marco
