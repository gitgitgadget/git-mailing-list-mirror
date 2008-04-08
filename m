From: "Nigel Magnay" <nigel.magnay@gmail.com>
Subject: Re: Automated/Daily build systems supporting git?
Date: Tue, 8 Apr 2008 17:34:11 +0100
Message-ID: <320075ff0804080934j19f9323s9ff02372af8065eb@mail.gmail.com>
References: <1207666672.5698.4.camel@pitcairn.cambridgebroadband.com>
	 <20080408145953.GA8159@sigill.intra.peff.net>
	 <m3d4p0tlz7.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Jeff King" <peff@peff.net>,
	"Alex Bennee" <kernel-hacker@bennee.com>, git@vger.kernel.org
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 08 18:41:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JjGrv-0004xC-FO
	for gcvg-git-2@gmane.org; Tue, 08 Apr 2008 18:40:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760901AbYDHQeQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Apr 2008 12:34:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760896AbYDHQeP
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Apr 2008 12:34:15 -0400
Received: from fk-out-0910.google.com ([209.85.128.191]:45543 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760891AbYDHQeN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Apr 2008 12:34:13 -0400
Received: by fk-out-0910.google.com with SMTP id 19so2759164fkr.5
        for <git@vger.kernel.org>; Tue, 08 Apr 2008 09:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=1B2EOEfwCNC/oqW2N8NeAHWCQhTfvFSKEbHhvfKRnfU=;
        b=XsMXormSzM17DEDBVmRKiLh4Kii8c44QKB5RjWeyIaHdw/teQQCdOwQeG8cb74H8fvAq8+3r01cqYXldvtH3msgkKsawEZuF2gRgRiwNSSfTLOk+PeIXq6yrcQv73qKJ8G/CZAX32f9Cs6rgAA9UtiLHG2tsPipO1NfRNd56uF8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=BqgpQ6Lhq6oGsdLmfPNr9S/H54kbqMyGZG24QGJOe9NqH6KIPm6X+8NPMvOHDangs8FHppadzs4rJwcIZLW9CbRGoD1d/NQXKqqqyCSg6x+HQo6I8A77YKk41284osdSo4gD47udzvz6HiLUqKC4s3TdU7vAXxg0mSwPGjklv+U=
Received: by 10.82.111.1 with SMTP id j1mr320841buc.58.1207672451139;
        Tue, 08 Apr 2008 09:34:11 -0700 (PDT)
Received: by 10.82.169.1 with HTTP; Tue, 8 Apr 2008 09:34:11 -0700 (PDT)
In-Reply-To: <m3d4p0tlz7.fsf@localhost.localdomain>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79007>

I did a simple git plugin for hudson back when I was still learning
about git (it's in the CVS tree) - I've got some changes that need to
be committed to it, but it's working OK for us..


On Tue, Apr 8, 2008 at 4:17 PM, Jakub Narebski <jnareb@gmail.com> wrote:
> Jeff King <peff@peff.net> writes:
>
>  > On Tue, Apr 08, 2008 at 03:57:52PM +0100, Alex Bennee wrote:
>  >
>  > > I'm currently doing some investigation into automated/daily build
>  > > systems to track the health of a source tree. There seem to be a number
>  > > about but as I'm also looking to move the CVS tree over to git I was
>  > > wondering if the denziens of the list knew of any they could recommend?
>  >
>  > Have you looked at contrib/continuous?
>
>  Perhaps Hudson[1] can be made to support Git, as it supports Mercurial
>  (via Mercurial plugin).
>
>  [1] https://hudson.dev.java.net/
>  --
>  Jakub Narebski
>  Poland
>  ShadeHawk on #git
>
>
> --
>  To unsubscribe from this list: send the line "unsubscribe git" in
>  the body of a message to majordomo@vger.kernel.org
>  More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
