From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv5/RFC 3/6] gitweb: Add manpage for gitweb
Date: Tue, 11 Oct 2011 15:51:08 +0200
Message-ID: <201110111551.09621.jnareb@gmail.com>
References: <1318098723-12813-1-git-send-email-jnareb@gmail.com> <20111010221811.GA21367@elie.hsd1.il.comcast.net> <1318338135.22324.33.camel@drew-northup.unet.maine.edu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>
To: Drew Northup <drew.northup@maine.edu>
X-From: git-owner@vger.kernel.org Tue Oct 11 15:51:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RDcju-0002eT-W2
	for gcvg-git-2@lo.gmane.org; Tue, 11 Oct 2011 15:51:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754089Ab1JKNvU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Oct 2011 09:51:20 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:61541 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753248Ab1JKNvT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Oct 2011 09:51:19 -0400
Received: by eye27 with SMTP id 27so2553951eye.19
        for <git@vger.kernel.org>; Tue, 11 Oct 2011 06:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=DdwW0dhNQZRT8kr2EdkJBjRRuQxagAYbdD3jCY5hRLk=;
        b=uiCMEHXavmkCh6kFnDbf/EWSOBohEUnEY3Tcsj+LM1LCK8l3A9yygaIiSFK5sXLEGk
         yD+VuLcHjjZWMfrDgVC2vZKRl99np+2S9DjxJrzWuQNZ7OR+iBIBljP4SOeypVpi/3k1
         dm66CWTzbSzueQVjss3wXFQj46tn/gwPOD8fA=
Received: by 10.223.61.146 with SMTP id t18mr39667706fah.34.1318341075999;
        Tue, 11 Oct 2011 06:51:15 -0700 (PDT)
Received: from [192.168.1.13] (abwh114.neoplus.adsl.tpnet.pl. [83.8.231.114])
        by mx.google.com with ESMTPS id o22sm37664785fab.11.2011.10.11.06.51.05
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 11 Oct 2011 06:51:06 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <1318338135.22324.33.camel@drew-northup.unet.maine.edu>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183294>

On Tue, 11 Oct 2011, Drew Northup wrote:
> On Mon, 2011-10-10 at 17:18 -0500, Jonathan Nieder wrote:
> > Jakub Narebski wrote:
> > 
> > > The problem is that catering to old AsciiDoc (but still used by some of
> > > long-term-support Linux distributions) requires to have "SYNOPSIS"
> > > section... but there is no natural synopsis for non self-hostable web
> > > application, is there?
> > 
> > I personally think something like
> > 
> > 	SYNOPSIS
> > 	--------
> > 	/usr/share/gitweb/gitweb.cgi
> > 	git instaweb
> > 
> > or perhaps something like
> > 
> > 	SYNOPSIS
> > 	--------
> > 	http://<site>/?p=<project>.git;a=<action>;h=<object>;<parameters>
> > 	http://<site>/<project>/<action>/<object>?<parameters>
> > 
> > would be best.
> 
> This would be why I included a synopsis with my original submission. As
> this was supposed to be a description of the configuration files of said
> application it does not make much sense to put the executable in the
> synopsis. Please forgive me for attempting to make sense!

But this manpage is about _gitweb itself_, not about gitweb config file(s).
Gitweb itself is application, though it is not runnable directly (yet).

Web apps either don't use manpages as documentation, and those that do
that I found (SVN::Web for example) include runnable server-starting script.
-- 
Jakub Narebski
Poland
