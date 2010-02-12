From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: web-based client for Git, was Re: GSoC 2010
Date: Fri, 12 Feb 2010 14:30:47 +0100
Message-ID: <201002121430.49057.jnareb@gmail.com>
References: <e72faaa81002120222p19db9c75u737e2615c14930b1@mail.gmail.com> <alpine.DEB.1.00.1002121406550.20986@pacific.mpi-cbg.de> <20100212130543.GX9553@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Pavan Kumar Sunkara <pavan.sss1991@gmail.com>,
	Git List <git@vger.kernel.org>
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Fri Feb 12 14:38:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nfvj8-0005lR-VA
	for gcvg-git-2@lo.gmane.org; Fri, 12 Feb 2010 14:38:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753522Ab0BLNiP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Feb 2010 08:38:15 -0500
Received: from mail-bw0-f212.google.com ([209.85.218.212]:34519 "EHLO
	mail-bw0-f212.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752727Ab0BLNiO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Feb 2010 08:38:14 -0500
Received: by bwz4 with SMTP id 4so2766454bwz.2
        for <git@vger.kernel.org>; Fri, 12 Feb 2010 05:38:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=g0A4e/slClxrFjbp6eehJKhEa1KzVfm22jm5HTg76jo=;
        b=EoH4e4uUY9iAqVXtBEG2KBOMedGWvuR3cXc43bemlwS0eu//X3RYk/AHQ4kuaHGe9Z
         8G3jBMhUO1MikRKpHffK6LpHB4LYVpK5tj18dL7SgONga8atEzuSlbl2tUlUAQnYOTPI
         1S5f7G5iZvH9Vb6+Q3CsQDLfQh9cQMfbvNmwo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=vqEBeNtnC7Pque5gYDLVwDbZC8l31e3O0d4bDW5hvzPX6cKgVH/FgLFLZyfCGzmj5i
         vI0cUPqfcRH+qJ1lquSxsF95urHgrz/WTdgMogwqaBV/3bSdGYIRMfw/o8RGRpLi14Jl
         JablPdfkN87EjLrBa5WmeLDGdFn06+mLdy5cY=
Received: by 10.204.140.27 with SMTP id g27mr528727bku.116.1265981452537;
        Fri, 12 Feb 2010 05:30:52 -0800 (PST)
Received: from ?192.168.1.13? (abvn168.neoplus.adsl.tpnet.pl [83.8.211.168])
        by mx.google.com with ESMTPS id 13sm1544704bwz.6.2010.02.12.05.30.50
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 12 Feb 2010 05:30:51 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <20100212130543.GX9553@machine.or.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139709>

On Fri, 12 Feb 2010, Petr Baudis wrote:
> On Fri, Feb 12, 2010 at 02:07:23PM +0100, Johannes Schindelin wrote:
>> On Fri, 12 Feb 2010, Pavan Kumar Sunkara wrote:
>> 
>>> I saw the wishlist of gitweb in wiki.

Wishlists on the wiki have, unfortunately, trouble with sometimes being
not up to date.

>>> I would like to implement the syntax highlighting for viewing blobs.
>>> 
>>> Is there anyone working on it now?
>> 
>> http://repo.or.cz/w/git/dscho.git/commitdiff/bc1ed6aafd9ee4937559535c66c8bddf1864bec6
> 
>   Have you tried to submit this "upstream"? Why did it get dropped? This
> sounds like such a useful _and_ trivial thing that if we can't even get
> *this* integrated, surely gitweb is doomed for good...

I don't remember seeing this send to git mailing list.

Note that the patch should use quote_command(...) instead of simple
join(' ', ...) for its arguments, like it is done in git_snapshot().

-- 
Jakub Narebski
Poland
