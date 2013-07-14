From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] gitweb: Ensure OPML text fits inside its box.
Date: Sun, 14 Jul 2013 16:49:15 -0700
Message-ID: <20130714234915.GB19057@google.com>
References: <E1Uwb6x-0002XI-Ah@hermes-2.csi.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>
To: Tony Finch <dot@dotat.at>
X-From: git-owner@vger.kernel.org Mon Jul 15 01:49:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UyW2r-0005wR-KE
	for gcvg-git-2@plane.gmane.org; Mon, 15 Jul 2013 01:49:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753470Ab3GNXtU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Jul 2013 19:49:20 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:37562 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753444Ab3GNXtT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Jul 2013 19:49:19 -0400
Received: by mail-pa0-f46.google.com with SMTP id fa11so10698266pad.33
        for <git@vger.kernel.org>; Sun, 14 Jul 2013 16:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=rAJ3rQM8aM7V4KlZ1dSSJZ6C5QurB5wI19qlxJ7eN3U=;
        b=to9hqphV/bYfKDqkCimTWu4GhottnDVwh/fLweg58GKmjsq66PcykGw3HTHuH+qf64
         gzAZSkqWDghFhQXCv6yzl2mUUveP9UJ0EmMOImnnFMRzhxH25c0wK6wmC0ZFP8hb/HKO
         Bo6SjUUndbGDsKPv3zCuMnvMor2NPQ99jmE4wj/6uG95SkIm1r5LJeBAU5qL8zv54Dy/
         q6SwaIK2M0d4dsANu08dJcnhs4PRqAU6niIVwoKcAzLTy6jEFl8GxAwlBn1v9zz2on54
         Y/Hfc9za7idpeeKG1nMfu91S8GzGOn7yekDvNtpM41Omy0NXWTP1dnKxtZIer4BMTYxd
         Tvig==
X-Received: by 10.68.238.9 with SMTP id vg9mr51222931pbc.66.1373845759332;
        Sun, 14 Jul 2013 16:49:19 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id ai6sm60913593pad.15.2013.07.14.16.49.17
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 14 Jul 2013 16:49:18 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <E1Uwb6x-0002XI-Ah@hermes-2.csi.cam.ac.uk>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230402>

Tony Finch wrote:

> The rss_logo CSS style has a fixed width which is too narrow for
> the string "OPML". Replace the fixed width with horizontal padding
> so the text fits with nice margins.

Sounds sensible.  Can we have your sign-off?  (Likewise for the next
patch.)

Thanks,
Jonathan
