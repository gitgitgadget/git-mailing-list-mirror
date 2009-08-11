From: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
Subject: [PATCH] Re: [TRIVIAL] Documentation: add: <filepattern>... is
	optional
Date: Tue, 11 Aug 2009 16:50:41 +0200
Message-ID: <20090811145041.GB12956@vidovic>
References: <1249995790.1589.2.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Paul Bolle <pebolle@tiscali.nl>
X-From: git-owner@vger.kernel.org Tue Aug 11 16:51:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Masgr-0006vJ-04
	for gcvg-git-2@gmane.org; Tue, 11 Aug 2009 16:51:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754990AbZHKOup (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Aug 2009 10:50:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754566AbZHKOup
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Aug 2009 10:50:45 -0400
Received: from mail-ew0-f214.google.com ([209.85.219.214]:55459 "EHLO
	mail-ew0-f214.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754071AbZHKOuo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Aug 2009 10:50:44 -0400
Received: by ewy10 with SMTP id 10so3835305ewy.37
        for <git@vger.kernel.org>; Tue, 11 Aug 2009 07:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:to:cc
         :subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=ydBu4TekpVFZaII6/2sNaAyaWznGLOkI4PMk4BFVltE=;
        b=NObvO87OWkln3M0IwZXVO3mfxbTBbucemBBRn/WOBZ+Ex0EACP4Vwt/d/FmwiOYFow
         bJbLoHUYSCNxc25Vztq+2nL/u+RXi//eelbdUB69oLnLhaX+vrsb9LcA9JJn4NWnrIkZ
         DPNWSq+WZmF25X9x3TOqxqKUCxniohDWBpV48=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=aJpPMPMdNuJgWq11O4Qrl8kNZH9J7fOxw/sws6kCEAVPVs9zfOS4JcvpyyAoyUoGEH
         vrqmKEfAPh7bmoEuSbxUGF7mBQGEOscFqh8nbMoy5m0HuYEL+Ugcu72A+vKh819g2iss
         lvpiS01HnkS6B+MuJRKi72BkZCQYcqXupqq3c=
Received: by 10.210.62.3 with SMTP id k3mr6567374eba.36.1250002244667;
        Tue, 11 Aug 2009 07:50:44 -0700 (PDT)
Received: from @ (91-164-138-47.rev.libertysurf.net [91.164.138.47])
        by mx.google.com with ESMTPS id 10sm3825918eyz.51.2009.08.11.07.50.43
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 11 Aug 2009 07:50:43 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1249995790.1589.2.camel@localhost.localdomain>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125566>

The 11/08/09, Paul Bolle wrote:

> <filepattern>... is optional (e.g. when the --all or --update
> options are used) so use square brackets in the synopsis.

So <filepattern> is needed in all other cases. The '-u' description
already has

	" If no paths are specified, all tracked files in the current
  directory and its subdirectories are updated. "

and '-a' refers to '-u'

  "(same as --update)"

.

-- 
Nicolas Sebrecht
