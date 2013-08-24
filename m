From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 0/3] Fixes for tests run without perl
Date: Sat, 24 Aug 2013 12:58:38 -0700
Message-ID: <20130824195838.GA2960@elie.Belkin>
References: <1377316906-70338-1-git-send-email-draenog@pld-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Kacper Kornet <draenog@pld-linux.org>
X-From: git-owner@vger.kernel.org Sat Aug 24 21:58:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VDJz1-0002Lm-BI
	for gcvg-git-2@plane.gmane.org; Sat, 24 Aug 2013 21:58:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755706Ab3HXT6r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Aug 2013 15:58:47 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:46728 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755688Ab3HXT6q (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Aug 2013 15:58:46 -0400
Received: by mail-pa0-f49.google.com with SMTP id ld10so1925307pab.36
        for <git@vger.kernel.org>; Sat, 24 Aug 2013 12:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=byjeygAdUOx2PM6uzGD7bjADKSHIrTRa1qqZaRVkXYc=;
        b=hsVIBOv6NeWAHyAGXm9vfpYV7AZmHBHSEMLX+spL2X7n0xXJiFEzZdttt2ggNR0sIk
         +hKjNgHaGa6GzENWNzyQf6hrIz/OhBi1py/LVupOjzk6Jb+x4l68uOrRRem9wn+7/dDw
         c5WDc1EadgT40W3rXmmszehcf2hwIu5whY85j+tWk8Iee2hB8O1o5NHkyQEnDOo5qEik
         rdlq0FVkST06mVfdTL50XcpctUBSbbugpSHWxGPren6mfdH1VpyVEjokJ7AiXf4Z1DNQ
         fdUlgaK01x4E3x5KgIVy4iZaFhPARBHiGU6a/7xprodn/R8WTgBVk1ZlTnJ0U6iRTrMV
         nM1g==
X-Received: by 10.66.161.38 with SMTP id xp6mr5615652pab.145.1377374326193;
        Sat, 24 Aug 2013 12:58:46 -0700 (PDT)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPSA id hx1sm7802832pbb.35.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 24 Aug 2013 12:58:44 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1377316906-70338-1-git-send-email-draenog@pld-linux.org>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232888>

Hi,

Kacper Kornet wrote:

> This is a set of fixes for problems found while running
> test suite without perl installed.

I don't think git ever supported that.  The PERL prerequisite
was to check for systems that did not have (a suitable) perl
at runtime, but perl is still pretty heavily used in tests.

I assume you do have perl installed and that these fixes are
from testing the NO_PERL=YesPlease case, which is valuable.
Thanks for working on this.

Now on to the patches.

Jonathan
