From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Test renaming a branch to itself
Date: Sat, 26 Nov 2011 00:59:01 -0600
Message-ID: <20111126065901.GB20923@elie.hsd1.il.comcast.net>
References: <20111126023002.GA17652@elie.hsd1.il.comcast.net>
 <1322290364-16207-1-git-send-email-conrad.irwin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Soeren Sonnenburg <sonne@debian.org>,
	=?utf-8?B?4piCSm9zaCBDaGlhICjosKLku7vkuK0p?= <joshchia@gmail.com>
To: Conrad Irwin <conrad.irwin@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 26 07:59:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RUCEI-0005jr-Cx
	for gcvg-git-2@lo.gmane.org; Sat, 26 Nov 2011 07:59:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752080Ab1KZG7I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Nov 2011 01:59:08 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:64833 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751414Ab1KZG7F (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Nov 2011 01:59:05 -0500
Received: by iage36 with SMTP id e36so5632160iag.19
        for <git@vger.kernel.org>; Fri, 25 Nov 2011 22:59:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=ROQ5PJciyLuvykl/4Cb7Ryn5eE9vabIuR/AsZLx2t+s=;
        b=MKWrbiB2gMf7KwV6qDCA7eNlO6lU/kmyPBPOlNPAPrHzvGyrkCBGc+bJMXNJpG2wRx
         ATbMTjvW3xYZc1hPMP/XuKwpgMd1rkidOgxR1DHDvyFMR/dvx07OuXEbRb9teg0E/imy
         Mq5mxO2vs7bhgSmOZwQ5ZSRG9GnECaqEDcV6A=
Received: by 10.42.151.4 with SMTP id c4mr14982823icw.39.1322290744974;
        Fri, 25 Nov 2011 22:59:04 -0800 (PST)
Received: from elie.hsd1.il.comcast.net (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id bu33sm12344757ibb.11.2011.11.25.22.59.04
        (version=SSLv3 cipher=OTHER);
        Fri, 25 Nov 2011 22:59:04 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1322290364-16207-1-git-send-email-conrad.irwin@gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185947>

Conrad Irwin wrote:

> Test for a regression introduced in v1.7.7-rc2~1^2~2.

Thanks!  I take it that means you like the patch. :)

The tests look sane fwiw (and it looks like the tests you wrote before
cover the "branch -M" safety valve pretty well).
