From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: [PATCH 2/2] Add basic support for bookmarks (create/edit/delete/list)
Date: Wed, 25 Apr 2007 20:17:24 -0400
Message-ID: <462FEF94.7040409@gmail.com>
References: <200704252004.45112.andyparkins@gmail.com>	<Pine.LNX.4.64.0704252056210.1005@reaper.quantumfyre.co.uk>	<200704252142.33756.andyparkins@gmail.com>	<Pine.LNX.4.64.0704252332170.18446@beast.quantumfyre.co.uk>	<20070425225021.15383.87006.julian@quantumfyre.co.uk> <20070425225021.15383.4504.julian@quantumfyre.co.uk>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Andy Parkins <andyparkins@gmail.com>,
	Junio C Hamano <junkio@cox.net>
To: Julian Phillips <julian@quantumfyre.co.uk>
X-From: git-owner@vger.kernel.org Thu Apr 26 02:17:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hgrfw-0006HF-TO
	for gcvg-git@gmane.org; Thu, 26 Apr 2007 02:17:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750940AbXDZAR2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 Apr 2007 20:17:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752029AbXDZAR2
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Apr 2007 20:17:28 -0400
Received: from wx-out-0506.google.com ([66.249.82.238]:24939 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750940AbXDZAR1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Apr 2007 20:17:27 -0400
Received: by wx-out-0506.google.com with SMTP id h31so416143wxd
        for <git@vger.kernel.org>; Wed, 25 Apr 2007 17:17:26 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:disposition-notification-to:date:from:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=r49XFWlELXFujyw6d+BM7Nz/Om7kpQfK1vlG44DX//Kgq4fkfLuHkw0U6sCRtbXOzpYmaGg/1Iu9B65lkkhVkJ66gV9ev7YhvRxHS6+IrswEhQpMW46YXGAaFWm4TU2NSbMERHjDqd26fwiLYPcX6UKXv2aVrqmepKloZWtFo3o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:disposition-notification-to:date:from:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=Ulhn5TMTQRjtOBXVhAc8nt3+nUybVdN9NuxdhpcbDynu2FVKF3+AXVA4Hd/R/QpThANpBR4dBwOe0VBMI6bpdRi0U4K3H4rBykTTuBdi/cC8OdHlwWDTyZGd0xUb/s/ogjP0kZLnU7QgH4WcS/oEZmYhHyFTew3KuOfxZDAuKfI=
Received: by 10.70.130.8 with SMTP id c8mr2544438wxd.1177546646672;
        Wed, 25 Apr 2007 17:17:26 -0700 (PDT)
Received: from ?10.0.0.6? ( [66.177.19.99])
        by mx.google.com with ESMTP id h38sm19581521wxd.2007.04.25.17.17.25;
        Wed, 25 Apr 2007 17:17:26 -0700 (PDT)
User-Agent: Thunderbird 1.5.0.10 (X11/20060911)
In-Reply-To: <20070425225021.15383.4504.julian@quantumfyre.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45594>

Julian Phillips wrote:
> A bookmark is basically a private tag, you can create/modify/delete
> them by using the -b switch to git-tag.  You can also set
> tag.alwaysShowBookmarks so that git-tag -l will always show bookmarks
> in addition to tags.
> 
> (You have to refer to bookmarks as bm/foo rather than foo to keep the
> namespace separate from tags.)
> 

Can we please use a more descriptive namespace name than 'bm'?
