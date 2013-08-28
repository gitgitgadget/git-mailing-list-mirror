From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC/PATCH v2 3/3] status: introduce status.displayCommentChar
 to disable display of #
Date: Wed, 28 Aug 2013 16:13:26 -0700
Message-ID: <20130828231326.GA4110@google.com>
References: <vpqhaeaasuf.fsf@anie.imag.fr>
 <1377694024-24173-1-git-send-email-Matthieu.Moy@imag.fr>
 <1377694024-24173-3-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, j.sixt@viscovery.net
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Thu Aug 29 01:13:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VEovf-00065E-N8
	for gcvg-git-2@plane.gmane.org; Thu, 29 Aug 2013 01:13:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755560Ab3H1XNb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Aug 2013 19:13:31 -0400
Received: from mail-pd0-f176.google.com ([209.85.192.176]:58201 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752998Ab3H1XNa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Aug 2013 19:13:30 -0400
Received: by mail-pd0-f176.google.com with SMTP id q10so6897544pdj.35
        for <git@vger.kernel.org>; Wed, 28 Aug 2013 16:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=xmllmcK0pNecEdXQQkY2b9Ya/mNu1JqDWDo9LQur8XE=;
        b=LyD5hTPqRaIyp7PqgCmNcn/84YNy/cHD2Zj+QrhbvmC0t6E57GWs+wVG+3dexFsNJQ
         AGrk23tGBl1NXVhd9709IT22BBR8H3nXSzarZKNQXVoR4XdFBQNCCEvJMtqBzcyEbxYn
         EolnnGLfioVM+1sQIiAOGbB3wJE5uw7JoAUyvWIZoyQ7OC16TOTcxT+I4QI2a2rXcwUU
         qTNI9a+pFe94j4sASMWGWyo6tBJhpHUGAmusnmMLK7bciMcr8vQ+vDvt+82C8/cPKmUb
         o8JatpTp4x0uAN7g1plOjXzv0Y7rDIusxUk8/dUC2PHROKWiBWxyTkIDU7uCGoM0lPm0
         zjlg==
X-Received: by 10.68.168.131 with SMTP id zw3mr7384pbb.199.1377731610573;
        Wed, 28 Aug 2013 16:13:30 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id nv6sm33711546pbc.6.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 28 Aug 2013 16:13:29 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1377694024-24173-3-git-send-email-Matthieu.Moy@imag.fr>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233228>

Matthieu Moy wrote:

> Historically, "git status" needed to prefix each output line with '#' so
> that the output could be added as comment to the commit message. This
> prefix comment has no real purpose when "git status" is ran from the
> command-line, and this may distract users from the real content.
>
> Allow the user to disable this prefix comment.

Why not do this unconditionally?

>                                                In the long run, if users
> like the non-prefix output, it may make sense to flip the default value
> to true.

Hmm, do you mean that the configuration is to give the change-averse
some time to get used to the new output?  I think it would make sense
to do it all at once (and even think that that would be less
confusing).

The rest of the idea and execution seem sane.

Thanks,
Jonathan
