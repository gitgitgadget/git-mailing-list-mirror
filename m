From: "Josh Boyer" <jwboyer@gmail.com>
Subject: Re: [RFC] Add a suffix option to git-format-patch
Date: Wed, 17 Jan 2007 08:50:36 -0600
Message-ID: <625fc13d0701170650j5a9eb7dbyc7527d9c2b999076@mail.gmail.com>
References: <625fc13d0701170510x8883539g93f43d9ddffe56f0@mail.gmail.com>
	 <Pine.LNX.4.63.0701171446410.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jan 17 15:51:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H7C89-0006qH-0I
	for gcvg-git@gmane.org; Wed, 17 Jan 2007 15:51:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932437AbXAQOvK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 17 Jan 2007 09:51:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932444AbXAQOvK
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Jan 2007 09:51:10 -0500
Received: from nf-out-0910.google.com ([64.233.182.190]:22042 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932437AbXAQOvI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jan 2007 09:51:08 -0500
Received: by nf-out-0910.google.com with SMTP id o25so212127nfa
        for <git@vger.kernel.org>; Wed, 17 Jan 2007 06:51:07 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=OlvLsujeXKcqVw8F7hVpk8AySqAyb50nrMHw5Lh2eJnaSZsWyZHMIxMH3q4IJbsKMhWLngM9T+0ZYCAbyiaO2X2DEZTtLGNFE/A0TBWp6faKuzU6fwYKVUsU2UKpptV8fYcLsXnMUR0Cmk+bgJB1EOQVPst6y4uloED3G8LDBfA=
Received: by 10.82.138.6 with SMTP id l6mr1541531bud.1169045436966;
        Wed, 17 Jan 2007 06:50:36 -0800 (PST)
Received: by 10.82.107.18 with HTTP; Wed, 17 Jan 2007 06:50:36 -0800 (PST)
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0701171446410.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37006>

On 1/17/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Wed, 17 Jan 2007, Josh Boyer wrote:
>
> > Could we add an option to git-format-patch to use ".patch" as the file
> > suffix instead of ".txt"?  Something like the below?
> >
> > diff --git a/builtin-log.c b/builtin-log.c
> > index a59b4ac..4eb2d32 100644
> > --- a/builtin-log.c
> > +++ b/builtin-log.c
> > @@ -217,6 +217,7 @@ static int git_format_config(const char *var,
> > const char *value)
> >
> > static FILE *realstdout = NULL;
> > static const char *output_directory = NULL;
> > +static int psuffix = 0;
>
> Why not
>
>         static const char *file_extension = ".txt"
>
> Hmm?

Yes, that's better.  I was more going for "would something like this
option be accepted" to start with.  And I'm lazy, so the patch I wrote
was just an example for my specific use case :).

> You'd call it with "--extension=.patch", and if you really want, you can
> make a config variable from it.

Good idea.  I'll try and get this done soon-ish.  I'm not very
familiar with the git code, so if someone beats me to it, I won't be
disappointed in the least ;)

josh
