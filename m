From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] git-commit.txt: Order options alphabetically
Date: Thu, 02 Dec 2010 06:27:58 -0800 (PST)
Message-ID: <m3sjyg2qtc.fsf@localhost.localdomain>
References: <1291215526-11428-1-git-send-email-jari.aalto@cante.net>
	<20101201165043.GF26120@burratino> <87r5e1v2g8.fsf@picasso.cante.net>
	<m362vd4c6h.fsf@localhost.localdomain>
	<87k4jtuyky.fsf@picasso.cante.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
To: Jari Aalto <jari.aalto@cante.net>
X-From: git-owner@vger.kernel.org Thu Dec 02 15:28:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1POA8l-0001bv-BS
	for gcvg-git-2@lo.gmane.org; Thu, 02 Dec 2010 15:28:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932133Ab0LBO2D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Dec 2010 09:28:03 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:38941 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932121Ab0LBO2B (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Dec 2010 09:28:01 -0500
Received: by fxm20 with SMTP id 20so1181404fxm.19
        for <git@vger.kernel.org>; Thu, 02 Dec 2010 06:28:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=M4EAJw5YA1UxSDZ3iHr1nxbIvpBghVksHXcdVDFMgFY=;
        b=jgo6Zf2yuouedfb3WhGjBJ/krmbJVVCicg/r6aXTi5WtkCNbWr9vIiVjtDZyoQ61EO
         MfCOkYmcW9ZaK5RYFDVO81mb6StbI24EpGPblftf3Op/HcgAgAnqK5yXXM2bagGB9ynC
         LXfACXlZdQfOEyVeEu47N2tPr28w6f6vJqgjo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=R9YGW9xvdVSkSJBTfFqjqR5qWAum7yUZeVkeRa1xF+Ye4YWgrcjxHIthIpsSPQGz8/
         p9ewmW8qfqcDgWpoR4rvVoB5O/rujG9jcrF/VTc7u2HjuIAryJOj6r0uTpQ96NmcwRS1
         1iblEjxB8YfQhljcFbjbnuWlbBSskhReegmt4=
Received: by 10.223.109.200 with SMTP id k8mr647546fap.136.1291300080017;
        Thu, 02 Dec 2010 06:28:00 -0800 (PST)
Received: from localhost.localdomain (abwq166.neoplus.adsl.tpnet.pl [83.8.240.166])
        by mx.google.com with ESMTPS id n1sm200319fam.40.2010.12.02.06.27.57
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 02 Dec 2010 06:27:58 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id oB2ERRfE021452;
	Thu, 2 Dec 2010 15:27:37 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id oB2ERBll021447;
	Thu, 2 Dec 2010 15:27:11 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <87k4jtuyky.fsf@picasso.cante.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162708>

Jari Aalto <jari.aalto@cante.net> writes:
> 2010-12-01 19:48 Jakub Narebski <jnareb@gmail.com>:
> > > 2010-12-01 18:50 Jonathan Nieder <jrnieder@gmail.com>:
> >
> > But because some manpages "include" other pages (to refactor common
> > options), it would be impossible to sort alphabetically options in all
> > manpages.  So why bother with impossible?  It would only introduce
> > inconsistency.
> 
> Decreasing entropy is better goal even if we cannot make it perfect. We
> do what we can. And there are many pages that don't use include.

Increasing inconsistency is not good, and that would be the final side
effect.
 
> I don't mind work. You just watch and lean back.

But we do mind unnecessary code churn (well, in this case documentation
churn).  Unless you regard it as "academical" exercise.
 
The final decision on merging in (accepting) changes lies at git
maintainer.

> > > professional, it looks clean. And it works when searching (= no
> > > orientation problems).
> >
> > It works if you have separate user's documentation from reference
> > documentation.  GNU projects were meant to have manpages as reference,
> > and info pages as user's documentation.  Options sorted alphabetically
> > might make sense for reference documentation.
> 
> It makes sense regardless. Printing literature and how people read and
> search information hasn't changed since printing was invented.

How people search information *has* changed since printing was invented.

> > But git manpages doesn't serve _only_ as reference documentation.  And
> > learning commands from manpages where options are sorted alphabetically
> > instead of grouped together by function *suck* big time.
> 
> Nope. Manual pages are not where people learn things any more. They
> Google. They buy books. They copy from fellow worker.
> 
> The manual pages main use it as reference material. We don't need to
> fight the obvious.

Counterexample: Perl manpages.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
