From: Techlive Zheng <techlivezheng@gmail.com>
Subject: Re: [DOCBUG] git subtree synopsis needs updating
Date: Sat, 19 Jan 2013 13:48:01 +0800
Message-ID: <20130119054801.GA1218@gmail.com>
References: <20121019152158.4297707b@chalon.bertin.fr>
 <5082FE13.2000003@initfour.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Yann Dirson <dirson@bertin.fr>, git list <git@vger.kernel.org>
To: Herman van Rink <rink@initfour.nl>
X-From: git-owner@vger.kernel.org Sat Jan 19 06:53:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TwRNJ-0000g7-Bb
	for gcvg-git-2@plane.gmane.org; Sat, 19 Jan 2013 06:53:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751226Ab3ASFx0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Jan 2013 00:53:26 -0500
Received: from mail-da0-f44.google.com ([209.85.210.44]:53571 "EHLO
	mail-da0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750895Ab3ASFxZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Jan 2013 00:53:25 -0500
Received: by mail-da0-f44.google.com with SMTP id z20so1932062dae.3
        for <git@vger.kernel.org>; Fri, 18 Jan 2013 21:53:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=TU0FDC+6QXt58KIpnwBZJCradZVseg+D7EYeJIo8TNc=;
        b=slMRnP8lY7GSMYDYGUJkYYaOLAg/LaQQNW+7nFq00YeQ6X7Pp5TVLn2CxbOAt63N20
         gm67lnNrlJJGEvzzMnhtxpACOA5mqu4q8/w+zi8Mj4wjPhUc+b2B/8Hf3AM2vs2vPVhh
         urFhSnvKlkQl2ECtbP8vnkl1P5uyuk+0XYKtLSD6BXSUGCwv4P7iyn2DypZAUP5pnKc6
         MpWpxZ5/gQHFmQqjktV1M9qDkKGkyH5n5sA4jb6p4yW86mZOgVKOxayPgf+eM1ST9eZ7
         HrPdvZhO0lKG4NyV6UNsb62QZu2qfTNkIynVSsi8Kdh7t/MTQNtGqmzbB08uQPZGyBfH
         qLTQ==
X-Received: by 10.66.90.72 with SMTP id bu8mr29835504pab.69.1358574805072;
        Fri, 18 Jan 2013 21:53:25 -0800 (PST)
Received: from gmail.com ([122.244.156.23])
        by mx.google.com with ESMTPS id q4sm4814696paz.20.2013.01.18.21.53.20
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 18 Jan 2013 21:53:24 -0800 (PST)
Mail-Followup-To: Herman van Rink <rink@initfour.nl>,
	Yann Dirson <dirson@bertin.fr>, git list <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5082FE13.2000003@initfour.nl>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213955>

On 12-10-20, Herman van Rink wrote:
> On 10/19/2012 03:21 PM, Yann Dirson wrote:
> > As the examples in git-subtree.txt show, the synopsis in the same file should
> > surely get a patch along the lines of:
> >
> > -'git subtree' add   -P <prefix> <commit>
> > +'git subtree' add   -P <prefix> <repository> <commit>
> >
> > Failure to specify the repository (by just specifying a local commit) fails with
> > the cryptic:
> >
> >  warning: read-tree: emptying the index with no arguments is deprecated; use --empty
> >  fatal: just how do you expect me to merge 0 trees?
> >
> >
> > Furthermore, the doc paragraph for add, aside from mentionning <repository>, also
> > mentions a <refspec> which the synopsis does not show either.
> >
> >
> > As a sidenote it someone wants to do some maintainance, using "." as repository when
> > the branch to subtree-add is already locally available does not work well either
> > (fails with "could not find ref myremote/myhead").
> >
> 
> The version of subtree in contrib is rather out-dated unfortunately.
You should really submit these patches here for reviewing, David is
actively maintaining this tool here.
> 
> I've collected a bunch of patches in
> https://github.com/helmo/git/tree/subtree-updates
> 
> The documentation issue is also fixed in there.
> 
> -- 
> 
> Met vriendelijke groet / Regards,
> 
> Herman van Rink
> Initfour websolutions
> 
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
