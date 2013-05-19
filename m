From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC/PATCH 1/2] config doc: add dot-repository note
Date: Sun, 19 May 2013 10:43:07 -0700
Message-ID: <20130519174307.GC3362@elie.Belkin>
References: <1368964449-2724-1-git-send-email-philipoakley@iee.org>
 <1368964449-2724-2-git-send-email-philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GitList <git@vger.kernel.org>
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Sun May 19 19:43:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ue7dc-0005p6-VR
	for gcvg-git-2@plane.gmane.org; Sun, 19 May 2013 19:43:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751766Ab3ESRnM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 May 2013 13:43:12 -0400
Received: from mail-pd0-f175.google.com ([209.85.192.175]:34707 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750752Ab3ESRnL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 May 2013 13:43:11 -0400
Received: by mail-pd0-f175.google.com with SMTP id y14so4747074pdi.34
        for <git@vger.kernel.org>; Sun, 19 May 2013 10:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=IcayN7OTbEVltrpzg0j7WMmoOtD9EUTZeeIJ7/N+zVY=;
        b=E6EQiz/Vk0fJ+h7VLRVvfAr0i9ViZAXl21E6FZc3PNwnCrHjUakulysOONi5589dff
         peQxViQaUWFBCoGJI/5MhWwFSr2nTVjjB1Tw4ZEWp0eLmB/d5t8uZIZ+N/mlLwkr3m2n
         j++2fgdc+eqKmo0Mx7op2Wgu5rhIfupxRzhUK+rjcQGWw1F/pNnDVt/HBfVhAE4cWrj3
         eNKe7hDasrT2WEJdR0Eafs+f3h5avh+qtmFhpvgiEQL4fxlwok1JEudwsIZdA4C2sUZV
         AtyaLP13K0OGyATqvciqKeQk/1kBWcqbxsprnN98RcDK7u8PIfrXwlGsrFik7fHS4V0Y
         lGdQ==
X-Received: by 10.66.67.11 with SMTP id j11mr26818756pat.220.1368985391407;
        Sun, 19 May 2013 10:43:11 -0700 (PDT)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPSA id cc15sm22003187pac.1.2013.05.19.10.43.09
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 19 May 2013 10:43:10 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1368964449-2724-2-git-send-email-philipoakley@iee.org>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224902>

Philip Oakley wrote:

> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -734,6 +734,8 @@ branch.<name>.remote::
>  	overridden by `branch.<name>.pushremote`.  If no remote is
>  	configured, or if you are not on any branch, it defaults to
>  	`origin` for fetching and `remote.pushdefault` for pushing.
> +	Additionally, a `.` (period) means the current local repository
> +	(a dot-repository), see `branch.<name>.merge`'s final note below.

Does this accept an arbitrary git URL, or only remote names?

The current documentation makes it sound like the latter, which makes
this exception seem very weird.  Is it actually the former?

I think a cross-reference to the "git urls" or "git remotes"
documentation would be a better way to go, instead of having to repeat
the rules of URL syntax everywhere they are used.

Thanks,
Jonathan
