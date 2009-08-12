From: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
Subject: [PATCH] Re: [TRIVIAL] Documentation: merge: one <remote> is
	required
Date: Wed, 12 Aug 2009 15:29:24 +0200
Message-ID: <20090812132924.GA28345@vidovic>
References: <1249995838.1589.3.camel@localhost.localdomain> <20090811144253.GA12956@vidovic> <1250002681.2707.2.camel@localhost.localdomain> <7vy6ppbvdf.fsf@alter.siamese.dyndns.org> <m31vnhpc5v.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Paul Bolle <pebolle@tiscali.nl>,
	Nicolas Sebrecht <nicolas.s.dev@gmx.fr>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 12 15:29:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MbDtd-0000kA-3t
	for gcvg-git-2@gmane.org; Wed, 12 Aug 2009 15:29:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752492AbZHLN3b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Aug 2009 09:29:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752487AbZHLN3a
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Aug 2009 09:29:30 -0400
Received: from mail-ew0-f214.google.com ([209.85.219.214]:47325 "EHLO
	mail-ew0-f214.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752483AbZHLN3a (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Aug 2009 09:29:30 -0400
Received: by ewy10 with SMTP id 10so534ewy.37
        for <git@vger.kernel.org>; Wed, 12 Aug 2009 06:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:to:cc
         :subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=WtW7zckc2bschO2g1k1GeVzRqfMaqQpAU4d4Pu6Z7e8=;
        b=KOuoLC4oDcmOC3Bc7IqjLoTvV36Hvcwqx6iJm+evh3+DWHT5hwGnC4PAVQWFORSeZT
         rvzqAW0n8xdpq/Kk/7knFwckVYCu067/zdHcI39tuTbIM4E27fwVwDCNMeyuPncR4jm4
         sSi1NZlxBDjAS/VgzsUyuDRnUJ3yRzMWIjbnE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=D5K302PMSQwsja64xUxX7YO2xhsq67MwszQhs1HVne9cB5/ddD3C+OU5DeaMy4vMed
         BiKhJpSZNkwaIdH6B6fKzodW2t7NDOrE3JS0OFOK9Tc6hk31wQcl8b+0mwMkOHjIZh+G
         aDe5uKJeANBLidy0OinIMVSWFZapxRxAIS+ik=
Received: by 10.210.87.2 with SMTP id k2mr2466759ebb.32.1250083769999;
        Wed, 12 Aug 2009 06:29:29 -0700 (PDT)
Received: from @ (91-164-150-212.rev.libertysurf.net [91.164.150.212])
        by mx.google.com with ESMTPS id 5sm779761eyh.16.2009.08.12.06.29.26
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 12 Aug 2009 06:29:28 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <m31vnhpc5v.fsf@localhost.localdomain>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125696>

The 12/08/09, Jakub Narebski wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
> > After you brought up this "one or more", I re-read the docs your patches
> > touched, thinking that the author might have meant 'zero or more of A'
> > with these '<A>...'  notation.
> > 
> > And I realized that they made perfect sense.

This was my initial thought but...

> I would have thought that it makes more sense to have
> 
>   <something>...
> 
> for one or more, and
> 
>   [<something>... ]
> 
> for zero or more (optional one or more).

...their sense is what Posix states:

  Ellipses ( "..." ) are used to denote that one or more occurrences of an
  operand are allowed. When an option or an operand followed by ellipses
  is enclosed in brackets, zero or more options or operands can be
  specified. The form:

  utility_name [-g option_argument]...[operand...]

http://www.opengroup.org/onlinepubs/9699919799/basedefs/V1_chap12.html#tag_12_01
(& 12.1.9)


-- 
Nicolas Sebrecht
