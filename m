From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: support the rel=vcs-* microformat
Date: Fri, 09 Jan 2009 17:04:25 -0800 (PST)
Message-ID: <m37i540y5o.fsf@localhost.localdomain>
References: <20090107042518.GB24735@gnu.kitenet.net>
	<gk2794$djn$1@ger.gmane.org> <20090107155023.GA16540@gnu.kitenet.net>
	<cb7bb73a0901071003m77482a99wf6f3988beb5b5e78@mail.gmail.com>
	<20090107184515.GB31795@gnu.kitenet.net>
	<20090107190238.GA3909@gnu.kitenet.net>
	<20090107232427.GA18958@gnu.kitenet.net> <gk4bk5$9dq$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Joey Hess <joey@kitenet.net>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 10 02:06:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LLSIX-0008Bq-Bw
	for gcvg-git-2@gmane.org; Sat, 10 Jan 2009 02:05:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755053AbZAJBE3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Jan 2009 20:04:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752572AbZAJBE3
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Jan 2009 20:04:29 -0500
Received: from nf-out-0910.google.com ([64.233.182.191]:60270 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751081AbZAJBE2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Jan 2009 20:04:28 -0500
Received: by nf-out-0910.google.com with SMTP id d3so1208998nfc.21
        for <git@vger.kernel.org>; Fri, 09 Jan 2009 17:04:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=QUcgCvz6gPCbAujIPSFbGZ8rcOGAWDhROXfqLklQi0k=;
        b=kS+GeB+h8lNdueA4+Qp7urp37CsnHzqJYTom/sl1OFYGal1lDP22uHqprJurGoc4Jp
         FlJn9FX2qNzKzk+gpmgCmq8lIsswRykw8MHsLJHUT+1owTvgzHPLfywFqtNs6r1842kY
         bQZphe5M1DkEJD8qQD8jZlOdKF1vxVuoHfIzU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=bjwa3lNXP2sqwWgBW6TB+PB4IEWqudWq5M/iyiTvq5+WGcq/dPunPWZkRluf1NlFOJ
         y/FTV4uobgLvZQfuGrptNpbKXQ8ZgEL27N5mfY4PqLLfpE201VaPyo6fpCTROG+8Trp1
         DHyR/p6mK9CV0eq25WT4O5hZ24M+PThabyrv0=
Received: by 10.210.66.13 with SMTP id o13mr7500451eba.30.1231549466260;
        Fri, 09 Jan 2009 17:04:26 -0800 (PST)
Received: from localhost.localdomain (abwp34.neoplus.adsl.tpnet.pl [83.8.239.34])
        by mx.google.com with ESMTPS id 10sm1155722eyd.16.2009.01.09.17.04.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 09 Jan 2009 17:04:25 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n0A14OXj028630;
	Sat, 10 Jan 2009 02:04:26 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n0A14Kxf028627;
	Sat, 10 Jan 2009 02:04:20 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <gk4bk5$9dq$1@ger.gmane.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105053>

Giuseppe Bilotta <giuseppe.bilotta@gmail.com> writes: 
> On Thursday 08 January 2009 00:24, Joey Hess wrote:
> 
> > The rel=vcs-* microformat allows a web page to indicate the locations of
> > repositories related to it in a machine-parseable manner.
> > (See http://kitenet.net/~joey/rfc/rel-vcs/)
> 
> Have you considered submitting the microformat to microformats.org?
> That would make the microformat more official and would be an good
> first step to have wider coverage of it, and additional reviews.

Good thinking.  BTW. microformats.org is IIRC wiki (or at least part
of it is wiki), so it should be easy to do...

> 
> > Make gitweb use the microformat if it has been configured with project url
> > information in any of the usual ways. On the project summary page, the
> > repository URL display is simply marked up using the microformat. On the
> > project list page and forks list page, the microformat is embedded in the
> > header, since the URLs do not appear on the page.
> > 
> > The microformat could be included on other pages too, but I've skipped
> > doing so for now, since it would mean reading another file for every page
> > displayed.
> > 
> > There is a small overhead in including the microformat on project list
> > and forks list pages, but getting the project descriptions for those pages
> > already incurs a similar overhead, and the ability to get every repo url
> > in one place seems worthwhile.
> 
> I agree with this, although people with very large project lists may
> differ ... do we have timings on these?

I think while adding this microformat to 'summary' page is non-issue,
we might want to be able configure it out so it is not used for
projects_list page (which might be very large).

And what about OPML, RSS and Atom formats?

>  
> > This changes git_get_project_url_list() to not check wantarray, and only
> > return in list context -- the only way it is used AFAICS. It memoizes
> > both that function and git_get_project_description(), to avoid redundant
> > file reads.
> 
> You may want to consider splitting the patch into three: memoizing
> of git_get_project_description(), reworking of
> git_get_project_url_list(), and the actual rel=vc-* insertions.

Very good idea.  Small, single feature patches are nice.

[...]
> >  sub git_get_project_description {
> >       my $path = shift;
> >  
> > +     return $project_descriptions{$path} if exists $project_descriptions{$path};
> > +
> 
> This line is bordering on the 80 characters, so you may want to
> consider moving 'my $descr' here, with something such as
> 
> my $descr = $project_descriptions{$path};
> return $descr if exists $descr;
> 
> Also, I'm no perl guru so I'm not sure about exists vs defined here.

You might have undefined value in existing key, but I guess that we
can assume that those are equivalent for this.  While 'exists' seems
more up to what you check (does the key exosts in hash) you further on
rely on the fact that $descr is not undefined.

[...]
> >  ## ======================================================================
> >  ## ======================================================================
> >  ## actions
> > @@ -4380,7 +4422,9 @@ sub git_project_list {
> >               die_error(404, "No projects found");
> >       }
> >  
> > -     git_header_html();
> > +     my $extraheader=git_links_header(map { $_->{path} } @list);
> > +
> > +     git_header_html(undef, undef, $extraheader);
> >       if (-f $home_text) {
> >               print "<div class=\"index_include\">\n";
> >               insert_file($home_text);
> > @@ -4405,8 +4449,10 @@ sub git_forks {
> >       if (!@list) {
> >               die_error(404, "No forks found");
> >       }
> > +     
> > +     my $extraheader=git_links_header(map { $_->{path} } @list);
> >  
> > -     git_header_html();
> > +     git_header_html(undef, undef, $extraheader);
> 
> This makes me wonder if it would be worth it to turn git_header_html
> into -param => value style, but I'm not really sure it's worth it.

It is git_header_html(STATUS, EXPIRES, EXTRA)

Hmmm... now I have checked we use either git_header_html() in gitweb
(which is most common), or git_header_html(STATUS) in die_error, or in
a few cases git_header_html(undef, $expires); and now
git_header_html(undef, undef, $extra), so named parameters might be a
good idea... I don't have opinion here...

-- 
Jakub Narebski
Poland
ShadeHawk on #git
