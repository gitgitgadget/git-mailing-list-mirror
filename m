From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: In future, to replace autotools by cmake like KDE4 did?
Date: Fri, 7 Dec 2007 14:56:09 +0100
Message-ID: <200712071456.11019.jnareb@gmail.com>
References: <998d0e4a0712061810k18e6388jde9d7bc5bd006b57@mail.gmail.com> <m3lk86u2fq.fsf@roke.D-201> <47594021.40200@op5.se>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: "J.C. Pizarro" <jcpiza@gmail.com>, gcc@gcc.gnu.org,
	git@vger.kernel.org, David Miller <davem@davemloft.net>,
	Daniel Berlin <dberlin@dberlin.org>,
	Ismail Donmez <ismail@pardus.org.tr>
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Fri Dec 07 14:56:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0dh5-00044z-OG
	for gcvg-git-2@gmane.org; Fri, 07 Dec 2007 14:56:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754616AbXLGN4W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Dec 2007 08:56:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754467AbXLGN4W
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Dec 2007 08:56:22 -0500
Received: from mu-out-0910.google.com ([209.85.134.186]:63431 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754153AbXLGN4U (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Dec 2007 08:56:20 -0500
Received: by mu-out-0910.google.com with SMTP id i10so875524mue
        for <git@vger.kernel.org>; Fri, 07 Dec 2007 05:56:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=KlB+tj+6k2grAmLHUgbfqg1TOd42PxGV9PF8MHrnqfU=;
        b=J21nCcHZ0xOvgpa6pzVCT5lmZ+Uf4+5AkLxS7oYFqTFDPsXdyWTVr7KAX+5TYcnRzttlea//CO7Hn/i0WZLp+BuBwYACRTCrSNPxddwLEKYAHre6kGUleZY4JhTmY5VYruSZfz64yPYT15B6EZWVcBq8PvvaHq36SSbJLUPH7RY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=M4+J4maGChyjSm90OXldZJuuI1M7tEZf1TOJ+rGsBks7qaiSI+IEZUqN6RsS8f9DApjpEWt4BvDci6+a6ra2IUVUHx8p8hnBajlVWHAhovwfwUx26AloS7isdrlh+9p3OAqewot8vyl5+D+4Zp8br3MavK45dhFD9DvTSOc7kRo=
Received: by 10.82.186.5 with SMTP id j5mr4807194buf.1197035774911;
        Fri, 07 Dec 2007 05:56:14 -0800 (PST)
Received: from ?192.168.1.11? ( [83.8.224.19])
        by mx.google.com with ESMTPS id 12sm901838fgg.2007.12.07.05.56.12
        (version=SSLv3 cipher=OTHER);
        Fri, 07 Dec 2007 05:56:14 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <47594021.40200@op5.se>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67427>

Andreas Ericsson wrote:
> Jakub Narebski wrote:
> > 
> > Although there was some talk about whether giw should use autotools,
> > or perhaps CMake, or handmade ./configure script like MPlayer IIRC,
> > instead of its own handmade Makefile...
> > 
> 
> To tell the truth, I'd be much happier if everything like that got
> put in a header file or some such. 95% of what we figure out by looking
> at "uname" output can already be learned by looking at the various
> pre-defined macros.
> 
> Fortunately, there's a project devoted solely to this, so most of
> the tedious research need not be done. It can be found at
> http://predef.sourceforge.net/

Code talks, bullsh*t walks.

Pre-defined macros cannot tell us if one have specific libraries
installed, cannot tell us if formatted IO functions support 'size
specifiers' even though compiler claim C99 compliance or even though
compiler doesn't claim C99 compliance but supports this, etc.

But perhaps the "uname" based compile configuration could be replaced
by testing pre-defined macros... at least for C code, and git is not
only C code.

-- 
Jakub Narebski
Poland
