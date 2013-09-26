From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Problem switching branches in submodule
Date: Thu, 26 Sep 2013 11:48:30 -0700
Message-ID: <20130926184830.GG9464@google.com>
References: <BLU0-SMTP17403D5452DA1619FEFCCBAB8280@phx.gbl>
 <20130926180852.GF9464@google.com>
 <BLU0-SMTP36066CF18FF63C9BD84AC48B8280@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Manish Gill <mgill25@outlook.com>
X-From: git-owner@vger.kernel.org Thu Sep 26 20:48:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VPGcB-0000kF-7J
	for gcvg-git-2@plane.gmane.org; Thu, 26 Sep 2013 20:48:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752980Ab3IZSsf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Sep 2013 14:48:35 -0400
Received: from mail-pd0-f171.google.com ([209.85.192.171]:47169 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752440Ab3IZSse (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Sep 2013 14:48:34 -0400
Received: by mail-pd0-f171.google.com with SMTP id g10so1537889pdj.2
        for <git@vger.kernel.org>; Thu, 26 Sep 2013 11:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=f5BQjKKSq/3OwK1Skns6Kg41yXUcXs3Dn9v5svbCV0w=;
        b=Qq1rcGAX2wU38stUBlo9Ui+WrsI6Bj0P21cSL+Of4ojNuIP2e3ZLWv6qvRvcGwUhmi
         Qk6OLWX8oNvEca1/K25ooxCFcZNnKAw/Wn9rJL1gZGOe/9jSgQxOlFZTMkLxzGfudw31
         /ssE2CwclFJ9X+4tACjpGJvrypaNNprLi6hMrqoeDxsUve04ym6aPvt/eT6szPSkVWsN
         gqPDwM272u5gZTvfAFLnq7ebCV5YP71z/vpMXL+Jv9i+Rim+VJ8ezqk6B6Fu0oCOS5g6
         MTsaysSMzoa/DXAdTn1WgkhSQgI8QQT71J7I7mEHMFK5PSGLAxqBrbaDVp+k6x6MV5l6
         WhUw==
X-Received: by 10.68.20.69 with SMTP id l5mr2794635pbe.93.1380221314147;
        Thu, 26 Sep 2013 11:48:34 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id tx5sm3789426pbc.29.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 26 Sep 2013 11:48:33 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <BLU0-SMTP36066CF18FF63C9BD84AC48B8280@phx.gbl>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235426>

Manish Gill wrote:
> Jonathan Nieder wrote:

>> What is the exact command you use to get the above output?
>
> git checkout <branch_name>

Is <branch_name> a normal branch, a remote-tracking branch, or a
branch that doesn't exist yet?

[...]
> I should mention what *exactly* happened that led to this. I was trying
> to publish my branch on Launchpad (using git-remote-bzr). At some point,
> I had the genius idea to remote the extra stuff from the config file and
> just try with the bzr:: remote as origin, and instead of doing it via
> the console, I just replaced the config file.
>
> Annnnyway, I just restored my backed up config file for that submodule
> in the middle of writing this and seems like things seem to work now.

If you happen to have a copy of the old config file or remember what it
said, that could be helpful (especially if you can still reproduce the
problem in case we come up with a fix).

Did the config file have a [core] worktree setting or something similar?

Hmm,
Jonathan
