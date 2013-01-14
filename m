From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: git list files
Date: Sun, 13 Jan 2013 23:08:32 -0800
Message-ID: <20130114070832.GA4820@elie.Belkin>
References: <CAGL0X-rfrwtbtdN7O0=iMhVRYv1m0_czW8zmgT5QA3irkaeu5Q@mail.gmail.com>
 <20130113175602.GD5973@elie.Belkin>
 <20130113201027.GA4436@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?0KHRgtC+0LnRh9C+INCh0LvQtdC/0YbQvtCy?= 
	<stoycho.sleptsov@gmail.com>, git@vger.kernel.org,
	Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jan 14 08:09:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TueAJ-0004Ft-Do
	for gcvg-git-2@plane.gmane.org; Mon, 14 Jan 2013 08:09:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753051Ab3ANHIn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jan 2013 02:08:43 -0500
Received: from mail-pb0-f54.google.com ([209.85.160.54]:35599 "EHLO
	mail-pb0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751871Ab3ANHIm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jan 2013 02:08:42 -0500
Received: by mail-pb0-f54.google.com with SMTP id wz12so1992412pbc.13
        for <git@vger.kernel.org>; Sun, 13 Jan 2013 23:08:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=5I6ro4a9XgqwnIZCpcjN2BdvXu7h5BBFJ3VBU4oqz30=;
        b=PpC57/54F6UT1pihQtxruZVl/FyYBt656npb8p6jmJacU+KgJ3NK4qazJiJRImlSFd
         yYJF4iJsZ9jEFrNeHX6p/UjcpbxMR/AUrkopa6k0zJ8gPbIKEloeoSkOtDo97gdJqLQa
         2bSgFAFDZ0Ap85naafRaXK/u9zlBug8I2HGk+4c8GyALsGDqzR0Lmo8dhfv1Fx6iywWw
         joK9yiKxMpvDoZbpUNYdDHoCfcdN+NKUnZZ6/hz9QmogmsbEB4OAU+XvVoN/n/PijySp
         gSTxx/r97xaJ9CKxUQyRZRCQSmfxCUTzuDba5g2+bm9nHdowMQLqUvjVZh7E9GEQ2Voy
         c1PA==
X-Received: by 10.68.135.98 with SMTP id pr2mr86616739pbb.101.1358147322153;
        Sun, 13 Jan 2013 23:08:42 -0800 (PST)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPS id y9sm8240177paw.1.2013.01.13.23.08.39
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 13 Jan 2013 23:08:41 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20130113201027.GA4436@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213457>

Jeff King wrote:

> As far as I recall, that script works. However, I have a pure-C
> blame-tree implementation that is much faster, which may also be of
> interest. I need to clean up and put a few finishing touches on it to
> send it to the list, but it has been in production at GitHub for a few
> months. You can find it here:
>
>   git://github.com/peff/git jk/blame-tree

Oh, neat.  Would that make sense as an item in
<https://git.wiki.kernel.org/index.php/Interfaces,_frontends,_and_tools>?
