From: Nazri Ramliy <ayiehere@gmail.com>
Subject: Re: [GSoC update] git-remote-svn: Week 4
Date: Wed, 26 May 2010 10:50:26 +0800
Message-ID: <AANLkTimu5d2ofkjERW8zcgIGqsnbnGazsDaltL1r6n6H@mail.gmail.com>
References: <AANLkTimFqlbYz6BL02N7UiAsGDpspFJTrLwQYWOMi-vS@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git Mailing List <git@vger.kernel.org>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	David Michael Barr <david.barr@cordelta.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 26 04:50:35 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OH6hW-0006J3-LZ
	for gcvg-git-2@lo.gmane.org; Wed, 26 May 2010 04:50:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933612Ab0EZCu2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 May 2010 22:50:28 -0400
Received: from mail-gx0-f227.google.com ([209.85.217.227]:57077 "EHLO
	mail-gx0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933557Ab0EZCu1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 May 2010 22:50:27 -0400
Received: by gxk27 with SMTP id 27so1934564gxk.1
        for <git@vger.kernel.org>; Tue, 25 May 2010 19:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=M8TDb0c7eBAfb8uK5UfAxIxWvMPjHc6r2gzVzRGi3nI=;
        b=To28fbOHCanhSrEnGqnxfDJGJuecnKqvBfGh9GQtG3UcianZ4n4cEBtMWnhTtI26xV
         9ybPKx1KHuQB8ClE7NdiGH3BjXOhjj0O1NlhvHCek3iTrqZTD8goFeq3ARmOcUYG4PaT
         m30NAGXmGdIpqLQ4NCFkImYbGYSdxPnk2d70c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=V2Ga2sQK52d8XGfGYvi9MYq313lwHfCAAoj+OrY6SFN4hHVjfFCOKyvgtD/hJ5frjD
         vqoYPEkVlyBhBMFOJZJWmsasFYnFITqOQ0h6ZyzsSx+x0lYfJ+ofXNYzTvL6ygCrASdj
         8Wt7kT7bvuMqJhF01yYjQE6AP3PMLmDIdIaJI=
Received: by 10.90.61.20 with SMTP id j20mr4233491aga.150.1274842226312; Tue, 
	25 May 2010 19:50:26 -0700 (PDT)
Received: by 10.90.90.2 with HTTP; Tue, 25 May 2010 19:50:26 -0700 (PDT)
In-Reply-To: <AANLkTimFqlbYz6BL02N7UiAsGDpspFJTrLwQYWOMi-vS@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147730>

> I'd appreciate it if someone could review this
> series (or the corresponding code on GitHub). David and I will
> hopefully finish "memory" this week, and I'll start writing an SVN
> client that's able to dump a remote repository to a file (sort of a
> stripped down version of `svnsync` + `svnadmin dump`) towards the
> later half of this week.

Would it be able to automatically convert an svn repo that started
life without the trunk/branches/tags hierarchy, but was added
after-the-fact?

I know I might be asking too much here :)

I'm currently planning on migrating my $DAY_JOB team from svn to git,
and I'm thinking of testing your work if it could do the above without
manual intervention.

For what it's worth, I'm happy with git-svn, and just thought that I
might be able to give you feedback since I'm currently in the midst of
migrating.

nazri
