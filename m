From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: 66 patches and counting
Date: Wed, 5 Oct 2011 16:55:05 -0500
Message-ID: <20111005215505.GA12747@elie>
References: <4E8CCC55.9070408@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Oct 05 23:55:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBZQy-0007Zj-M6
	for gcvg-git-2@lo.gmane.org; Wed, 05 Oct 2011 23:55:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935374Ab1JEVzU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Oct 2011 17:55:20 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:43331 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934884Ab1JEVzT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Oct 2011 17:55:19 -0400
Received: by gyg10 with SMTP id 10so2010776gyg.19
        for <git@vger.kernel.org>; Wed, 05 Oct 2011 14:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=Cin/lvqEBRwC/udPjUYkmj66CyFw+3P4Wyua3j6uQnQ=;
        b=GEHNpllHd1yEUkWkfeUB0p+/yqaYehS2ld0W6n4HJ/8UEJfQxsCnYsitOmZbOijgEP
         kdedtIBmMuGvHFxoNlmz0HVvzfIkiRB56aGLMkHR4otrFE61axarj7aiucmRSDGekuXZ
         nKqAI+hfJtBo7PeBq6B5/o3Lxww6X8eKyipYY=
Received: by 10.236.144.136 with SMTP id n8mr16895445yhj.12.1317851719370;
        Wed, 05 Oct 2011 14:55:19 -0700 (PDT)
Received: from elie (99-120-124-35.lightspeed.cicril.sbcglobal.net. [99.120.124.35])
        by mx.google.com with ESMTPS id x65sm4317444yhg.18.2011.10.05.14.55.17
        (version=SSLv3 cipher=OTHER);
        Wed, 05 Oct 2011 14:55:18 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4E8CCC55.9070408@alum.mit.edu>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182891>

(+cc: Elijah, who has more experience in this subject than I do)
Hi,

Michael Haggerty wrote:

> My renovation of refs.c [1] is currently at 66 patches and counting.
> What can I say?: (1) I like to make changes in the smallest irreducible
> steps and (2) there is a lot that needed to be done in refs.c.
>
> When I'm done

We've seen series with fifty-something patches on this list before.
My (generic) advice:

 1. Send in installments, early and often.  It would not be fun if the
    first ten patches have a fatal flaw that means the later ones have
    to be reworked.

 2. Make sure the cover letter makes people want to read the later
    patches.  Make sure each patch has a commit message that motivates
    it alone or explains how it fits into the larger picture.

 3. When a patch is not intended to cause any functional change, say
    so, so reviewers can check that.

 4. Include test scripts declaring what effect (or lack thereof) each
    patch is supposed to have.

 5. "Smallest irreducible step" is not necessarily the appropriate
    granularity when publishing.  "Largest piece that a person would
    want to review, apply, or revert independently" is.
