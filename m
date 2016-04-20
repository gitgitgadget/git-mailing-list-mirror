From: Shaun Jackman <sjackman@gmail.com>
Subject: Re: git rebase -i without altering the committer date
Date: Wed, 20 Apr 2016 14:15:03 -0700
Message-ID: <etPan.5717f1cf.1fc1bca8.12d1@sjackman03-imac.phage.bcgsc.ca>
References: <etPan.5717e605.4004d424.12d1@sjackman03-imac.phage.bcgsc.ca>
 <xmqqd1pkuidw.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 20 23:17:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aszUk-0000ce-Tc
	for gcvg-git-2@plane.gmane.org; Wed, 20 Apr 2016 23:17:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751179AbcDTVRG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Apr 2016 17:17:06 -0400
Received: from mail-pf0-f174.google.com ([209.85.192.174]:34866 "EHLO
	mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751078AbcDTVRF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Apr 2016 17:17:05 -0400
Received: by mail-pf0-f174.google.com with SMTP id n1so22136989pfn.2
        for <git@vger.kernel.org>; Wed, 20 Apr 2016 14:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding:content-disposition;
        bh=J+41fectIBSje12wAgxZNCv26pDXVwbBEfsBF+a0SYY=;
        b=kVHmGr+6BmLnbckMIpPYjlwZ3qqYd0JTMe9x1XCF/hxv+qpBOQ3gWTYyQZc2/2XJvg
         nQ5r2UDXmynjpWusNQNtxahy1sKj1O0KnYf6YbvAawtRJerY37JmMKzlBCAHcR3XYYUt
         9zCkzjajzlmQRfKKOBTCtaEUWHrWAwYiZhKzu7zyXJsb3dPyOvPpXxsCFPVKey9/p5be
         zpmgTr+oP8Aig0UVThD+PgnJlqzDZ7TZcQ9D2fatuw/FqQ1Jab/Zep8e2Wonn2dx3l9x
         /VjzKqtbilSA9+85FSRifd1W2GdQPU+gik1jktsrPd1x0872C35xk5msH4g89HIbW+Bm
         +tGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding
         :content-disposition;
        bh=J+41fectIBSje12wAgxZNCv26pDXVwbBEfsBF+a0SYY=;
        b=Px3dEpOWdOi8Y62biYyMXQ+9GPqMrZoPuJSO3e8uYeqJCmamJPn4fc4nPW09XatKSo
         Xs0K3+Regk7Ytc6fo5zWUPxJDGxfTJLi7ezDSBLaLGnDdTMIl2SbTbpqWscAvNpq0ciY
         1LWHxXJr2nVa6vuy6JWjhaaa2kwzM1hfwtXY6uUHTa7KpuDZX0Hh8n4CtUinAWeLpnJY
         /FEkg+VjnqTiT+lx8dAwodsMsnbffM/hKU89HrOgcfbOE6mHSBwS/rDcHlgG85hVh8Nc
         IkrUkcF8AATlGjR/FNg6LUMZJKXDl/LU27hzXD7wmsKyCILwy0qOxgdkeg3QRKhLKVXs
         35Gw==
X-Gm-Message-State: AOPr4FW1rsGdUiuTWQuCCvlBStt2BpIyF60E9xQNLQJDD6FSuMuZu0kGoEtR8yjFvIXKHg==
X-Received: by 10.98.1.69 with SMTP id 66mr15662701pfb.10.1461187023371;
        Wed, 20 Apr 2016 14:17:03 -0700 (PDT)
Received: from sjackman03-imac.phage.bcgsc.ca (outbound.bcgsc.ca. [134.87.4.251])
        by smtp.gmail.com with ESMTPSA id e87sm100413094pfb.76.2016.04.20.14.17.01
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 20 Apr 2016 14:17:01 -0700 (PDT)
In-Reply-To: <xmqqd1pkuidw.fsf@gitster.mtv.corp.google.com>
X-Mailer: Airmail (351)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292081>

On April 20, 2016 at 13:37:01, Junio C Hamano (gitster@pobox.com(mailto:gitster@pobox.com)) wrote:
> Shaun Jackman writes: 
> 
> > I'd like to insert a commit between two commits without changing 
> > the committer date or author date of that commit or the subsequent 
> > commits. I'd planned on using `git rebase -i` to insert the 
> > commit. I believe it retains the author date, but changes the 
> > committer date to the current time. I've seen the options 
> > `--committer-date-is-author-date` and `--ignore-date`, but I don't 
> > believe either of those options does what I want. If no such 
> > option currently exists to leave the committer and author date 
> > unchanged, is there any chance that this functionality could 
> > please be implemented? 
> 
> You can mark the commit as "edit", use "git commit --amend" when 
> "rebase -i" stops and gives control back to you, and say "rebase 
> --continue". That way, you can use your favourite trick to lie 
> about committer date (or identity or other aspects) when running 
> "git commit --amend" and its effect will be left in the resulting 
> history, I would think. 

Thanks for the suggestion, Junio. That would retain the committer date for the commit being inserted. I believe that the subsequent commits would have their committer date modified to the current time by the `git rebase --continue`.

Cheers,
Shaun
