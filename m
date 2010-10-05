From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: Advertising the Git User's Survey 2011
Date: Tue, 5 Oct 2010 08:56:48 +0530
Message-ID: <20101005032641.GA9014@kytes>
References: <AANLkTim1mLhQnJPT9KiinR4L3C=O9L=V9M3X9x7Cr+oC@mail.gmail.com>
 <201010031655.40521.jnareb@gmail.com>
 <20101003180743.GK328@kytes>
 <201010040129.22302.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 05 05:27:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2yBz-00033h-L9
	for gcvg-git-2@lo.gmane.org; Tue, 05 Oct 2010 05:27:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757227Ab0JED1p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Oct 2010 23:27:45 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:52619 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753666Ab0JED1p (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Oct 2010 23:27:45 -0400
Received: by qyk29 with SMTP id 29so1221710qyk.19
        for <git@vger.kernel.org>; Mon, 04 Oct 2010 20:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=OBIf2WqKFPDQQJIjd1CBZlNH9+nsK7AZqdbthvdsl8o=;
        b=rwUvWBBVbEiEi3Tl1AgI8nCCn9ZvxjEFzN6Kxtgh+PfXwT1Vxz5wK3gx5yVLnDW4en
         IPzXS3D++XeAUnRXyrLjda2rckhKb9lBxH2vAWpJdlIjCS7wqI6bp0bHVbBTxhyeOdgs
         z+v4qcWXybWCKUW3Ip7gYEFVnTbtgRWQ3of4I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=qwtAnqxTuUwlpdgZT5qsGf+jKCvNOdBxIG0dYFSWlH4gLLCqH/544MZILvkVC3din1
         JdLP59XhvOK4F89+AR+iM3tG8UwOmBd+nCFRgC+dl2b/SjMH+jdBuXO5LpaiY3fQ6XUl
         0M56jsYLbhOFWLVJUmgOusxas16CTr9fi9tkA=
Received: by 10.229.182.141 with SMTP id cc13mr7907135qcb.56.1286249264475;
        Mon, 04 Oct 2010 20:27:44 -0700 (PDT)
Received: from kytes ([203.110.240.41])
        by mx.google.com with ESMTPS id e5sm122096qcq.15.2010.10.04.20.27.40
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 04 Oct 2010 20:27:42 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <201010040129.22302.jnareb@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158162>

Hi Jakub,

Jakub Narebski writes:
> Ramkumar Ramachandra wrote:
> > Jakub Narebski writes:
> >> On Sun, 3 Oct 2010, Ramkumar Ramachandra wrote:
> >>> Perhaps we can email survs.com and ask them?
> >> 
> >> Should I do it, or would you do it?
> > 
> > Er, why will they know who I am and give me this information? You've
> > been in touch with them before, I hope?
> 
> Well, I sent a bit of feedback, bugreports and feature requests while
> Survs.com was still in beta...

Do contact them then, and let us know what the results are.

> >>> I suppose we could always work out a way to display the results from
> >>> the information Survs.com gives us.
> >> 
> >> Do you have any idea how to display such geographical information, and
> >> what tool to use for that visualization?
> > 
> > A quick Google search pointed me to several tools that parse a
> > plaintext file of (lattitude, longitude) entries and use the Google
> > Maps API to plot them. I'm sorry, but I don't know much more about
> > this.
> 
> What we have is the names of countries (which can be quite large) rather
> than geographical coordinates.  Perhaps use color to mark countries on
> the political map, or something?

Right. Sure.

> >>> Nice histogram! How did we manage to do this in 2009? Did we use a
> >>> custom-made application to do the survey?
> >> 
> >> I used a Perl script, which uses Text::CSV to parse data exported from
> >> Survs.com in CSV format (and PerlIO::gzip to not have to decompress it).
> >> Each survey page on Git Wiki, except for the very first survey, contains
> >> link to file with such exported data.
> >> 
> >> For example for age it extracts digits from the response, and assumes
> >> that it is number of years.  It also creates this nice table of ranges
> >> that you can see in the mentioned section of GitSurvey2009 page.
> >> 
> >> I can publish this script, e.g. the one used for 2009 survey on the
> >> GitSurvey2009 page, but it is rough'n'dirty script.
> > 
> > Sounds good- we should create a small repository that contains all the
> > tools used, notes made, and results (in semantic format) of previous
> > surveys. Embarrassingly enough, I can't read Perl myself, but I'm sure
> > the others will find it useful. Also, isn't there some Perl module to
> > use Google Maps API to draw that map?
> 
> Good idea.

I don't know if the Maps API allows for you to mark numbers on the
map. After all, we don't needs markers for specific coordinates, but
just a numerical label for each country. There's probably something to
even contour-color the countries based on the number- I'll let you
know if I find something we can use.

-- Ram
