From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: What's cooking in git.git (Oct 2013, #04; Fri, 18)
Date: Sat, 19 Oct 2013 02:35:19 -0500
Message-ID: <526236377d37e_4e9f1021e84d4@nysa.notmuch>
References: <xmqq38nyw7ja.fsf@gitster.dls.corp.google.com>
 <20131019063447.GA18977@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Oct 19 09:43:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VXRCD-0008Vi-SL
	for gcvg-git-2@plane.gmane.org; Sat, 19 Oct 2013 09:43:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751026Ab3JSHnT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Oct 2013 03:43:19 -0400
Received: from mail-oa0-f52.google.com ([209.85.219.52]:33624 "EHLO
	mail-oa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750960Ab3JSHnS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Oct 2013 03:43:18 -0400
Received: by mail-oa0-f52.google.com with SMTP id n10so1305531oag.25
        for <git@vger.kernel.org>; Sat, 19 Oct 2013 00:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=d6NB04VpgFtG36kQHXtRcPQYLxfLx6rM5UjiZzlbJuY=;
        b=A5AETGbVPH0mq0N5mE7JfYWAm7enSf/rV7GnQNOG16zHyVgFnXNwPMOeSNz8VaCYtO
         stTmT+7YLm1e8gnq57Jj5eKns4L5L//rqgagk9jK5Z1xDR+Asejx+HoAKwJukTPa9ZKp
         XOzBuFLztbZ0LVrNiftuZemOSjZqdAk+tWj+n7aPH7h/rG4vuAq3dvRvruuaAhs/10sp
         YtjjkXF0RhchWX0nlSYRwXi+gmwHb5alszaiF6iKXYBC96db4cTMtkDI6ZXkKkYpQQzL
         LVjIcl+Osl0qKyrU+DEyErbp4uHuGzSJ04UxOzFH0yD1b3pWkl3PbJnRabm6Yejt6E38
         wd+A==
X-Received: by 10.182.227.136 with SMTP id sa8mr10007466obc.39.1382168597921;
        Sat, 19 Oct 2013 00:43:17 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id b5sm12966505obj.8.2013.10.19.00.43.16
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 19 Oct 2013 00:43:17 -0700 (PDT)
In-Reply-To: <20131019063447.GA18977@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236390>

Jeff King wrote:
> On Fri, Oct 18, 2013 at 03:14:49PM -0700, Junio C Hamano wrote:
> 
> > * jn/add-2.0-u-A-sans-pathspec (2013-04-26) 1 commit
> >  - git add: -u/-A now affects the entire working tree
> > 
> >  Will cook in 'next' until Git 2.0.
> > 
> > 
> > * jc/core-checkstat-2.0 (2013-05-06) 1 commit
> >  - core.statinfo: remove as promised in Git 2.0
> > 
> >  Will cook in 'next' until Git 2.0.
> > 
> > 
> > * jc/push-2.0-default-to-simple (2013-06-18) 1 commit
> >  - push: switch default from "matching" to "simple"
> > 
> >  Will cook in 'next' until Git 2.0.
> > 
> > 
> > * jc/add-2.0-ignore-removal (2013-04-22) 1 commit
> >  - git add <pathspec>... defaults to "-A"
> > 
> >  Updated endgame for "git add <pathspec>" that defaults to "--all"
> >  aka "--no-ignore-removal".
> > 
> >  Will cook in 'next' until Git 2.0.
> 
> I notice that these are not actually in 'next', despite the
> descriptions.  Should they be, to give them wider exposure?

I say they shouldn't be, unless the next version after 1.8 is 2.0. There should
be a separate branch for 2.0.

-- 
Felipe Contreras
