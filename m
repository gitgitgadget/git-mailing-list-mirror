From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Fwd: vcs-svn and friends
Date: Fri, 23 Sep 2011 13:45:51 -0500
Message-ID: <20110923184550.GA12721@elie>
References: <CAFfmPPOBZ6cXG51mDHbj2VRDzjvH46Q7=_LvUWeMq0SGR40S1g@mail.gmail.com>
 <20110915100106.GB2328@elie>
 <CA+gfSn9KVN2iDCevd0s+TjYHNupDez8NiKZycP3pgBCkYiraFQ@mail.gmail.com>
 <CA+gfSn8UeqiLu3trecPzzqSLsUr3eNT0yVN=-991sL6oJHar2g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Michael Barr <davidbarr@google.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Dmitry Ivankov <divanorama@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 23 20:46:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R7AlB-0005yS-8X
	for gcvg-git-2@lo.gmane.org; Fri, 23 Sep 2011 20:46:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751400Ab1IWSqA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Sep 2011 14:46:00 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:43342 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750736Ab1IWSp7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Sep 2011 14:45:59 -0400
Received: by gwb15 with SMTP id 15so3935090gwb.19
        for <git@vger.kernel.org>; Fri, 23 Sep 2011 11:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=psG60Ieh4FDGjPam3d4Zp81wJyTGoqNkk5PDoq415YU=;
        b=g7Iom1Cmz3HUxxIGRawjaIhGbXAI5xjS1UCC+SahWnkLGpUViFrDFpXSZVn0Ylmnbe
         B0oNIAYBZdSebWihq9t9eTvp/WnqHCzkZxE1qOVS1rjqgzdWytUssVQnDDvhZZVfLHMx
         rIvOoLIQw18CRjhCEnbrOFAd+VZvaueeXrLK4=
Received: by 10.236.129.165 with SMTP id h25mr23847573yhi.38.1316803559121;
        Fri, 23 Sep 2011 11:45:59 -0700 (PDT)
Received: from elie (99-120-124-35.lightspeed.cicril.sbcglobal.net. [99.120.124.35])
        by mx.google.com with ESMTPS id d5sm14189902yhl.19.2011.09.23.11.45.56
        (version=SSLv3 cipher=OTHER);
        Fri, 23 Sep 2011 11:45:57 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CA+gfSn8UeqiLu3trecPzzqSLsUr3eNT0yVN=-991sL6oJHar2g@mail.gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181987>

Dmitry Ivankov wrote:
> On Thu, Sep 15, 2011 at 7:00 PM, Dmitry Ivankov <divanorama@gmail.com> wrote:

>> Haven't seen them in practice. It seemed possible with svn import:
>> if there were no branches at start, and then someone did svn mv .
>> trunk. But it turns out that my svn client doesn't allow such
>> move. So more like a least surprise purpose.
>
> I think now that this commit should go separately if at all.
> Especially considering my other activity on fast-import (and thus
> possible merge conflicts) that isn't strictly necessary for vcs-svn
> and friends.

Well, I think it's a good patch, and merge conflicts are really not a
big deal when one has a good patch, especially when it's clear how to
test that the tool still works after resolving.  It's just missing a
clear description...
