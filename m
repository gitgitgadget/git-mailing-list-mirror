From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] vcs-svn: Fix some compiler warnings
Date: Thu, 2 Feb 2012 12:53:05 -0600
Message-ID: <20120202185305.GB19520@burratino>
References: <4F28378F.6080108@ramsay1.demon.co.uk>
 <20120131192053.GC12443@burratino>
 <4F2AD4CF.7020303@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Barr <davidbarr@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>,
	Dmitry Ivankov <divanorama@gmail.com>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Thu Feb 02 19:53:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rt1ml-0003Pg-5U
	for gcvg-git-2@plane.gmane.org; Thu, 02 Feb 2012 19:53:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752821Ab2BBSx0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Feb 2012 13:53:26 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:60678 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752429Ab2BBSxZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Feb 2012 13:53:25 -0500
Received: by ggnh1 with SMTP id h1so1418755ggn.19
        for <git@vger.kernel.org>; Thu, 02 Feb 2012 10:53:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=9+s45OWK4o633FnBXMoMUMbXiS3fuut1PixyzHzjrJc=;
        b=YonBM27xtCb/7sFrklXCT+tc1PJk71gWHHLcs0Q5JT/JtNzcSVi/YugwNHQIxx7BHT
         og84QqphysAZOgD7yH9E70HETtvtFUBENy1fbZN4oFYuYmTiVPkGbbXA/FngqWeuTld2
         zERmwIaBQI5zuNaTo4lRU95f1NqGxPuumiMDo=
Received: by 10.50.196.228 with SMTP id ip4mr4604859igc.28.1328208804628;
        Thu, 02 Feb 2012 10:53:24 -0800 (PST)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id r18sm6348578ibh.4.2012.02.02.10.53.23
        (version=SSLv3 cipher=OTHER);
        Thu, 02 Feb 2012 10:53:23 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4F2AD4CF.7020303@ramsay1.demon.co.uk>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189670>

Ramsay Jones wrote:

> An static inline function was actually my first thought (although I had
> something more like Junio's suggestion [elsewhere in this thread] in mind),
> but I didn't want to place it in git-compat-util.h and could not find a
> suitable place in the vcs-svn directory.
>
> Hmm, I will send a v2 patch along these lines ...

Well, your v2 patch looks good to me.  The three-patch series I
sent[1] also look good to me.  I guess I could queue your v2 and put
the rest on top --- what say you?

[1] http://thread.gmane.org/gmane.comp.version-control.git/189618
http://repo.or.cz/w/git/jrn.git/log/refs/topics/rj/svn-fe-type-limits
