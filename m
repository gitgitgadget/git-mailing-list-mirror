From: "Benjamin Sergeant" <bsergean@gmail.com>
Subject: Re: p4 + svn + git
Date: Thu, 7 Jun 2007 22:31:23 -0700
Message-ID: <1621f9fa0706072231r7ae26d2ew220d7ed9238b5e24@mail.gmail.com>
References: <1621f9fa0706072145s3ea6d5cdt3c3e6a2eaaffa14c@mail.gmail.com>
	 <1621f9fa0706072227s7b64e4abq682b53eb920c8f53@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 08 07:31:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HwX4S-0008RA-17
	for gcvg-git@gmane.org; Fri, 08 Jun 2007 07:31:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754778AbXFHFb1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 8 Jun 2007 01:31:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757265AbXFHFb1
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jun 2007 01:31:27 -0400
Received: from ik-out-1112.google.com ([66.249.90.178]:45148 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758434AbXFHFb0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jun 2007 01:31:26 -0400
Received: by ik-out-1112.google.com with SMTP id b32so649290ika
        for <git@vger.kernel.org>; Thu, 07 Jun 2007 22:31:24 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fB178K85epkePpPV/CN5KsFIjHrlcnZbjATWFpwbf/ODLu96nGHfx3IuFncTmbXgrveM0XSC8LY6fw2stHZfjaSc3cOS4cvm+1ZWyhq2u9hotOBsZQYkMSczivQTXLqvidifqIMtF8MQOAlr0aiqWGhbNBpDcgFHtAZDv2RkoDQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jby6IIVzButxJOB5Vp0Hwp3s51el6CDAo5NkqzL92qR37ozDppoKQ61mJRLLtkXd9CNwiI15EaV7lrH2HZxgeOdEu9gts1ENTXnZ9D3xVkg/4xa4qegHWsR/C4tv3dPz+er1DTWCRZaJse75BrKhLAVllTZOpFVzJzeS7YSiA3g=
Received: by 10.142.254.8 with SMTP id b8mr130020wfi.1181280683745;
        Thu, 07 Jun 2007 22:31:23 -0700 (PDT)
Received: by 10.143.43.1 with HTTP; Thu, 7 Jun 2007 22:31:23 -0700 (PDT)
In-Reply-To: <1621f9fa0706072227s7b64e4abq682b53eb920c8f53@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49434>

Looks like this git-p4 is there:
http://repo.or.cz/w/fast-export.git

On 6/7/07, Benjamin Sergeant <bsergean@gmail.com> wrote:
> On 6/7/07, Benjamin Sergeant <bsergean@gmail.com> wrote:
> > That might be too much, but let's ask anyway...
>
> This is probably too much, so on to the next question:
> Is there a perforce equivalent of git-svn ?
>
> What I'd like to do:
> My main Linux machine will be the gateway.
>
> 1. I 'clone' the perforce tree with git-p4. I now have a .git, a full repo.
> Can I use this as the equivalent of a subversion server, so that every
> other machines pull / push from it.
>
> And once in a while (weekly basis), I push the work that's been done
> in git to perforce using the Linux box.
>
> Doest that make sense ?
>
> Thanks,
> Benjamin.
>
>
> >
> > My company uses perforce.
> > I took a snapshot of some code checked out from perforce (a single
> > branch), that I imported into subversion, a while ago, and started
> > working with svn only. I have different Unix machines checking in /
> > out code code from the subversion server (with svn), and I'd like to
> > keep it this way (if possible).
> >
> > I'm wondering if I could use git as a gateway between both systems, to
> > merge code in both direction (svn <-> perforce).
> >
> > Is this possible, with the help of git-p4import, git-svn, and using
> > several branches ?
> >
> > Thanks,
> > Benjamin.
> >
>
