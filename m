From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: WIP: asciidoc replacement
Date: Fri, 5 Oct 2007 11:49:56 +1300
Message-ID: <46a038f90710041549v3357a0f8j53b1d2fc24b73210@mail.gmail.com>
References: <Pine.LNX.4.64.0710030133020.28395@racer.site>
	 <7vprzwhkgd.fsf@gitster.siamese.dyndns.org>
	 <39F3EE1B-7BD4-4927-AB90-2EB4BBAF05D0@wincent.com>
	 <85abr0y5ua.fsf@lola.goethe.zz>
	 <1D18C52E-BB96-49EC-97A9-F802D56CAFF5@wincent.com>
	 <7vd4vwfou9.fsf@gitster.siamese.dyndns.org>
	 <46a038f90710032355t77c38d30p781743a6f248fab5@mail.gmail.com>
	 <85tzp6oavq.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Wincent Colaiuta" <win@wincent.com>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, msysgit@googlegroups.com
To: "David Kastrup" <dak@gnu.org>
X-From: git-owner@vger.kernel.org Fri Oct 05 00:50:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IdZWD-0007SZ-Ex
	for gcvg-git-2@gmane.org; Fri, 05 Oct 2007 00:50:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759046AbXJDWuA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Oct 2007 18:50:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759464AbXJDWt7
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Oct 2007 18:49:59 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:60641 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756974AbXJDWt7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Oct 2007 18:49:59 -0400
Received: by ug-out-1314.google.com with SMTP id z38so429331ugc
        for <git@vger.kernel.org>; Thu, 04 Oct 2007 15:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=SgsmPzwKXfq2sX62YTlaioUTu3az9Hh/oV5ChF3+8GE=;
        b=nfWfEES8vF6FaZgP89xb8J6fx51GyW+YN5ZyeueISiA8j+Nz39ONj/NMjcioMqbgf0zDmUT3WmzVGYT+0vtACzFEDvuHXjYpQPnf/0eRr7DH9Az1emd+RZJFB6neNAJtSrKcBxeaxVlWZ0pF1Ntj3PwoHERJMgUIFi5uMNjODUg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=bcqLMnZYHAj/BRANfqTEFGzdEv29QbzWSieo6gPZZQKjwLN0EgPv/OEBmM9w8fOak+2Oi/dUNknX+GBZpejW7ooAq6vZ537HEmRoEUDAJyDGeIxVtVtrl8zktKlAA9uCJau9sszpBCjiHJmaI8g+/TR3hCt4h5c6NzD4E3oWKz0=
Received: by 10.66.224.19 with SMTP id w19mr2573864ugg.1191538196345;
        Thu, 04 Oct 2007 15:49:56 -0700 (PDT)
Received: by 10.67.23.15 with HTTP; Thu, 4 Oct 2007 15:49:56 -0700 (PDT)
In-Reply-To: <85tzp6oavq.fsf@lola.goethe.zz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60018>

On 10/5/07, David Kastrup <dak@gnu.org> wrote:
> "Martin Langhoff" <martin.langhoff@gmail.com> writes:
>
> > With AsciiDoc we've managed to avoid the arcane format, but we are
> > still laden with a horrid toolchain.
>
> Let's put this somewhat into perspective: the toolchain is horrid with
> regard to the complexity and documentation

Exactly. I'm not complaining about asciidoc itself. But the toolchain
is very fragile, and not crossplatform. Git compiles and works on many
unixen, win32, and some embedded posixy OSs if IIRC.

OTOH asciidoc can be pretty hard to get going even on modern
linuxen.The asciidoc toolchain doesn't even work on Debian Sarge,
which isn't *that* old, while I'm pretty sure git itself can be built
and used on older linuxen. That's where a good old regex-insanity
Perl-based parser beats anything else: no dependencies, works
everywhere.

In that sense, this is close to being a rehash of the "let's use
autoconf" argument...

cheers



martin
