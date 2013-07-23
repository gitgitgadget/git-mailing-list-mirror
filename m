From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: getting git from kernel.org is failing
Date: Tue, 23 Jul 2013 13:40:05 -0700
Message-ID: <20130723204005.GF14690@google.com>
References: <51EEDC78.4000507@googlemail.com>
 <20130723200605.GE5129@paksenarrion.iveqy.com>
 <20130723202127.GA2051@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Fredrik Gustafsson <iveqy@iveqy.com>,
	Stefan Beller <stefanbeller@googlemail.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jul 23 22:40:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V1jNX-0000V0-Rl
	for gcvg-git-2@plane.gmane.org; Tue, 23 Jul 2013 22:40:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933851Ab3GWUkK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Jul 2013 16:40:10 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:43720 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933834Ab3GWUkJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jul 2013 16:40:09 -0400
Received: by mail-pa0-f43.google.com with SMTP id hz11so8780490pad.2
        for <git@vger.kernel.org>; Tue, 23 Jul 2013 13:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=1nCjLPxXIXpE4blaQaFp6ZQI68DiEvq0/aa5ojGZL0M=;
        b=NeqHT6nFOG3TKZ13AntVz2Pc/rUjvBFwohnj+H6VjJ8Ij8nmcWFtgrcvgaLaATGtfR
         DKay8JEu7tJ1f8J+hs7fuCvYZeiaVpwjdLxsAORmbqV3TvcyuTNpzdEdPcj9JJITXJMs
         1roKSrgU6zcvPsTgV3tYtuTG+Naa3LMRZNYFtRyhAIdIf5fkJrleXn1YclmXqZYF6hCp
         0jyLLINrjYA/wP4Ff/hulpSRbWEhtpcQxI/WhK1MfhfI7JnMQtSy4KNiEKrcuruTM0Kg
         Li2p2RBc6xLzfvIRP8GQtFdEm/y0TIk8/jhV9c2mR2Gy7WvDE2bnFvMWtjzMGXg7S7O9
         lbTg==
X-Received: by 10.68.170.227 with SMTP id ap3mr38237737pbc.194.1374612009132;
        Tue, 23 Jul 2013 13:40:09 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id dg3sm43549669pbc.24.2013.07.23.13.40.07
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 23 Jul 2013 13:40:08 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20130723202127.GA2051@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231059>

Jeff King wrote:

> then smart HTTP works fine. I wonder if there is a problem in the cgit
> setup on kernel.org (or if it was even intended that you could fetch
> from the cgit URL at all; the cgit page shows the clone URLs in
> /pub/scm/git).

I didn't think cgit URLs were meant to be clonable, but since
ls-remote works on them, it seems I thought wrong. :)  Odd.

Thanks,
Jonathan
