From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH/RFC] git-svn: use path accessor for Git::SVN objects
Date: Tue, 18 Sep 2012 07:29:42 -0700
Message-ID: <20120918142941.GA2925@elie.Belkin>
References: <20120918000931.GB17939@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com, robbat2@gentoo.org,
	bwalton@artsci.utoronto.ca,
	"Michael G. Schwern" <schwern@pobox.com>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Tue Sep 18 16:30:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TDyoN-0005d6-N9
	for gcvg-git-2@plane.gmane.org; Tue, 18 Sep 2012 16:30:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933133Ab2IRO3w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2012 10:29:52 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:61023 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758108Ab2IRO3u (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Sep 2012 10:29:50 -0400
Received: by pbbrr13 with SMTP id rr13so91266pbb.19
        for <git@vger.kernel.org>; Tue, 18 Sep 2012 07:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=y2fqz708Duvt3sHAUc55vzdtsxyM5mW5kVWXkSLvkGo=;
        b=HO7TXg7WaquexJYKW0ItIgQW+mo3PdZ81fGaPG+3WgVHAJhIKj5OPpxyIbBUtfxrZV
         bMR8pieFBZi+mDBWNRJpfDjj+hI9VViMy35BepsKUyQNiaVo2YzV8/GwOTeCBdaaKHX+
         giyvZne+rf9wkI0+DwOLuAywqi6RbL6MzzrktwwdZEe1Nvl2m7FN1grzgMrGUrFf20Jr
         HSuxMG5SsdP1Q4QgNIcZJW72Jm59kIIiaCQr+VW3erzDTUJUaiBMysg1JsOggE9mq9zJ
         pKCUGv8RDUYDsZ6fJlD+b7JkjKSP8U8ZWCoQDADBZ33KQnn5I5cJfEMmkw9+voBni7DH
         zDxg==
Received: by 10.68.217.97 with SMTP id ox1mr1356303pbc.138.1347978590438;
        Tue, 18 Sep 2012 07:29:50 -0700 (PDT)
Received: from elie.Belkin (c-67-180-61-129.hsd1.ca.comcast.net. [67.180.61.129])
        by mx.google.com with ESMTPS id uj3sm61840pbc.39.2012.09.18.07.29.47
        (version=SSLv3 cipher=OTHER);
        Tue, 18 Sep 2012 07:29:48 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120918000931.GB17939@dcvr.yhbt.net>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205832>

Eric Wong wrote:

> The accessors should improve maintainability and enforce
> consistent access to Git::SVN objects.
>
> Signed-off-by: Eric Wong <normalperson@yhbt.net>
> ---
>   (RFC since I could've missed something)
[...]
>  git-svn.perl       | 2 +-
>  perl/Git/SVN/Ra.pm | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

I think that's all of them, so for what it's worth,
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
