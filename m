From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 11/14] imap-send.c: simplify logic in lf_to_crlf()
Date: Sun, 13 Jan 2013 22:47:59 -0800
Message-ID: <20130114064759.GI3125@elie.Belkin>
References: <1358141566-26081-1-git-send-email-mhagger@alum.mit.edu>
 <1358141566-26081-12-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Jan 14 07:48:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TudqN-00047U-5y
	for gcvg-git-2@plane.gmane.org; Mon, 14 Jan 2013 07:48:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752738Ab3ANGsG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jan 2013 01:48:06 -0500
Received: from mail-da0-f51.google.com ([209.85.210.51]:62021 "EHLO
	mail-da0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751671Ab3ANGsF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jan 2013 01:48:05 -0500
Received: by mail-da0-f51.google.com with SMTP id i30so1672991dad.24
        for <git@vger.kernel.org>; Sun, 13 Jan 2013 22:48:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=1fUiRwfbKQvKNT0EABP3TCoaTzfbQ/M0wZojMUQAYDI=;
        b=RbFAdY6A79kzZUVbzmmptNtTdcd6XF4XrFZ87dCKsbRpO4G+e3HWljXWMlTtAd8kew
         d6bY6Ow/ok0NHFFs94xPsUzeSlN94flISgdoOBcBpaetYQKYOYrDbOWRWzdOLH7gIP96
         xm62fmypdhARvyDdA80xBSRJPgXcXbiEIzNRmFShAVQBzTWp8lXw4uH6b6CTUuOPdpNm
         SLnDdqEGXesrKsDKNA1ZF315OUaf+7aOTxoU8sn+1uFglOU1CTXXj0bN/ceU/RErdhIX
         1os5YZrYLZYrcnPoyWh5O3the6sWQ5kSjejCEkfrBGR6BXASlmqdtRxXR8ggAontxhC9
         qUZg==
X-Received: by 10.68.132.34 with SMTP id or2mr253917283pbb.133.1358146083982;
        Sun, 13 Jan 2013 22:48:03 -0800 (PST)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPS id ay6sm8190021pab.30.2013.01.13.22.48.01
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 13 Jan 2013 22:48:02 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1358141566-26081-12-git-send-email-mhagger@alum.mit.edu>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213454>

Michael Haggerty wrote:

> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---
>  imap-send.c | 31 ++++++++-----------------------
>  1 file changed, 8 insertions(+), 23 deletions(-)

I like the code reduction, but my nighttime brain doesn't have the
patience to understand the preimage or postimage, and the above
description doesn't give any hints.  Maybe a comment right above the
function definition describing its contract would help to prepare the
daunted reader (and to let the uninterested understand call sites
without reading the implementation).

Thanks,
Jonathan
