From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: vcs-svn and firends
Date: Thu, 15 Sep 2011 12:45:39 -0500
Message-ID: <20110915174539.GB19450@elie>
References: <CAFfmPPMPYRgfEpN0aWcgVHt1oonp0OxvgD+SKteKjnsBv4WjmA@mail.gmail.com>
 <CA+gfSn98tWxkTnXEg8eZmLA-bYuN2xQHiqQnOYRBbaEvd+35KA@mail.gmail.com>
 <CAFfmPPOPkSOSsQk_T5_m7Oa2TBBqA4L_aANS8QF5rEtXnDY+sg@mail.gmail.com>
 <CA+gfSn8+5ot4hJg_m-YYxeeqHPx2OBPLYBVpUh01oBwSJ37ncw@mail.gmail.com>
 <CAFfmPPMfZBiEhz3rBdUaa=MHjEnKxqh_KQaAiZ=fVN5aXOcfYg@mail.gmail.com>
 <CA+gfSn9TU1mfAifL=1CDdq_cz7M7BgNLDuPAtzbMSf04WB-K3w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Michael Barr <davidbarr@google.com>, git@vger.kernel.org
To: Dmitry Ivankov <divanorama@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 15 19:45:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R4G0S-0003ya-O1
	for gcvg-git-2@lo.gmane.org; Thu, 15 Sep 2011 19:45:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934267Ab1IORpo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Sep 2011 13:45:44 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:65238 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934241Ab1IORpn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Sep 2011 13:45:43 -0400
Received: by iaqq3 with SMTP id q3so1385044iaq.19
        for <git@vger.kernel.org>; Thu, 15 Sep 2011 10:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=qJFanubeBRHrZRr04Tdf6yA1+oS1lBAD1VHeuRUW+gQ=;
        b=IrPuUQ0ABtAOy83XY1lYI5HHf7tJve2AouupKsO+ACDyVIg9r5qauYPK8NaSMpALX0
         ewVOOSffwbr0FoBrSyEs8aYNEVhRoVNS+PhV0JuXevvpWjk+X5RKOjJJse6zGeINYh0i
         ca+Og2MVokydMqjtO4NI4KYmR3q6JMQScoKto=
Received: by 10.231.5.67 with SMTP id 3mr2229618ibu.98.1316108743081;
        Thu, 15 Sep 2011 10:45:43 -0700 (PDT)
Received: from elie (99-120-124-35.lightspeed.cicril.sbcglobal.net. [99.120.124.35])
        by mx.google.com with ESMTPS id o5sm5603106ibu.12.2011.09.15.10.45.41
        (version=SSLv3 cipher=OTHER);
        Thu, 15 Sep 2011 10:45:41 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CA+gfSn9TU1mfAifL=1CDdq_cz7M7BgNLDuPAtzbMSf04WB-K3w@mail.gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181480>

Dmitry Ivankov wrote:

> A very quick view suggests that they could be reorganized, if it's okay.
> For example:
> - squash optifying REPORT_FILENO with it's addition.
> - drop changes to repo_tree.c that were later erased
> ...I bet there are more
>
> Does it make sense or we should better not rewrite the history?

All else being equal, it is better not to rewrite history, especially
when there are multiple series building on a commit (as is the case
for most commits in the

 git://repo.or.cz/git/jrn.git svn-fe

branch, just like Junio's "master" branch).

Cheers,
Jonathan
