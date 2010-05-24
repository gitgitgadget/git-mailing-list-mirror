From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: What's cooking extra
Date: Tue, 25 May 2010 00:11:28 +0200
Message-ID: <20100524221128.GA29588@localhost>
References: <7vsk5o9d1f.fsf@alter.siamese.dyndns.org>
 <20100519170656.GA30161@pvv.org>
 <20100522130916.GA28452@localhost>
 <50199F1F-3513-43A6-8990-957F3D0AF58C@gmail.com>
 <20100522222746.GA2694@localhost>
 <CDD31343-2352-434B-B875-2013DAF49CE7@gmail.com>
 <20100523115127.GA20443@localhost>
 <744D05D2-FC47-45E5-92A1-CD93B0901E0C@gmail.com>
 <20100524094905.GA10811@localhost>
 <986EE696-5997-40AD-929C-D82D40D7242E@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Finn Arne Gangstad <finnag@pvv.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 25 00:11:42 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OGfs4-0003MD-H5
	for gcvg-git-2@lo.gmane.org; Tue, 25 May 2010 00:11:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757008Ab0EXWLf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 May 2010 18:11:35 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:51966 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755726Ab0EXWLe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 May 2010 18:11:34 -0400
Received: by fxm5 with SMTP id 5so2689924fxm.19
        for <git@vger.kernel.org>; Mon, 24 May 2010 15:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:sender:received:date:from:to
         :cc:subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=DWkRU4E4c4ZQAoq22ROkk9abs8Gvk7UdWL5o1TDexlM=;
        b=flSH8xPKbOPMrScDzK4lUiJh6PD0DMzpTwgbwjT2dM104oJcGp6o2/wRoN7sL9aLWo
         /rfH9Jg/8lN+m0G4nUp1Ire+31dYRR9iereKDv1S1+gk3an3sxGATPb2KrOvyMNn4pbG
         Zt1WmiGvZCFo/DSmv4UzznblR6bmNZOJE8Foo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=sender:date:from:to:cc:bcc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        b=mTk3q/yfWB9W02ouW9J46BYOFssklIIHLpYgSvAxdc01bllF7HlRybBIxPqzdxYmkn
         nZRbUq0jR7JyhrOINuwJ+qzd5q33eZxRmlIZ9fJxG5HKoQfZ8BUNg/GhAOT/EJIK8qrN
         TtRXMLf3quY++9k2a4AgSGgT+NyNxpXk8Cp8s=
Received: by 10.223.10.11 with SMTP id n11mr5223129fan.3.1274739092853;
        Mon, 24 May 2010 15:11:32 -0700 (PDT)
Received: from darc.lan (p549A704B.dip.t-dialin.net [84.154.112.75])
        by mx.google.com with ESMTPS id y12sm21567522faj.5.2010.05.24.15.11.31
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 24 May 2010 15:11:32 -0700 (PDT)
Received: from drizzd by darc.lan with local (Exim 4.71)
	(envelope-from <drizzd@localhost>)
	id 1OGfrs-0007uV-I8; Tue, 25 May 2010 00:11:28 +0200
Content-Disposition: inline
In-Reply-To: <986EE696-5997-40AD-929C-D82D40D7242E@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147653>

On Mon, May 24, 2010 at 11:11:40PM +0200, Eyvind Bernhardsen wrote:

> If you later discover that you want normalized text files in your
> repository, you _will_ have to convert all your files.  That's a
> bit tricky, but it's not the huge problem you're making it out to
> be, and it only has to be done once.

I am not just making this stuff up. These things have bitten me in
the past, and there have been complaints about it in #git. And even
after finding the solution I always felt like crlf handling in git
was really broken. I was hoping that after enabling the new eol
handling, these weird effects would go away, but obviously they
don't.

Maybe for you it does not seem like such a big deal, because you
are now so familiar with the inner workings of this algorithm. But
to a naive user like me it is very counter-intuitive.

I am not saying that the new features are all wrong. Some of them
really are a major improvement. My main point is that it is still
confusing and that in itself will cause issues for many people.

And I don't see why we cannot do better. In the first scenario of
my previous post (no attributes set), since I already enable
core.eol = lf, couldn't we handle that as if text=auto were set on
every file?  Isn't that what core.autocrlf = true means in this
case?

And once we normalized the file to LF, why don't we also checkout
that version, or at least mark it as dirty in the index, so a reset
--hard will fix it up?

Regards,
Clemens
