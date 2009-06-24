From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv4 0/2] gitweb: gravatar support
Date: Wed, 24 Jun 2009 09:45:45 +0200
Message-ID: <200906240945.48691.jnareb@gmail.com>
References: <1245710999-17763-1-git-send-email-giuseppe.bilotta@gmail.com> <7vy6riyu5m.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>, git@vger.kernel.org,
	Aaron Crane <git@aaroncrane.co.uk>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 24 09:40:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MJN5z-0005ib-4G
	for gcvg-git-2@gmane.org; Wed, 24 Jun 2009 09:40:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752449AbZFXHk3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Jun 2009 03:40:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751664AbZFXHk2
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Jun 2009 03:40:28 -0400
Received: from fg-out-1718.google.com ([72.14.220.159]:31348 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751392AbZFXHk1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jun 2009 03:40:27 -0400
Received: by fg-out-1718.google.com with SMTP id 16so119112fgg.17
        for <git@vger.kernel.org>; Wed, 24 Jun 2009 00:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=p1UYYlvtqv/EF2xcNtyTYm/VKufJ1TaKBp0uo8/eDkQ=;
        b=AKV0VD0GUtIruoZCg/ESejOL5jstsOeKxhbe91KAhBi+5u6mL9zamCx9jdq9QQvUqf
         BwnszcKIVICjZUrAHR2Urwu0syhIMi3qHPiXSi8qzjv69CVzaYBjLXE8bPtNFTmCLq1y
         WG7YXg+bFyaTeiHTMG+4BF0KcISTFOrOyCJ+U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=vI7m6G2cTAL0O8Y+k5CdV8gmUSN6rD9YEHH0kQLSI+Ox6ckGSuPpmWbbQ3IqyasnUZ
         AkhMIr4PGcqqsRmDsOAW1a+NcNOkcd3cFDjF/E2Dv0a9yDDFAP8Cjm2mGK7nNi4Q2Wsb
         KggDOKubl1KGiIxOC6zmfXBcde+m2wcdNZavI=
Received: by 10.86.49.16 with SMTP id w16mr1029482fgw.4.1245829229838;
        Wed, 24 Jun 2009 00:40:29 -0700 (PDT)
Received: from ?192.168.1.13? (abvk148.neoplus.adsl.tpnet.pl [83.8.208.148])
        by mx.google.com with ESMTPS id d4sm2661979fga.3.2009.06.24.00.40.28
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 24 Jun 2009 00:40:29 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <7vy6riyu5m.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122128>

Junio C Hamano wrote:
> Giuseppe Bilotta <giuseppe.bilotta@gmail.com> writes:
> 
> > As suggested by Junio, the author display refactoring now comes before
> > the actual gravatar feature implementation. The refactoring also goes a
> > little bit deeper, changing the 'commitdiff' view to match 'commit' for
> > the author and committer layout.
> >
> > Giuseppe Bilotta (2):
> >   gitweb: refactor author name insertion
> >   gitweb: gravatar support
> >
> >  gitweb/gitweb.css  |    9 +++-
> >  gitweb/gitweb.perl |  123 ++++++++++++++++++++++++++++++++++++++-------------
> >  2 files changed, 99 insertions(+), 33 deletions(-)
> 
> Thanks.  It looks much better for reviewing, now the order of the patches
> are sane.
> 
> Does anybody have comments on the patches?

I'll send my comments today.

-- 
Jakub Narebski
Poland
