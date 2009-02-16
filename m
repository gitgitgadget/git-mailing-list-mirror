From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: What's cooking in git.git (Feb 2009, #04; Sun, 15)
Date: Mon, 16 Feb 2009 17:44:45 +0100
Message-ID: <200902161744.46450.jnareb@gmail.com>
References: <7v1vu0nfu4.fsf@gitster.siamese.dyndns.org> <m3ocx4t0mv.fsf@localhost.localdomain> <1234798042.499985da2915e@mail.nimag.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Sebastien Cevey <seb@cine7.net>
X-From: git-owner@vger.kernel.org Mon Feb 16 17:46:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZ6bu-0004Wu-1i
	for gcvg-git-2@gmane.org; Mon, 16 Feb 2009 17:46:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752302AbZBPQox (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Feb 2009 11:44:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751422AbZBPQox
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Feb 2009 11:44:53 -0500
Received: from mail-ew0-f21.google.com ([209.85.219.21]:50724 "EHLO
	mail-ew0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751544AbZBPQow (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Feb 2009 11:44:52 -0500
Received: by ewy14 with SMTP id 14so1966119ewy.13
        for <git@vger.kernel.org>; Mon, 16 Feb 2009 08:44:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=DyWLN1CSNtrL5Ta5fPNGX0Hft3+kGBNgZLT9xBYjcwA=;
        b=JjlU4L1cSa540hB/wOHDLP+NyFhUWxvGtKOYXoQhiAsYbR4176pa/bScvpZoz7Lvx+
         eDXZtLq9cTEiIaGo3ieImPRrIiQzikNt9PqOwKzTIIBVbEHnYnyR0ZoENzge5mAi0/sY
         KX2xzP4YeTtvEM93pGffXGBglnIeUs7iPQoJc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=ru+9LJAYEclk3gfVdoq1vnEazQ9+lst3QcT1D0E5iJO+6rEbtv/2S59sGoBKe1mE4x
         NCjladcRM6tt2GjcILZ4a4o5fqc6pcSSklTdrUlr8Zrd+lLLJ5YJACfvMGyApbG7uiaX
         QrfAZZx0zb2p7xQCQEhKOp4kHq43c0k3EmhWk=
Received: by 10.210.66.13 with SMTP id o13mr4500951eba.127.1234802690189;
        Mon, 16 Feb 2009 08:44:50 -0800 (PST)
Received: from ?192.168.1.13? (abwt47.neoplus.adsl.tpnet.pl [83.8.243.47])
        by mx.google.com with ESMTPS id 5sm1752398eyf.12.2009.02.16.08.44.48
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 16 Feb 2009 08:44:49 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <1234798042.499985da2915e@mail.nimag.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110206>

On Mon, 16 Feb 2009, Sebastien Cevey wrote:
> Selon Jakub Narebski <jnareb@gmail.com>:
> > Junio C Hamano <gitster@pobox.com> writes:
> > 
> > > * sc/gitweb-category (Fri Dec 12 00:45:12 2008 +0100) 3 commits
> > >  - gitweb: Optional grouping of projects by category
> > >  - gitweb: Split git_project_list_body in two functions
> > >  - gitweb: Modularized git_get_project_description to be more generic
> > > 
> > > Design discussion between Jakub and Sebastien seems to have stalled.
> > 
> > But I am bit stalled at second patch in the series, which extract
> > _printing_ the rows in separate function... while it should IMHO also
> > refactor _filtering_ projects list, and not have "filtering as we
> > print" current code uses... which would be night incompatibile with
> > dividing projects list into pages.
> > 
> > I think this patch series is definitely for after 1.6.2
> 
> Okay, I am sorry but I'm going to give up at this point. This patch has been in
> the pipeline since July 27, 2008.

I am sorry to hear about that.

A bit of it is a bad timing (hitting feature freeze before release of
next major version of git), some of it is my fault not reviewing
patches fast enough.  Some of it bad communication: me not writing
review (and you not prodding), you not resending patches (and me not
prodding.)

> I understand the iterative review process to 
> ensure a certain code quality and acknowledge that these patches weren't
> perfect (and probably still aren't), but it's a bit too much of extra rewrite to
> support features that didn't exist and still don't exist yet AFAIK (page splitting of
> projects page?).

You are right, and I am sorry about that. That was a bit of overeager
overengineering on my part.

If we skip this unnecessary future-proofing the code, two things that
are left to be corrected is mentioned in this thread changing order of
parameters and better commit message for 1st patch, and IIRC removing
unnecessary sorting in 3rd patch in series.

> Feel free to take over and do the changes you have in mind, 
> it'd probably be faster than trying to guide me through it; I still believe
> it'd be a welcome feature, and we've been waiting for it to be merged upstream for
> quite a while to activate it on the XMMS2 gitweb.

I have those patches in my clone of git, and I would tinker with them
if you don't want to spend more time on them.

> 
> I have to admit I'm not particularly fond of hacking Perl, but the effort to
> get this rather simple and isolated feature merged don't make it very attractive.

OTOH there were many features and improvements to git and gitweb that
were send, and resend, and still aren't there (e.g. AJAX-y blame in
gitweb, vcs-* microformat in gitweb, sparse checkout in git, refs/replace
in git, etc.).

> 
> It's a single 6300+ line Perl script we're talking about after all.

gitk has 10000+ lines... in Tcl/Tk...
git-svn has 5300+ lines, not much less...

-- 
Jakub Narebski
Poland
