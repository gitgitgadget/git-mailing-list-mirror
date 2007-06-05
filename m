From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: [PATCH 1/2] Show html help with git-help --html
Date: Tue, 5 Jun 2007 15:42:13 -0400
Message-ID: <fcaeb9bf0706051242o7ded089dwabd281226befe63d@mail.gmail.com>
References: <20070605183420.GA8450@localhost>
	 <20070605193451.GG17377@planck.djpig.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, junkio@cox.net
To: "Frank Lichtenheld" <frank@lichtenheld.de>
X-From: git-owner@vger.kernel.org Tue Jun 05 21:42:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HvevE-0006kv-VS
	for gcvg-git@gmane.org; Tue, 05 Jun 2007 21:42:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762073AbXFETmR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 5 Jun 2007 15:42:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763282AbXFETmR
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Jun 2007 15:42:17 -0400
Received: from an-out-0708.google.com ([209.85.132.244]:48712 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762073AbXFETmR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jun 2007 15:42:17 -0400
Received: by an-out-0708.google.com with SMTP id d31so435924and
        for <git@vger.kernel.org>; Tue, 05 Jun 2007 12:42:15 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=XQmqrw+eR+8tQGgC/GqsvmZ0M47tJCxVs0a71RmmvRX7kZWl9R3eJ/3ta41cOu45qYjph4+6K14bSVoeeDoWLj4YIIH5THWsJSl0+aHDU/6k1JDF+/HGimGrcyYqd03H3C3eE6E5Tfty2SvWDVt3hQ8bupYVQv5KPuJPvP6f5M4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ay0m1LyO2T4f3waO6zavuOK1daRbnlf2Uv7a/iuNTAprEjxIGtPXLTl86eNGxBeVhQRzCRAAqNplIX6A8pDqPvKuKBinBCBOqnFKhLGXb2CgGJtr/tUNXwfz6qv8caF3V3r0/3GdNVaYLG78i48+9bmMhcU3yaJhS6OBMtUmveU=
Received: by 10.100.95.19 with SMTP id s19mr3518972anb.1181072533553;
        Tue, 05 Jun 2007 12:42:13 -0700 (PDT)
Received: by 10.100.198.17 with HTTP; Tue, 5 Jun 2007 12:42:13 -0700 (PDT)
In-Reply-To: <20070605193451.GG17377@planck.djpig.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49221>

On 6/5/07, Frank Lichtenheld <frank@lichtenheld.de> wrote:
> On Tue, Jun 05, 2007 at 06:34:20PM +0000, Nguyen Thai Ngoc Duy wrote:
> > +core.help::
> > +     If 'html', it is equivalent to 'git-help' with option --html.
> > +     If 'auto', it tries to open html files first. If that attempt fails
> > +     (the html program does not exist or the program return non-zero
> > +     value), then it will fall back to man pages. If 'man', always use
> > +     man pages as usual.
>
> This should mention the default value. (Which is 'man', if I read the
> code correctly, isn't it?)

Ok.

>
> > +core.htmlprogram::
> > +     Specify the program used to open html help files when 'git-help'
> > +     is called with option --html or core.help is other than 'man'.
> > +     By default, xdg-open will be used.
> > +     Special strings '%p', '%f' and '%b' will be replaced with html
> > +     full path, file name and git command (without .html suffix)
> > +     respectively. If none is given, '%p' will be automatically appended
> > +     to the command line.
>
> htmlprogram sounds kludgy to me. I would've used htmlcommand or perhaps
> htmlviewer. But I'm no native English speaker, so I might be entirely
> wrong about that.

Will vote for any better name than htmlprogram as I see it awkward too :)
htmlviewer seems better (or htmlviewercommand, which is too long).
Anyway I'm not a native English speaker either.

>
> Gruesse,
> --
> Frank Lichtenheld <frank@lichtenheld.de>
> www: http://www.djpig.de/
>


-- 
Duy
