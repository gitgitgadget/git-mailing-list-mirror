From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/5] git-diff.txt: reorder the <commit> <commit> form
Date: Wed, 24 Apr 2013 09:41:42 -0700
Message-ID: <20130424164142.GC4119@elie.Belkin>
References: <1366821216-20868-1-git-send-email-artagnon@gmail.com>
 <1366821216-20868-2-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 24 18:41:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UV2lW-0003si-Tg
	for gcvg-git-2@plane.gmane.org; Wed, 24 Apr 2013 18:41:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757236Ab3DXQlu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Apr 2013 12:41:50 -0400
Received: from mail-pb0-f43.google.com ([209.85.160.43]:51661 "EHLO
	mail-pb0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756199Ab3DXQlt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Apr 2013 12:41:49 -0400
Received: by mail-pb0-f43.google.com with SMTP id md4so509137pbc.2
        for <git@vger.kernel.org>; Wed, 24 Apr 2013 09:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=aPZbPLk2BK99KUpqFIgJCHn0z0izwfgPhgtf1+yHf88=;
        b=yvxasixqp1Su6cfvp7Jh+M657tKFyhHWSxZq7Gdql5chzTclQrgZJXbzUWd1jyBWj6
         OBiT4fWSRD6pgOD9RcYr5anmpg2ozRFk1NDHc/9+ovbAuLYWgFe0/o5ZGOfLLR/JJsPu
         CM/UjgW3tx7KziddeEMKDiviSRY15wKPB6rMUVqBrVupNWdtCzEhwZXhkQK0GSve8Uup
         eBxr2Q7n+sdZP+kbj9CZlGuuIqR7UqqCGMZUCYe1rqHA3iTPzgagI3dmLLcCPhwOKMDf
         eZG9R6sBUoeMiSxbUf1DaaSVDoxwhZRf9ourmCTHwkvr0dLPSx5cyHP10XcXZQ4fWnsT
         2D0Q==
X-Received: by 10.66.163.101 with SMTP id yh5mr20207583pab.22.1366821709047;
        Wed, 24 Apr 2013 09:41:49 -0700 (PDT)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPSA id ef4sm3641269pbd.38.2013.04.24.09.41.46
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 24 Apr 2013 09:41:47 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1366821216-20868-2-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222267>

Ramkumar Ramachandra wrote:

> In DESCRIPTION, the '<commit>..<commit>' form refers to "the previous
> form", namely the '<commit> <commit>' form.  However, bd52900

Good catch.

[...]
> --- a/Documentation/git-diff.txt
> +++ b/Documentation/git-diff.txt
> @@ -11,8 +11,8 @@ SYNOPSIS
>  [verse]
>  'git diff' [options] [<commit>] [--] [<path>...]
>  'git diff' [options] --cached [<commit>] [--] [<path>...]
> -'git diff' [options] <commit> <commit> [--] [<path>...]
>  'git diff' [options] <blob> <blob>
> +'git diff' [options] <commit> <commit> [--] [<path>...]
>  'git diff' [options] [--no-index] [--] <path> <path>

For the sake of exposition I think it makes more sense to put
<commit> <commit> *before* <blob> <blob>, since the former is used
more often.

Thanks,
Jonathan
