From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 06/13] Simplify "How to make a commit"
Date: Sat, 24 Aug 2013 22:05:27 -0700
Message-ID: <20130825050527.GI2882@elie.Belkin>
References: <282216171.1090748.1377328932833.JavaMail.ngmail@webmail08.arcor-online.net>
 <1687455733.1090999.1377329376866.JavaMail.ngmail@webmail08.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com, wking@tremily.us
To: Thomas Ackermann <th.acker@arcor.de>
X-From: git-owner@vger.kernel.org Sun Aug 25 07:05:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VDSWI-0000gR-Be
	for gcvg-git-2@plane.gmane.org; Sun, 25 Aug 2013 07:05:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755743Ab3HYFFf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Aug 2013 01:05:35 -0400
Received: from mail-pd0-f181.google.com ([209.85.192.181]:50844 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753984Ab3HYFFe (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Aug 2013 01:05:34 -0400
Received: by mail-pd0-f181.google.com with SMTP id g10so2186422pdj.26
        for <git@vger.kernel.org>; Sat, 24 Aug 2013 22:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=CPvCYI969b6r/ie0ZSHzaO5YyeRzx0em+YUqSiq2NEc=;
        b=Ab9V2SGvQ1D5C7/tOm6t0+Yg1QaiVyXMFg2oooHxR6PftD/SVUg254rxWB6NJJZPA8
         FfSoZzurESoc+QdQYqGzUsQ3iDagseK9i1bsCX62aoTs2xucwYraCVjjEryjGz5OZIE5
         39TosMAGMF+CHC9JVZtPIjoPRGtYXELMcszn4XXBK/fyRxOSeRmOer1aB5fiZ2J2GjqG
         gx3vElFS63hskDy4+VVvk7H/P1Kw8ZHK9urOV6vul0NNR1PlFbaMsRGSfKy5e+2iEmT9
         mjcumTJV9A3tTW/9TQbDNberbIlZP4tu+Huqa8wm4a3QdARSoteQ2REOQdl9XTj1B6RP
         rt+Q==
X-Received: by 10.66.161.229 with SMTP id xv5mr7652829pab.87.1377407131952;
        Sat, 24 Aug 2013 22:05:31 -0700 (PDT)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPSA id uw6sm9751453pbc.8.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 24 Aug 2013 22:05:30 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1687455733.1090999.1377329376866.JavaMail.ngmail@webmail08.arcor-online.net>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232915>

Thomas Ackermann wrote:

> --- a/Documentation/user-manual.txt
> +++ b/Documentation/user-manual.txt
> @@ -1080,19 +1080,14 @@ produce no output at that point.
>  
>  Modifying the index is easy:
>  
> -To update the index with the new contents of a modified file, use
> +To add the contents of a new file to the index or update the index 
> +with the new contents of a modified file, use

That's a mouthful.  I'd say

	To update the index with the contents of a new or modified file, use

[...]
> -To add the contents of a new file to the index, use
> -
> --------------------------------------------------
> -$ git add path/to/file
> --------------------------------------------------
> -

\o/

> -To remove a file from the index and from the working tree,
> +To remove a file from the index and from the working tree, use
>  
>  -------------------------------------------------
>  $ git rm path/to/file

In git 2.0, (plain "rm" followed by) "git add" should work for this,
too.
