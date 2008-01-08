From: "Kelvie Wong" <kelvie@ieee.org>
Subject: Re: CRLF problems with Git on Win32
Date: Tue, 8 Jan 2008 07:58:35 -0800
Message-ID: <94ccbe710801080758s5913a3b8x4e17dfba1a5bc387@mail.gmail.com>
References: <Pine.LNX.4.64.0801071010340.1864@ds9.cixit.se>
	 <200801071947.28586.robin.rosenberg.lists@dewire.com>
	 <alpine.LSU.1.00.0801071915470.10101@racer.site>
	 <200801072203.23938.robin.rosenberg.lists@dewire.com>
	 <20080107224204.55539c31@jaiman>
	 <Pine.LNX.4.64.0801081150010.25629@ds9.cixit.se>
	 <eaa105840801080507j1b748fy6fdff8b240cf8c33@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Peter Karlsson" <peter@softwolves.pp.se>, git@vger.kernel.org
To: "Peter Harris" <peter@peter.is-a-geek.org>
X-From: git-owner@vger.kernel.org Tue Jan 08 16:59:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JCGr6-0001Jv-WD
	for gcvg-git-2@gmane.org; Tue, 08 Jan 2008 16:59:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752813AbYAHP6h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jan 2008 10:58:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758108AbYAHP6h
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jan 2008 10:58:37 -0500
Received: from wa-out-1112.google.com ([209.85.146.182]:37768 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757901AbYAHP6g (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jan 2008 10:58:36 -0500
Received: by wa-out-1112.google.com with SMTP id v27so13268405wah.23
        for <git@vger.kernel.org>; Tue, 08 Jan 2008 07:58:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        bh=s94shc/UNL3V2E/CQ16at68g01aRT6dBb8LhpzjpLv8=;
        b=LpWiYVc0OZhYDuGnqG0p4RD6ivRL8BPZz0DEQ+IswMGWwYjSbis2jOaRZnVpIycIKzD+1yq3o28+gSlS7BW6JMtlTxIeiISNRnHD4DhKvYEcVqPtM2rCLc6BHURCsZqcDqs2O1CFfpmiQG7hAuMOG9R0ezUGSNGIqfr5WVYHA94=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=QPoIHiP24yh/6lhAlnq1GTpSX2gItamIxic6Wg5OvIn4tIONC8j6dJtKHNCDl9n8+xqI9Pmfp/NV9sc0OBZ4kwwfli5R5uN2CeZDHmRk7R+DgI+K3G8cuosm773TQfZECktPCdZFNDlzL2GnhMfSMyvwAFqxJoUqTyK11eDGeqE=
Received: by 10.114.179.1 with SMTP id b1mr990385waf.143.1199807915765;
        Tue, 08 Jan 2008 07:58:35 -0800 (PST)
Received: by 10.114.149.15 with HTTP; Tue, 8 Jan 2008 07:58:35 -0800 (PST)
In-Reply-To: <eaa105840801080507j1b748fy6fdff8b240cf8c33@mail.gmail.com>
Content-Disposition: inline
X-Google-Sender-Auth: c7f3ff2f46c73fb6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69886>

On Jan 8, 2008 5:07 AM, Peter Harris <peter@peter.is-a-geek.org> wrote:
> On Jan 8, 2008 5:56 AM, Peter Karlsson <peter@softwolves.pp.se> wrote:
> > Thomas Neumann:
> >
> > > as a user, I expect a SCM to only modify a file when I have
> > > explicitly asked it to do so.
> >
> > As a user, I exepect things to just work. With RCS/CVS/Subversion, it
> > does, because it differentiates between text files (internally encoding
> > NLs with "LF", but I couldn't care less what it uses there) and binary
> > files (which it doesn't change). With git it currently doesn't since it
> > treats everything as binary files.
>
> Actually, Subversion does the Right Thing, and treats everything as a
> binary file until and unless you explicitly set the svn:eol-style
> property on each file that you want it to mangle.
>
> Maybe you set up Subversion auto-props and forgot about it? That would
> be almost (but not really) like setting autocrlf=true in your global
> git config.
>
> Peter Harris
>
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

I'd actually like a feature like this.  On the internal subversion
tree I'm working on (using git-svn), there are quite a bit of files
that have CRLF endings -- we are a cross platform development group.
The solution to this in subversion was that everyone had the same
.subversion/config with a bunch of autoprops set; i.e.:

[auto-props]
*.H = svn:eol-style=native
*.h = svn:eol-style=native
*.CPP = svn:eol-style=native
*.cpp = svn:eol-style=native

and I can't do the same using git-svn.  Thankfully emacs detects CRLFs
and adjusts accordingly, and that's my workaround for it, but it would
be nice to have some kind of gitattribute that allows you to set the
autocrlf according to a filter.

-- 
Kelvie Wong
