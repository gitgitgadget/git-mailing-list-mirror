From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH/RFC v2 1/4] Add "core.eolStyle" variable to control 
	end-of-line conversion
Date: Sun, 9 May 2010 13:43:53 -0400
Message-ID: <o2h76718491005091043x9d8249f1gf6f44a32287ced18@mail.gmail.com>
References: <cover.1273352819.git.eyvind.bernhardsen@gmail.com>
	 <c8ef28b72709013f17e093954a0f4e2ad1fb9652.1273352819.git.eyvind.bernhardsen@gmail.com>
	 <alpine.LFD.2.00.1005081455450.3711@i5.linux-foundation.org>
	 <E2A9C4D2-010F-44B2-BF6A-627DE8B72FB5@gmail.com>
	 <BFFD3CAC-E7D9-49D8-9B67-C3F5157646F3@gmail.com>
	 <20100509070043.GB14069@dpotapov.dyndns.org>
	 <CD080D38-811C-4BBF-A5CB-6B613555FE72@gmail.com>
	 <u2p76718491005091002v516429ddrf118c35f3312c3ab@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org List" <git@vger.kernel.org>,
	Dmitry Potapov <dpotapov@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	mat <matthieu.stigler@gmail.com>,
	hasen j <hasan.aljudy@gmail.com>,
	Erik Faye-Lund <kusmabite@googlemail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Avery Pennarun <apenwarr@gmail.com>,
	Robert Buck <buck.robert.j@gmail.com>,
	Finn Arne Gangstad <finnag@pvv.org>
To: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 09 19:48:19 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OBAby-0000bj-3w
	for gcvg-git-2@lo.gmane.org; Sun, 09 May 2010 19:48:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751256Ab0EIRn4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 May 2010 13:43:56 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:47637 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750972Ab0EIRnz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 May 2010 13:43:55 -0400
Received: by gwj19 with SMTP id 19so1536370gwj.19
        for <git@vger.kernel.org>; Sun, 09 May 2010 10:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=+wtUtEEQzZuKJcxj5YX2GQ81FhyGz0f6esiWUBbeIBc=;
        b=Sz4eRQGRnl+kpCSpBlyvsOfBDVkqyuKBx07y3FCNylZwhAFH6nNALyDFcT8gllq5Vc
         t8JQUPJ5+tvNVULPcktyWopUuIwVil8mo7JCHp8v0EARI9mjfHRJpoMxHY+9Cm8Buiuc
         GYeSgVbLDn55pE/zBD0Eooq9UMx7XZzB4Zurs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=YsxPhBlvde8OZDO3OmaLD0DRaSNe8waq9v/aHxi/v9BRjH4vXaMss9iYwuCGu7sa1a
         B3r3Li5KQGhRHVjOy4L4QZpYVyQNxiX/fpQNUuJTaiTuIeJBqYqSAz6PoK6xm+bDKTRF
         jjgje/EG7rukkVKm9PW0zvqvKe289ZVoDUB5Q=
Received: by 10.231.157.139 with SMTP id b11mr1601395ibx.49.1273427033228; 
	Sun, 09 May 2010 10:43:53 -0700 (PDT)
Received: by 10.231.34.8 with HTTP; Sun, 9 May 2010 10:43:53 -0700 (PDT)
In-Reply-To: <u2p76718491005091002v516429ddrf118c35f3312c3ab@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146731>

One more point, which I'm sure will be inflammatory. After all, it has
nothing to do with anything, but let's look at how svn deals with EOL
issues:

1) A property for whether a file is binary or text
2) A property for the EOL style which applies only to text files:

http://svnbook.red-bean.com/en/1.5/svn.advanced.props.file-portability.html#svn.advanced.props.special.eol-style

And Mercurial's plan to deal with it:

http://mercurial.selenic.com/wiki/EOLTranslationPlan

:-)

j.
