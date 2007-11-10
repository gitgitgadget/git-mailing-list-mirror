From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: gitweb, updating 'last changed' column on the project page
Date: Sat, 10 Nov 2007 08:05:39 -0500
Message-ID: <9e4733910711100505n78459612xdaa12eaa880773d8@mail.gmail.com>
References: <9e4733910711091709k173bf23flf2824673f82de9bb@mail.gmail.com>
	 <9e4733910711092201n5aaeeb7cvfd0e76e43170d481@mail.gmail.com>
	 <9e4733910711092210o65759276sd6970af5d29f2f32@mail.gmail.com>
	 <200711101034.47861.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 10 14:06:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iqq2B-0000XD-6X
	for gcvg-git-2@gmane.org; Sat, 10 Nov 2007 14:05:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752232AbXKJNFn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Nov 2007 08:05:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752056AbXKJNFm
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Nov 2007 08:05:42 -0500
Received: from wa-out-1112.google.com ([209.85.146.179]:25993 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752179AbXKJNFl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Nov 2007 08:05:41 -0500
Received: by wa-out-1112.google.com with SMTP id v27so930398wah
        for <git@vger.kernel.org>; Sat, 10 Nov 2007 05:05:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=YpMRsnoz23tMU/Ny2oPBk1WdpJOkUv/3p3+XaYCN2lc=;
        b=i4K73a83N6K5ML8XJXL4iCBbqHJmu/0k+I7SOrqLaG0WsqXara3YdQJjms3mBdo0AD8eEbW2sBItgdRBauChTttPBEbcJnVgDsMCpm4hphC1kDEcSc0XXIgRNm7re9T+fnlDPaQK/St7g3pxt7VCLDHsJ16ih/HcOD6k+TGFQRM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=NU3ykWiRiTmZYopuYWA2xbVD+gi41as9PUQclKi9U09rykVnnBkh8G7Eh8DSrIyD4ZU5tspRdT5ROS/Su54JEjnEe2PcHRRTguamkl96J3OPx5aaiL96yi1073s8yQzZ+91Px+CcTljau2c5dDlNTvUyaMCo+FkCz9ycl4B/iTA=
Received: by 10.114.198.1 with SMTP id v1mr188960waf.1194699939568;
        Sat, 10 Nov 2007 05:05:39 -0800 (PST)
Received: by 10.115.54.19 with HTTP; Sat, 10 Nov 2007 05:05:39 -0800 (PST)
In-Reply-To: <200711101034.47861.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64343>

On 11/10/07, Jakub Narebski <jnareb@gmail.com> wrote:
> On Saturday, 10 November 2007, Jon Smirl wrote:
> > On 11/10/07, Jon Smirl <jonsmirl@gmail.com> wrote:
> >> On 11/9/07, Jakub Narebski <jnareb@gmail.com> wrote:
> >>> Jon Smirl wrote:
> >>>
> >>>> At http://git.digispeaker.com/ the 'last change' column is not getting updated.
> >>>>
> >>>> mpc5200b.git
> >>>>       DigiSpeaker for Freescale MPC5200B.
> >>>>       Jon Smirl
> >>>>       5 weeks ago
> >>>>       summary | shortlog | log | tree
> >>>>
> >>>> It still says 5 weeks ago, but if I click on the project last change is today.
> >>>>
> >>>> What controls this? I tried running update-server-info
> >>>
> >>> What does
> >>>
> >>>   git for-each-ref --format="%(refname):%09%(committer)" --sort=-committerdate
> >>>       refs/heads
> >>
> >> [daedalus]$ git for-each-ref --format="%(refname):%09%(committer)" \
> >> --sort=-committerdate refs/heads
> >> refs/heads/m24: Jon Smirl <jonsmirl@gmail.com> 1191362799 -0400
> >> refs/heads/m25: Jon Smirl <jonsmirl@gmail.com> 1191472422 -0400
> >> refs/heads/m26: Jon Smirl <jonsmirl@gmail.com> 1194382038 -0500
> >> refs/heads/m28: Jon Smirl <jonsmirl@gmail.com> 1194385071 -0500
> >> refs/heads/m29: Jon Smirl <jonsmirl@gmail.com> 1194585780 -0500
> >
> > It appears to be using the first head instead of the most recent date.
> It appears to not _sort_ the output by committerdate, as it should with
> '--sort=-committerdate'.

It is sorted by committerdate, the sort is ascending. Did you expect
it to be descending, pick off the last entry instead of the first?

>
> 1442:[gitweb/web!git]$ git for-each-ref --format="%(refname):%09%(committer)" \
>   --sort=-committerdate refs/heads
> refs/heads/gitweb/web:  Jakub Narebski <jnareb@gmail.com> 1194616779 +0100
> refs/heads/man: Junio C Hamano <junio@hera.kernel.org> 1194602628 +0000
> refs/heads/html:        Junio C Hamano <junio@hera.kernel.org> 1194602626 +0000
> refs/heads/origin:      Junio C Hamano <gitster@pobox.com> 1194602274 -0800
> [...]
> refs/heads/gitweb-snapshot+navbar:      Sven Verdoolaege <skimo@kotnet.org> 1134765981 +0100
>
> 1443:[gitweb/web!git]$ git --version
> git version 1.5.3.5
>
>
> Note that git-for-each-ref with those options returns most recent head
> first, sorting output by date of commit (date of adding to repository)
>
> >>>
> >>> return? Does adding --count select proper branch, with proper update
> >>> date?
> >>
> >> Is it looking for master, and just picking the first branch instead?
>
> Gitweb should not (and I think does not) have 'master' hardcoded
> anywhere. It might use HEAD in some cases you don't want it to...
>
> >>>
> >>> Which gitweb version is this?
> >>
> >> <!-- git web interface version 1.5.3.5.605.g79fa-dirty, (C) 2005-2006,
> >> Kay Sievers <kay.sievers@vrfy.org>, Christian Gierke -->
> >> <!-- git core binaries version 1.5.3.5.605.g79fa-dirty -->
>
> Older version of gitweb used HEAD branch for'last changed' info on
> the projects list page. That is why I asked about gitweb version.
>
> But this is not the case of your problem:
> 1. Your gitweb is new enough to use git-for-each-ref. It use
>    git for-each-ref --format="%(committer)" --sort=-committerdate
>                     --count=1 refs/heads
> 2. Looking at 'heads' view (or 'heads' part of summary view) one can see
>    that m29 is current branch (HEAD), and it is most recent.
>
> Strange...
> --
> Jakub Narebski
> Poland
>


-- 
Jon Smirl
jonsmirl@gmail.com
