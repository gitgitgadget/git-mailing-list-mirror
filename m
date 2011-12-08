From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 4/6] t3200 (branch): fix '&&' chaining
Date: Thu, 8 Dec 2011 11:07:16 -0600
Message-ID: <20111208170716.GE2394@elie.hsd1.il.comcast.net>
References: <1323349817-15737-1-git-send-email-artagnon@gmail.com>
 <1323349817-15737-7-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 08 18:07:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RYhRN-0005Xm-SQ
	for gcvg-git-2@lo.gmane.org; Thu, 08 Dec 2011 18:07:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752232Ab1LHRHV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Dec 2011 12:07:21 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:48421 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752049Ab1LHRHT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Dec 2011 12:07:19 -0500
Received: by yenm11 with SMTP id m11so1277572yen.19
        for <git@vger.kernel.org>; Thu, 08 Dec 2011 09:07:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=UrV8Q2fHnf0c6F7zyH722tsrjQTHBuMs9xrAFHIZnHI=;
        b=Wl0GPtqxjjKWrOA8bBKueqYz/B3sJoy6Y0tg4MYfrTtYymd8+88wTypeZLd0LBLDSN
         3v+Vg9hcS8/bxWrYpA96NJb8UWuXMNsfjWO0ezP7FhySv/I1t1bZeZYwlc2m5uJ5j6Od
         Z3HUtlmweh0oZTgLyJZBgifLNBblzM1Okur2I=
Received: by 10.236.77.37 with SMTP id c25mr6007990yhe.85.1323364039366;
        Thu, 08 Dec 2011 09:07:19 -0800 (PST)
Received: from elie.hsd1.il.comcast.net (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id q5sm10002601yhm.7.2011.12.08.09.07.18
        (version=SSLv3 cipher=OTHER);
        Thu, 08 Dec 2011 09:07:18 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1323349817-15737-7-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186575>

Ramkumar Ramachandra wrote:

> Breaks in a test assertion's && chain can potentially hide failures
> from earlier commands in the chain.  Fix these breaks.
>
> Additionally, note that 'git branch --help' will fail when git

This is not "Additionally, while we're here" but rather "In order to
do so".

> manpages aren't already installed: guard the line with a
> 'test_might_fail'.
>
> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
> ---
>  t/t3200-branch.sh |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)

For what it's worth,
Acked-by: Jonathan Nieder <jrnieder@gmail.com>
