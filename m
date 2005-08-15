From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: Switching heads and head vs branch after CVS import
Date: Tue, 16 Aug 2005 08:09:02 +1200
Message-ID: <46a038f90508151309269ffc04@mail.gmail.com>
References: <20050815080931.64F0D352633@atlas.denx.de>
	 <Pine.LNX.4.58.0508150930020.3553@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Wolfgang Denk <wd@denx.de>, GIT <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Aug 15 22:10:23 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E4lGq-000395-5N
	for gcvg-git@gmane.org; Mon, 15 Aug 2005 22:09:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964941AbVHOUJG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 15 Aug 2005 16:09:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964940AbVHOUJF
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Aug 2005 16:09:05 -0400
Received: from rproxy.gmail.com ([64.233.170.200]:35928 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964938AbVHOUJC convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Aug 2005 16:09:02 -0400
Received: by rproxy.gmail.com with SMTP id i8so836476rne
        for <git@vger.kernel.org>; Mon, 15 Aug 2005 13:09:02 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=m4Ger2MWHkFsnVbstA1whVGYLVpclqXLTVRZcXVcNc+KcWWJV4fDKbUlg2wIFFe0+viVLDOJFkUmvNsW4fDig666A+GwAojBSRD50ZC42VvL7fl5rUkdTlBxKA0pu/5nfyB5lixc/J8xL6WOkXDLhXPYecFKz5y6ff80sCSXfl4=
Received: by 10.38.104.65 with SMTP id b65mr2067392rnc;
        Mon, 15 Aug 2005 13:09:02 -0700 (PDT)
Received: by 10.38.101.8 with HTTP; Mon, 15 Aug 2005 13:09:02 -0700 (PDT)
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0508150930020.3553@g5.osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On 8/16/05, Linus Torvalds <torvalds@osdl.org> wrote:
> The good news is that if you guess wrong, and you claim a merge where none
> exists, it doesn't really do any real damage. 

I had figured out what part of the code I wanted to hack, but was
concerned that marking things that were merges in cvs-speak but not in
git-speak would leave me with broken import and problems going
forward.

If I find the time, I'll add some sort of pattern-match parameters to
be tried against the commitmsg to extract likely head/branch names
where we are merging from. My problem right now is that the only cvs
repo with interesting branches and merges I have is huge, and takes an
hour to import. That puts a damper on things, unfortunately.

cheers,


martin
