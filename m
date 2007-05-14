From: Jakub Narebski <jnareb@gmail.com>
Subject: Suggestions for cgit (was: Re: suggestions for gitweb)
Date: Mon, 14 May 2007 09:31:32 +0200
Message-ID: <200705140931.32513.jnareb@gmail.com>
References: <20070512205529.GS14859@MichaelsNB> <f25mic$1b1$2@sea.gmane.org> <8c5c35580705130952r7c0e353dr9cf20aed61bdd463@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Lars Hjemli" <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 14 09:36:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HnV6h-0003Kn-H0
	for gcvg-git@gmane.org; Mon, 14 May 2007 09:36:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753105AbXENHg3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 May 2007 03:36:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753708AbXENHg3
	(ORCPT <rfc822;git-outgoing>); Mon, 14 May 2007 03:36:29 -0400
Received: from wr-out-0506.google.com ([64.233.184.234]:35935 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751060AbXENHg2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 May 2007 03:36:28 -0400
Received: by wr-out-0506.google.com with SMTP id 76so1633864wra
        for <git@vger.kernel.org>; Mon, 14 May 2007 00:36:28 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=OwGjrW8N3UN3nb0/LpP4aEQ1ffAtIvBe1D8aomg4ZLeppaeu2Gos20rJ1i1JHs7hzJbjQ0rP9RXDbXkDaxyiVErgwRH98Sde1DaBR6LNfg9U1eQZBy/NMFBx2WrnGzZ1zVnPyjGt5xHx0mFUZtqhDODBfrWS/pr8Przls9D6VA0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=FkevS3mvxzOySdxkKzOnsHzxbuIgUNEg8+xbd1ttQQtbgHFX3RbJEBGDQoPwh2jTi0A4f+FaDr8KtSiF1y83VCqZiGBlFft5PqoyW0U9ywAncsczpLPzGdvScd/cnUvOv9kVV3yjC55P829ObZYqA/s4UThKJ2X+iwppxKV/Is0=
Received: by 10.78.200.3 with SMTP id x3mr2189077huf.1179128186705;
        Mon, 14 May 2007 00:36:26 -0700 (PDT)
Received: from host-89-229-25-173.torun.mm.pl ( [89.229.25.173])
        by mx.google.com with ESMTP id 72sm10773574ugb.2007.05.14.00.36.24;
        Mon, 14 May 2007 00:36:25 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <8c5c35580705130952r7c0e353dr9cf20aed61bdd463@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47223>

On Sun, 13 May 2007, Lars Hjemli <hjemli@gmail.com> wrote:

> I've implemented number of files/lines changed in cgit's log view and
> pushed it to http://hjemli.net/git/
> 
> It does consume some cpu (especially on the linux-2.6 repo), but it's
> not terribly bad (and the caching helps out). But I felt like changing
> the number of commits per page to 50, so I added a knob for this in
> the config file while at it.
> 
> I'll try to get a proper diffstat on the commit page + file history
> via tree view next (filesize has always been part of cgits tree view
> btw).

What I lack in cgit is using git diff and showing extended diff headers
(and the ugly tight box around diff doesn't help either), and gitweb's
'commitdiff' view / git's git-show / git's git-format-patch.

I don't think displaying filesize slows cgit much (you need to find and
read object header for that, as this information is not present in a
tree object...

By the way, what do you think about http://git.or.cz/gitwiki/Gitweb 
page?
-- 
Jakub Narebski
Poland
