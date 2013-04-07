From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/2] rev-parse: add --filename-prefix option
Date: Sun, 7 Apr 2013 15:14:58 -0700
Message-ID: <20130407221458.GE19857@elie.Belkin>
References: <cover.1365364193.git.john@keeping.me.uk>
 <ba2c7aa9eaa982306f1d5ad5ff2d26a6e2b8df85.1365364193.git.john@keeping.me.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jens Lehmann <Jens.Lehmann@web.de>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Mon Apr 08 08:46:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UP5pz-0000sy-Nm
	for gcvg-git-2@plane.gmane.org; Mon, 08 Apr 2013 08:45:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934427Ab3DGWPH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Apr 2013 18:15:07 -0400
Received: from mail-pd0-f173.google.com ([209.85.192.173]:40334 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934417Ab3DGWPG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Apr 2013 18:15:06 -0400
Received: by mail-pd0-f173.google.com with SMTP id v14so2686732pde.4
        for <git@vger.kernel.org>; Sun, 07 Apr 2013 15:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=M3HQoJyYwDN39YizUsT54V/0fbuNxC+GGBoIzaCOVAI=;
        b=a0nEJAncaYxwrIcYS8fJp5VSxNOMEZJmM6YCEDw/ouTIe+KEgnen75Nli4PdfB5uFP
         RfJg4vbBEBO4jpPj0C1+6pgVpF1cBtPV0G2UH04WI3DKAysz0QX87bDzY4mpcypbRaVW
         c1yEe0EH0YLNZ6Z9nH8yc/YBrE+66nbPFP50VzBwPGJX6QcYMsAiO8mI8nhHBcJmhFQY
         4B1n05JWlIeCI1lmwbWynv2x4khiMyoz+PqMUtcNrM+eo6i6lDvJRRnRWN2bxJeHw8PF
         u5zDngcmZzTevdFq1KqPIHENCkp7Um4ls6vtOsQyq/4HQUydmYWBiliZUJhV4uJSziaZ
         NK/Q==
X-Received: by 10.66.154.164 with SMTP id vp4mr31589891pab.89.1365372905409;
        Sun, 07 Apr 2013 15:15:05 -0700 (PDT)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPS id fc8sm33446848pad.21.2013.04.07.15.15.03
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 07 Apr 2013 15:15:04 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <ba2c7aa9eaa982306f1d5ad5ff2d26a6e2b8df85.1365364193.git.john@keeping.me.uk>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220377>

Hi,

John Keeping wrote:

> This adds a prefix string to any filename arguments encountered after it
> has been specified.

I assume this is a way of passing the prefix in?  In that case, I
think a good UI would be

	git rev-parse --prefix=Documentation/ <usual rev-parse args>

That sounds like a useful thing and would make the meaning very clear.

How does this interact with the following options?

 * --resolve-git-dir some/relative/path
 * master:./path

As for the patch itself, I haven't looked at it closely.  My only
immediate reaction is that I wish it touched Documentation/ and t/. :)

Hope that helps,
Jonathan
