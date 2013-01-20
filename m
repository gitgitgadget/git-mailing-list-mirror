From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: git-cvsimport-3 and incremental imports
Date: Sun, 20 Jan 2013 15:34:22 -0800
Message-ID: <20130120233422.GB3474@elie.Belkin>
References: <20130120200922.GC7498@serenity.lan>
 <20130120232008.GA25001@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: John Keeping <john@keeping.me.uk>, git@vger.kernel.org
To: "Eric S. Raymond" <esr@thyrsus.com>
X-From: git-owner@vger.kernel.org Mon Jan 21 00:34:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tx4PY-000759-II
	for gcvg-git-2@plane.gmane.org; Mon, 21 Jan 2013 00:34:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752540Ab3ATXe1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jan 2013 18:34:27 -0500
Received: from mail-pa0-f47.google.com ([209.85.220.47]:50041 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752342Ab3ATXe1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jan 2013 18:34:27 -0500
Received: by mail-pa0-f47.google.com with SMTP id fa10so3029779pad.20
        for <git@vger.kernel.org>; Sun, 20 Jan 2013 15:34:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=25DlP/aObDVc1Ut1B2UfwdBLBHFUPHvnha4jZfbqBpA=;
        b=cOrW97d+EZMSxxNk8KlULK1ustY46qxrWoAKNxxGCtjP381fOR2XqSgEZmJ2h1R7xy
         QiIOXHsAb06uJSSfvBSfOWPT1V5eJCiqT6PSzfwNGogKGteKTv042+FQkO1HikyVTp2E
         kpV3QxdcFivSeuJGv/DG1R/3Ii8HlHnX3f6MP5XNybTYf3FdENovwWTRyYfxtmcIc+kT
         hr3MaGG8OA0NOweEnk/QcxePRJ4YM/104vV0x3u14eJQd6H3OZrdFqH5FrVGUiA0FX1X
         5sJrBtmkyqmsjw9syLuV/EEIZj3VR+tA7bCglNpgpx0SqyY6zcWBg+xJJXgZ7R7VwxXo
         HpPw==
X-Received: by 10.68.191.5 with SMTP id gu5mr25091261pbc.145.1358724866762;
        Sun, 20 Jan 2013 15:34:26 -0800 (PST)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPS id e6sm8010662paw.16.2013.01.20.15.34.24
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 20 Jan 2013 15:34:25 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20130120232008.GA25001@thyrsus.com>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214058>

Eric S. Raymond wrote:

> You get to integrate this.  I think the transition strategy Junio
> has chosen is seriously mistaken, leading to unnecessary grief for users
> who will be fooled into thinking it's OK to still use cvsps-2.x.

So our choices are:

 a. support current users, offend ESR, don't benefit from ESR
    improvements

 b. give up on current users, please ESR, benefit from ESR
    improvements

 c. some option yet undiscovered

In that case, (c) sounds like our best bet.  Do I understand
correctly?

Sigh,
Jonathan
