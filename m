From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: vcs-svn and friends
Date: Thu, 15 Sep 2011 15:48:15 -0500
Message-ID: <20110915204815.GA31508@elie>
References: <CAFfmPPOBZ6cXG51mDHbj2VRDzjvH46Q7=_LvUWeMq0SGR40S1g@mail.gmail.com>
 <27874151.17649.1316095596748.JavaMail.root@mail.hq.genarts.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Michael Barr <davidbarr@google.com>,
	Dmitry Ivankov <divanorama@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Stephen Bash <bash@genarts.com>
X-From: git-owner@vger.kernel.org Thu Sep 15 22:48:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R4IrC-0004l0-Fy
	for gcvg-git-2@lo.gmane.org; Thu, 15 Sep 2011 22:48:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934920Ab1IOUsY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Sep 2011 16:48:24 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:57859 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934721Ab1IOUsX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Sep 2011 16:48:23 -0400
Received: by iaqq3 with SMTP id q3so1522759iaq.19
        for <git@vger.kernel.org>; Thu, 15 Sep 2011 13:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=vOVr7S8IttNlwAaZri3kpCT5togFPUTpafY+UZ9yFgk=;
        b=Ufasc9hQ7EKnL5aAPR3noc4nR+n3PIz0DPuxoemINAyxbKTzpDsXELhwTe+SQsc0Ds
         KXPGppxhPcgf+szIPBy/mZD3PO7Ctmpa1bgUNoYqqWbOMl93jsFMwsAvoixz0HPeg9Lt
         Kn+6JVBkZcLvdhw4FxOjGsJh1ZhFV1ViZbUSw=
Received: by 10.231.50.202 with SMTP id a10mr2755188ibg.39.1316119702913;
        Thu, 15 Sep 2011 13:48:22 -0700 (PDT)
Received: from elie (99-120-124-35.lightspeed.cicril.sbcglobal.net. [99.120.124.35])
        by mx.google.com with ESMTPS id el2sm6174909ibb.10.2011.09.15.13.48.20
        (version=SSLv3 cipher=OTHER);
        Thu, 15 Sep 2011 13:48:21 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <27874151.17649.1316095596748.JavaMail.root@mail.hq.genarts.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181493>

Stephen Bash wrote:

> For those of us interested but out of the loop, does this mean you
> have a working example where I can point it at a SVN repo and see
> what happens?  Having done our SVN to Git conversion last year, I
> know our repo has a lot of the common SVN screw cases (non-branching
> copies, partial merges, mis-merges, *lots* of retagging, changes
> committed to tags, etc.) so if it's relatively easy to setup a test
> I'm happy to run one.

Thanks.  It's very bare-bones at the moment: it just imports each
revision as a whole tree, with no branch and merge tracking at all.
So it would be very interesting to get this basic stuff out into the
wild and then add some code implementing those things for you to break
on top of it.
