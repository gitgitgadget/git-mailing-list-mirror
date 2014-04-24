From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Harmful LESS flags
Date: Wed, 23 Apr 2014 17:11:26 -0700
Message-ID: <20140424001126.GG15516@google.com>
References: <4dc69237123e8962b2b2b901692ea78e.id@mailtor>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Mark Nudelman <markn@greenwoodsoftware.com>
To: d9ba@mailtor.net
X-From: git-owner@vger.kernel.org Thu Apr 24 02:11:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wd7GH-00054Q-Ua
	for gcvg-git-2@plane.gmane.org; Thu, 24 Apr 2014 02:11:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751586AbaDXALa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Apr 2014 20:11:30 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:52695 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751272AbaDXAL3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Apr 2014 20:11:29 -0400
Received: by mail-pa0-f47.google.com with SMTP id lj1so1290186pab.34
        for <git@vger.kernel.org>; Wed, 23 Apr 2014 17:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=ns3su9mjD19sRn6prB3jzEeUfOzxzRZMO6p5JKlB6DY=;
        b=ydMkIJAwjj2QQyyxLfRU73BvvsJ6/CcoCpUMkgGsXJIsLAmHeOSQ6EImn1lg7lSSDL
         XlZg9d5vEkYPVoCRtx3hbsTyCURJAzVupdFSYq+loIzcrJyKakDBuLuDQqNLsMQS2lTL
         Q3ryClvZKraxUPCE0/0alAOXii0TubBoTTHHb1jbLKr9loavJdUdIUrycNhTlY8Zw1Xq
         vxV/U7Ft+VaQF0fppk55MJHLo1m7OpRO1+2+lGwUeavfQKzbRWOZtXSGuMD1Qfvj5Htx
         GZXfgyvJh0L+FjhOD6+FTF7ZxPH1Q3LuXkNNgyT8ntJ9y2oHQPs6QL44/L+LyCpD1fK1
         Kvxg==
X-Received: by 10.66.147.130 with SMTP id tk2mr1231984pab.125.1398298289096;
        Wed, 23 Apr 2014 17:11:29 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id iv2sm5130874pbc.19.2014.04.23.17.11.28
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 23 Apr 2014 17:11:28 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4dc69237123e8962b2b2b901692ea78e.id@mailtor>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246911>

(cc-ing Mark Nudelman, less maintainer)
Hi,

d9ba@mailtor.net wrote:

> Consider this diff, printed by `git diff`
>
> 	 #!/usr/bin/env python
> 	-print('foo')
> 	+print('bar')
>
> Looks ok to merge and run.
>
> But, after disabling the pager:

Unfortunately there are other kinds of subtle bugs that can be hard to
see in a terminal, too.

[...]
> It would be nice if we could change the flags to either
>
>  a) avoid cutting off
>  b) indicate something has been cut off (<- I prefer this)

That sounds like a nice feature request for 'less': a marker on the
right margin when --chop-long-lines is in use and a line has been
chopped.  I don't see it at
http://www.greenwoodsoftware.com/less/bugs.html#enhance so maybe no
one else has thought of it yet.

Mark, what do you think?

Thanks,
Jonathan
