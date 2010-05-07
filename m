From: Andreas Hartmetz <ahartmetz@gmail.com>
Subject: Re: git branch documentation improvements
Date: Fri, 7 May 2010 04:28:16 +0200
Message-ID: <201005070428.16827.ahartmetz@gmail.com>
References: <201005070024.41172.ahartmetz@gmail.com> <r2l2cfc40321005061559p9d3a5392rdc2b30f63a34ab9b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 07 04:28:40 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OADIs-0006gh-MF
	for gcvg-git-2@lo.gmane.org; Fri, 07 May 2010 04:28:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752622Ab0EGC2U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 May 2010 22:28:20 -0400
Received: from fg-out-1718.google.com ([72.14.220.158]:9480 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752373Ab0EGC2T (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 May 2010 22:28:19 -0400
Received: by fg-out-1718.google.com with SMTP id 19so2435186fgg.1
        for <git@vger.kernel.org>; Thu, 06 May 2010 19:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:message-id;
        bh=gZ9uDqNvhHP97Tr44oNBQThE4fAjVOvLD14uNWJIJfg=;
        b=MpNyrekLO/avpSTeYarm5fcJcGs5scfQ+ZTyKfurDxjtmvis/w/MbTKry2DPzmMfY0
         KxqP+452HI8WMDBFFertpVSOLDvG03cgoBh494W6Cd40U6aI6DfdKwKAX/A5po04a3Vw
         8Hc1kh/mi8VdWYirwegiPU4DetgzRxV84kAWs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding:message-id;
        b=Mnuwn0vzSopQQMeaKiCMdOjlpY/b0MXPld45Z3wPeUTZd1DfZYW+c64kfPMFzfOOZA
         /s2ufZYn4A48wNRm7ZgR9Ya5zFTYHYwUclP2vLeHhqDzJSVtbjAJ62GF/r1LMMVratjJ
         7/XaYvqqdti2RXERdhzygBB6GzRfkdOgkdmwY=
Received: by 10.87.29.33 with SMTP id g33mr2758147fgj.27.1273199297363;
        Thu, 06 May 2010 19:28:17 -0700 (PDT)
Received: from rechenplan.localnet (brln-4dbc398e.pool.mediaWays.net [77.188.57.142])
        by mx.google.com with ESMTPS id e20sm13305193fga.21.2010.05.06.19.28.16
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 06 May 2010 19:28:17 -0700 (PDT)
User-Agent: KMail/1.13.3 (Linux/2.6.33-02063303-generic; KDE/4.4.75; x86_64; svn-1121149; 2010-04-29)
In-Reply-To: <r2l2cfc40321005061559p9d3a5392rdc2b30f63a34ab9b@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146517>

On Friday 07 May 2010 00:59:22 Jon Seymour wrote:
> On Fri, May 7, 2010 at 8:24 AM, Andreas Hartmetz <ahartmetz@gmail.com> 
wrote:
> > Today I read the git branch documentation and noticed a few things,
> > mostly style and consistency related, that could easily be improved, so
> > I did just that.
> > Please consider merging the attached patch if it looks good, or tell me
> > what you don't like about it.
> > The most significant change is renaming <start-point> (or is it
> > <startpoint>...) to <branch-head> because even I as a relative beginner
> > know that a branch is defined by its (movable) head, and <start-point>
> > *does* actually specify the new branch head if I'm not mistaken.
> 
> While I agree with you start start-point is probably the wrong name
> for this parameter, I wonder whether branch-head might be too
> suggestive that the value of that parameter must itself be an existing
> branch head.
> 
> I think the term "head-commit" would be a more accurate way to
> describe the possible values of this parameter. That is, it is the
> commit that will become the head of the new branch.
> 
Another suggestion I came up with much earlier that I recalled just now:
<new-head>
