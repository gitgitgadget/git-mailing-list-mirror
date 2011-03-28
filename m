From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v3] tests: fix overeager scrubbing of environment
 variables
Date: Mon, 28 Mar 2011 14:37:44 -0500
Message-ID: <20110328193744.GB13433@elie>
References: <4D8FAAAC.3050905@web.de>
 <20110327213756.GD25927@elie>
 <7v4o6n18oy.fsf@alter.siamese.dyndns.org>
 <4D90DE79.7000103@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Jeff King <peff@peff.net>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Mon Mar 28 21:38:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4IGI-0005GQ-F8
	for gcvg-git-2@lo.gmane.org; Mon, 28 Mar 2011 21:38:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755236Ab1C1Th5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Mar 2011 15:37:57 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:60025 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752566Ab1C1Th4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Mar 2011 15:37:56 -0400
Received: by gyd10 with SMTP id 10so1030996gyd.19
        for <git@vger.kernel.org>; Mon, 28 Mar 2011 12:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=TZHrCgFW+khaFjt8Gq9HgwhT4fYO/uKhPamqbU9yu8M=;
        b=StueYeRwLygDvWQxiSxJZqoEvKYfsn0TY0iOpYpf+wyv/JHDxILKMDjrMLgGfB7Zxh
         qJqKgpOoyykvu17Pi9lH/r1SNn5oraWo5ZRxSL4o1/Jwe7eIRRnJbT5veszMpRnE5Wu5
         sZbOeyoP8fVvBBakR3DvVx2jCmMZV0GS8qh9o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=EMONc2ASjILenH5b92TdO7XH+hAuz3thyWcKSiHkMcyl+JYb3QO98YzaYBqUJ3WG6g
         Qw4WdmuLafODvACajaruKdTXUj4brdZZWwLBdWTKOIBUgUdwixbtJnqyh40VO5hb0jvJ
         gDKrVu6dWIdqgdl56IFAGa4cJWBKK/j7MEOWo=
Received: by 10.236.109.145 with SMTP id s17mr2016522yhg.11.1301341069839;
        Mon, 28 Mar 2011 12:37:49 -0700 (PDT)
Received: from elie (adsl-68-255-101-206.dsl.chcgil.ameritech.net [68.255.101.206])
        by mx.google.com with ESMTPS id l50sm2090835yhn.98.2011.03.28.12.37.46
        (version=SSLv3 cipher=OTHER);
        Mon, 28 Mar 2011 12:37:47 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4D90DE79.7000103@web.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170178>

Jens Lehmann wrote:

> Acked-by: Jonathan Nieder <jrnieder@gmail.com>

Yes, still. :)

> So here is v3 of my patch which
> just makes these variables work again.

Thanks, all.  This looks good for an immediate fix, and I can think
separately about how to make downstreams projects suffer less if
changing the names of variables like GIT_SKIP_TESTS to follow a
GIT_TEST_ scheme.
