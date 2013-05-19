From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC/PATCH 2/2] doc: command line interface (cli) dot-repository
 dwimmery
Date: Sun, 19 May 2013 10:39:24 -0700
Message-ID: <20130519173924.GB3362@elie.Belkin>
References: <1368964449-2724-1-git-send-email-philipoakley@iee.org>
 <1368964449-2724-3-git-send-email-philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GitList <git@vger.kernel.org>
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Sun May 19 19:39:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ue7aL-0003LN-Dt
	for gcvg-git-2@plane.gmane.org; Sun, 19 May 2013 19:39:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751471Ab3ESRjt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 May 2013 13:39:49 -0400
Received: from mail-pd0-f174.google.com ([209.85.192.174]:38734 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750752Ab3ESRjs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 May 2013 13:39:48 -0400
Received: by mail-pd0-f174.google.com with SMTP id 14so355289pdj.19
        for <git@vger.kernel.org>; Sun, 19 May 2013 10:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=c7Wuf8Dc6JjPa35i3BrJ9EqhOorwZcFIhUK91mATsCE=;
        b=N+qav+vjLoxo1Qt3WK7UgpmxWTFNsCL6yW140oVh4LtU+dVE/ppeei6VUCefYOAIQt
         YKVCLkfueAxlpL2eaX1eknB++PDgJ1Rj4/F1APFzt2xWC61hDyAgJxcdzDRefwFvWtFG
         OtKsuGDx42hMAPts9y+QRvOtTy7MBhgrCX0AM1L4yQi8RLfsN/yXEJ1nBl3DxGAXI/tj
         TcX6DtEvAU5An/xIrszO0Bx0TZ5hf6EvkiTWi+h/v7uJ7cA9rDVktV3ZICEyZjFvM9+w
         HtML+wQZ++tB93wFvkqAhS1lSMTRDDj9cVCe2n7rPj6/bllFnc0Gzxc+w/zuN9W8ThEK
         lugQ==
X-Received: by 10.68.106.196 with SMTP id gw4mr56772287pbb.126.1368985188143;
        Sun, 19 May 2013 10:39:48 -0700 (PDT)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPSA id cc15sm21993374pac.1.2013.05.19.10.39.45
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 19 May 2013 10:39:46 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1368964449-2724-3-git-send-email-philipoakley@iee.org>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224901>

Hi,

Philip Oakley wrote:

> The Git cli will generally accept dot '.' (period) as equivalent
> to the current repository when appropriate. Tell the reader of this
> 'do what I mean' (dwim)mery action.
[...]
> --- a/Documentation/gitcli.txt
> +++ b/Documentation/gitcli.txt
> @@ -59,6 +59,10 @@ working tree.  After running `git add hello.c; rm hello.c`, you will _not_
>  see `hello.c` in your working tree with the former, but with the latter
>  you will.
>  
> +Just as, by convention, the filesystem '.' refers to the current directory,
> +using a '.' (period) as a repository name in Git (a dot-repository) refers
> +to your local repository.

Good idea, but I fear that no one would find it there.

Would it make sense to put this in Documentation/urls.txt (aka the
"GIT URLS" section of git-fetch(1) and git-clone(1)), where other URL
schemes are documented?

Thanks,
Jonathan
