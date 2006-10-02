From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: [PATCH] gitweb: Remove excessively redundant entries from git_difftree_body
Date: Mon, 2 Oct 2006 12:48:47 -0700 (PDT)
Message-ID: <20061002194847.285.qmail@web31811.mail.mud.yahoo.com>
References: <efp4d6$a7b$1@sea.gmane.org>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Mon Oct 02 21:48:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GUTmV-00063q-RZ
	for gcvg-git@gmane.org; Mon, 02 Oct 2006 21:48:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964874AbWJBTst (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 2 Oct 2006 15:48:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964894AbWJBTst
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Oct 2006 15:48:49 -0400
Received: from web31811.mail.mud.yahoo.com ([68.142.207.74]:40321 "HELO
	web31811.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S964874AbWJBTss (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Oct 2006 15:48:48 -0400
Received: (qmail 287 invoked by uid 60001); 2 Oct 2006 19:48:47 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=to6/TvfpFAx/NmmqD4wlKwReUazdRhI+zQCErprWWcYz0tuL7f1s+7tZBKzKzAcIsN9G1plvx3m5XKXzHxKPlFK6uq5zievw9PV6BkXRdqpw7q/4JGdipnhQZOsQGI/NQOuP59av6nRJqEPHJz7qNZ/WA7DIaz8+ywkKZTCX5rM=  ;
Received: from [64.215.88.90] by web31811.mail.mud.yahoo.com via HTTP; Mon, 02 Oct 2006 12:48:47 PDT
To: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
In-Reply-To: <efp4d6$a7b$1@sea.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28232>

--- Jakub Narebski <jnareb@gmail.com> wrote:
> Junio C Hamano wrote:
> 
> > Luben Tuikov <ltuikov@yahoo.com> writes:
> > 
> >> 1) All entries on the left are blobs and clicking on them
> >> leads to blobs.  No more diff or blob depending on what
> >> happened (modified or mode changed) to the file -- this goes
> >> to the right, in the "link" column.
> >>
> >> 2) Remove redundant "blob" from the link column on the right.
> >> This can now be had by clicking on the entry itself.
> >>
> >> This reduces and simplifies the code.
> >>
> >> Signed-off-by: Luben Tuikov <ltuikov@yahoo.com>
> > 
> > We lost blobdiff from commitdiff page with this patch, which I
> > think it probably is a good change.  We can say "when we display
> > a pathname you can click it to get the blob or tree".
> 
> In my opinion it is a bad change. We now have "patch" inner-link
> to anchor in commitdiff view, but it's equivalent in commit view
> i.e. diff aka blobdiff vanished.

All which can be easily had.

    Luben
