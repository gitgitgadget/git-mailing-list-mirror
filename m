From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 11/13] Remove obscure reference from "Examples"
Date: Sat, 24 Aug 2013 22:25:53 -0700
Message-ID: <20130825052553.GL2882@elie.Belkin>
References: <282216171.1090748.1377328932833.JavaMail.ngmail@webmail08.arcor-online.net>
 <883409466.1091151.1377329645768.JavaMail.ngmail@webmail08.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com, wking@tremily.us
To: Thomas Ackermann <th.acker@arcor.de>
X-From: git-owner@vger.kernel.org Sun Aug 25 07:26:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VDSpu-0007pI-Rr
	for gcvg-git-2@plane.gmane.org; Sun, 25 Aug 2013 07:26:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756057Ab3HYFZ6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Aug 2013 01:25:58 -0400
Received: from mail-pb0-f50.google.com ([209.85.160.50]:46750 "EHLO
	mail-pb0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755702Ab3HYFZ6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Aug 2013 01:25:58 -0400
Received: by mail-pb0-f50.google.com with SMTP id uo5so2176743pbc.23
        for <git@vger.kernel.org>; Sat, 24 Aug 2013 22:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=bM89ABCgPXfRqPn5y4GjfUqOmtWx8LKBdfTmhdXR0Ns=;
        b=KxZfEeikqXKMPRCM8kEDqlvuYTycKEbPNPo/0QLCB0aUA7eWpwLTGGYjYu/yeonENT
         Yxg4wRpzY0BedRjQdXKZUX6sdraGWcBTh0N6YJYkiD4O65W/2XimhjK3FDwJx/YkWOzF
         4SWsidyPVoiDbhcXpvTF7myAhEuWvQmuLWBxXu8lKC5ayMLSke//8M5lLB7kSDCYnUSt
         KYFoo6ZkMSVC5s0/cwfWexcp9haH2p1WXwXoXFFVzvfKsD9XtD7A9f9AIL75If1rqj5F
         a5j6ZLwel6c5iWu/EU07apCLng7HKbEJBVutA4m4GSxGdZPLkm/Bnf323SyY8qp9xK8r
         ZjPQ==
X-Received: by 10.68.111.197 with SMTP id ik5mr40684pbb.171.1377408357461;
        Sat, 24 Aug 2013 22:25:57 -0700 (PDT)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPSA id xe9sm9823481pbc.21.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 24 Aug 2013 22:25:56 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <883409466.1091151.1377329645768.JavaMail.ngmail@webmail08.arcor-online.net>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232920>

Thomas Ackermann wrote:

> --- a/Documentation/user-manual.txt
> +++ b/Documentation/user-manual.txt
> @@ -2131,8 +2131,6 @@ He uses two public branches:
>  
>   - A "test" tree into which patches are initially placed so that they
>     can get some exposure when integrated with other ongoing development.
> -   This tree is available to Andrew for pulling into -mm whenever he
> -   wants.

This drops useful information (namely, that Tony was publishing
history for two people to consume).  Perhaps it should spell out "the
bleeding-edge -mm tree"?

Jonathan
