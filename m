From: Kevin Ballard <kevin@sb.org>
Subject: Re: [PATCH] git-commit.txt: Order options alphabetically
Date: Wed, 1 Dec 2010 14:49:02 -0800
Message-ID: <2C3777CB-2DDD-4FF5-842B-23F7EF838611@sb.org>
References: <1291215526-11428-1-git-send-email-jari.aalto@cante.net> <20101201165043.GF26120@burratino> <87r5e1v2g8.fsf@picasso.cante.net> <7vzkspuw8g.fsf@alter.siamese.dyndns.org> <87r5e1t93o.fsf@picasso.cante.net>
Mime-Version: 1.0 (Apple Message framework v1082)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org
To: Jari Aalto <jari.aalto@cante.net>
X-From: git-owner@vger.kernel.org Wed Dec 01 23:49:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PNvU7-0008Bw-HR
	for gcvg-git-2@lo.gmane.org; Wed, 01 Dec 2010 23:49:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756430Ab0LAWtG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Dec 2010 17:49:06 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:32960 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756130Ab0LAWtE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Dec 2010 17:49:04 -0500
Received: by pwj3 with SMTP id 3so1207668pwj.19
        for <git@vger.kernel.org>; Wed, 01 Dec 2010 14:49:04 -0800 (PST)
Received: by 10.142.89.20 with SMTP id m20mr9650776wfb.13.1291243744080;
        Wed, 01 Dec 2010 14:49:04 -0800 (PST)
Received: from [10.8.0.89] ([69.170.160.74])
        by mx.google.com with ESMTPS id v19sm576690wfh.12.2010.12.01.14.49.02
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 01 Dec 2010 14:49:03 -0800 (PST)
In-Reply-To: <87r5e1t93o.fsf@picasso.cante.net>
X-Mailer: Apple Mail (2.1082)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162629>

You may want to invest in a spell-checker.

On Dec 1, 2010, at 2:35 PM, Jari Aalto wrote:

>> the documentation is often more useful if the options are
>> grouped together by features and concepts they relate to.
> 
> Where do you see grouping all the sudden? Manaula pages are not
> primarily used to learn things, they are used as reference. Just like
> Book indexes.

Most certainly they are used to learn things. Especially with tools like git.
Don't know what options you can give to git-diff? Read the manpage!

> I haven't seed anyone for 10's of years who would have read full manaul
> page from top to botton; every single line at one stop.
> 
> They come and go, come and go to read it. Learn bit by bit. And there is
> the strenght od proper indexing, the alphabetical.

Indexing, sure, but the actual manpage is not an index. A-Z ordering makes
no sense for the manpage. When people read, chunk by chunk, they expect
related functionality. It especially helps with discoverability. For example,
I know of the -w flag to git-diff that tells it to ignore whitespace. I'm not
certain this does exactly what I want, so I pop open the manpage, search for
-w, and read it. And I'm right, it doesn't do what I want. But right next to
it is the flag -b, and that _does_ do precisely what I want. If the manpage
was ordered alphabetically, I'd likely have never found the -b flag. As it is,
all 3 whitespace-related flags to git-diff are grouped together, and it helps
not only with reading the manpage for the first time (as I learn all related
concepts at the same time), but with discovering the related flags when I go
back to read documentation on the flags I already know.

-Kevin Ballard