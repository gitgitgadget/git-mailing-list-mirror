From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Move Git::SVN into its own .pm file
Date: Wed, 25 Jul 2012 16:15:11 -0500
Message-ID: <20120725211511.GA5627@burratino>
References: <1343196066-81319-1-git-send-email-schwern@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com, robbat2@gentoo.org,
	bwalton@artsci.utoronto.ca, normalperson@yhbt.net
To: "Michael G. Schwern" <schwern@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 25 23:15:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Su8vb-0006du-Tj
	for gcvg-git-2@plane.gmane.org; Wed, 25 Jul 2012 23:15:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752716Ab2GYVP1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jul 2012 17:15:27 -0400
Received: from mail-gg0-f174.google.com ([209.85.161.174]:58860 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751774Ab2GYVP0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jul 2012 17:15:26 -0400
Received: by gglu4 with SMTP id u4so1233906ggl.19
        for <git@vger.kernel.org>; Wed, 25 Jul 2012 14:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=bX9k0Zol4DQuttEoY2BA9izG1GRS/mwJfMhkumDR3gc=;
        b=gxZ4tqX3WsS+eRvZxNpFov+vTQlr8kag0AyEPR5+z5+z8ujx9SXN/McnIjBrmHGVsM
         Us/9SV08Ezvzlsagsjg84zAydY3sWy3pKJZc7+BrBTiJ9fmUziDml6atuE7kRTadReGY
         tTFnplrRYmcFHo1kvPXEM4qlE61yCetdpCAxytVTIzaf/2HhL6F0CNJHvxwR6Eh08tu1
         FDoC9UyzCcepyovuxFaNxvKOvUpvuAmhIUn3LCiyRR0Kbw4ktcV/UXEYVmJjOLzh/AHS
         9pW80aOkjJj9eDWyC2Zo7FyiUBWKS7//lQ4QD9XAB+dFaohf4m+xM988FLjE8fMOgZoF
         f2bA==
Received: by 10.236.176.234 with SMTP id b70mr18654121yhm.55.1343250926042;
        Wed, 25 Jul 2012 14:15:26 -0700 (PDT)
Received: from burratino (cl-1372.chi-02.us.sixxs.net. [2001:4978:f:55b::2])
        by mx.google.com with ESMTPS id y10sm37543036yhd.6.2012.07.25.14.15.23
        (version=SSLv3 cipher=OTHER);
        Wed, 25 Jul 2012 14:15:24 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1343196066-81319-1-git-send-email-schwern@pobox.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202199>

Hi,

Michael G. Schwern wrote:

> This is a refactoring to move Git::SVN out of git-svn and into its own .pm file.
> This will make it easier to work with and test.  This is just the extraction
> with minimal work to keep all tests passing.

Patch 3 doesn't seem to have hit the list archive.  I am not
subscribed and was not cc-ed for some reason, so I do not have it.
I'd appreciate a copy if that's not too inconvenient.

Thanks,
Jonathan
