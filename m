From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git push default behaviour?
Date: Wed, 14 Mar 2012 18:16:06 +0100
Message-ID: <201203141816.07080.jnareb@gmail.com>
References: <CAFsnPqp1+jX3ZY0LZ1QDmvA=2_ebApPBttwFjr36OuTX2_MHug@mail.gmail.com> <201203131627.30455.jnareb@gmail.com> <CAFsnPqrU7fzybncyhY35iAjjQWpAiW_Y2YAW8ExP6Qrxfbu_Cw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Carlos =?iso-8859-1?q?Mart=EDn_Nieto?= <cmn@elego.de>,
	Thomas Rast <trast@inf.ethz.ch>, git@vger.kernel.org
To: Jeremy Morton <jeremy@configit.com>
X-From: git-owner@vger.kernel.org Wed Mar 14 18:16:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7ro8-0000eF-TI
	for gcvg-git-2@plane.gmane.org; Wed, 14 Mar 2012 18:16:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030288Ab2CNRQM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Mar 2012 13:16:12 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:55083 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932352Ab2CNRQL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Mar 2012 13:16:11 -0400
Received: by wibhq7 with SMTP id hq7so2954602wib.1
        for <git@vger.kernel.org>; Wed, 14 Mar 2012 10:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=8BYS5UGTAN9VZ2JlY03ly1LikcJqMCR6IxHz8Zof/g8=;
        b=hguh57qQIX0Ixa02yL9g8XNZYvUb9/aWzwWq2tlIZrDcA08eUksqXy9XOaYak0giWt
         VCUdyNDvLvb42CxuJOfVy5k9x8f4RnUzI6SXJqj/K/q9KZgrOpBvCp59ta+EK0dw/Olw
         QDTXilNIse3G6OpH6o1KgcKHm++6spcBf12YtmJ+sSbPHt0bUrpcQuveOUEqqzUie1xp
         z1kEEer4ZpbZMdvCYBEOWCMe5SgkV/hy7TclaZUU/J2LtHTat3hh39e3m1Osf19xyytT
         HIRGk5SVIDA9YfL4OB4SwIBsIZArlLd7NY7WnvzkAPWSTR4nW9s080Y4VJdConyDb099
         U7GA==
Received: by 10.180.81.135 with SMTP id a7mr13168564wiy.16.1331745370029;
        Wed, 14 Mar 2012 10:16:10 -0700 (PDT)
Received: from [192.168.1.13] (abvy131.neoplus.adsl.tpnet.pl. [83.8.222.131])
        by mx.google.com with ESMTPS id ff9sm14678994wib.2.2012.03.14.10.16.07
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 14 Mar 2012 10:16:08 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <CAFsnPqrU7fzybncyhY35iAjjQWpAiW_Y2YAW8ExP6Qrxfbu_Cw@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193135>

Could you please do not top-post?  TIA.

Jeremy Morton wrote:
> On Tue, Mar 13, 2012 at 4:27 PM, Jakub Narebski <jnareb@gmail.com> wrote:
> > On Thu, 8 Mar 2012, Jeremy Morton wrote:
> >> On Thu, Mar 8, 2012 at 11:33 AM, Jakub Narebski <jnareb@gmail.com> wrote:
> >
> >> > You can always configure server to refuse forced pushes.
> >>
> >> We're using github, and as far as I'm aware, there's no way to
> >> configure github to do that.
> >
> > It would be nice if GitHub supported setting receive.denyNonFastForward
> > and receive.denyDeletes (the receive.*current* do not matter for GitHub).
> > Though I am not sure if it would not require changes to the custom Git
> > implementation they use...
>
> Would that deny non fast-forwards for all branches, though, or just
> selected ones?  We'd like to just to it for 2 of our branches.  We'd
> also like to explitly ALLOW fast-forwards to master, when we want to
> merge in from develop to master.

No, receive.denyNonFastForward is for all branches only.  If you want
per-branch access control, try gitolite... again not available on GitHub
(unless GitHub allows custom hooks).
 
> A better description of what we want is to prevent 'rewriting of
> history' for some of our branches.

C.f. http://thread.gmane.org/gmane.comp.version-control.git/189895
     http://thread.gmane.org/gmane.comp.version-control.git/189946/focus=191119

Though that is only a proposal and a prototype.
-- 
Jakub Narebski
Poland
