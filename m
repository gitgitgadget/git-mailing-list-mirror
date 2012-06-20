From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCHv3 06/11] Makefile: split GIT_USER_AGENT from GIT-CFLAGS
Date: Wed, 20 Jun 2012 17:21:03 -0500
Message-ID: <20120620222103.GJ6142@burratino>
References: <20120620182855.GA26948@sigill.intra.peff.net>
 <20120620183151.GF30995@sigill.intra.peff.net>
 <20120620212135.GE6142@burratino>
 <20120620221616.GC3302@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jun 21 00:21:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ShTH1-0001oE-0y
	for gcvg-git-2@plane.gmane.org; Thu, 21 Jun 2012 00:21:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758213Ab2FTWVJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jun 2012 18:21:09 -0400
Received: from mail-yw0-f51.google.com ([209.85.213.51]:52052 "EHLO
	mail-yw0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754839Ab2FTWVI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jun 2012 18:21:08 -0400
X-Greylist: delayed 4117 seconds by postgrey-1.27 at vger.kernel.org; Wed, 20 Jun 2012 18:21:08 EDT
Received: by yhnn12 with SMTP id n12so5598314yhn.10
        for <git@vger.kernel.org>; Wed, 20 Jun 2012 15:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=nV4RxkoLCd9noS35XEj+eOFgzBQFAF/wyHE3T+1u9aY=;
        b=F7egNnTRzaMOJW08KnCOks6T6k1kKBhQ+vx/fMOXDZ1KY6vAHgjEFNCZKU8eClbKvZ
         rnn212uQ+b7/wH5MsnSPWE8s7he2aWIRmofB7Na6WKzs9h0GBckNweziU3TJrRkw6o3H
         SQBnjbpVK7Fan8WNKYLHbm1lQnwv5WHgSYV++Prrf5Ai/vk0BeiW2X4KWNWnzV9hX/Ss
         blQMpC9q5VjEZr0Yy2LLoj1jcGLhI9ASqkUdscVfM3NiEGPJGo/FGG3AJBguaa3flZNO
         Etc+s59JWPbrxsz8OpVbTSwmyct5ORAnedUSTO+MqP1vmzJM0GZF//nGNnRGdXuhOLnn
         ZF/w==
Received: by 10.236.185.198 with SMTP id u46mr29998222yhm.33.1340230867894;
        Wed, 20 Jun 2012 15:21:07 -0700 (PDT)
Received: from burratino (cl-1372.chi-02.us.sixxs.net. [2001:4978:f:55b::2])
        by mx.google.com with ESMTPS id a64sm99655299yhe.11.2012.06.20.15.21.06
        (version=SSLv3 cipher=OTHER);
        Wed, 20 Jun 2012 15:21:07 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120620221616.GC3302@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200371>

Jeff King wrote:
>> Jeff King wrote:

>>> +	@if test x'$(GIT_USER_AGENT_SQ)' != x"`cat GIT-USER-AGENT 2>/dev/null`"; then \
>>> +		echo >&2 "    * new user-agent flag"; \
[...]
>           I am tempted to get rid of the informative message altogether.
> For CFLAGS, you might be confused why everything is being rebuilt, since
> the dependency chain is not straightforward. For this, it's kind of
> obvious.

Makes a lot of sense.
