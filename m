From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 0/2] GIT, Git, git
Date: Sat, 19 Jan 2013 14:31:05 -0800
Message-ID: <20130119223105.GG4009@elie.Belkin>
References: <732444561.1327663.1358589465467.JavaMail.ngmail@webmail24.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Thomas Ackermann <th.acker@arcor.de>
X-From: git-owner@vger.kernel.org Sat Jan 19 23:31:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Twgwm-0002CH-UX
	for gcvg-git-2@plane.gmane.org; Sat, 19 Jan 2013 23:31:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752001Ab3ASWbM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Jan 2013 17:31:12 -0500
Received: from mail-pa0-f44.google.com ([209.85.220.44]:53481 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751932Ab3ASWbL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Jan 2013 17:31:11 -0500
Received: by mail-pa0-f44.google.com with SMTP id hz11so2728220pad.31
        for <git@vger.kernel.org>; Sat, 19 Jan 2013 14:31:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=ScbWhi+aTSB9uEp27X5GmYtG8KoXg/o1eejQ/BXtlD4=;
        b=WUk54etjAlmVzuT71TpwCxbXsNckm+eOvX7GhT7ka0F1u5IIY3DB1DcYW6rx6sQFwo
         TAsmalcofh0gtrRVn8ZBBl3PLuHmT456Y0SiJl3ZrNjV2KnBN5LrtcKE/V0UESkOiWPl
         hBy0f/eto1MPTHjNppHuXc9SN3D1+m9TLef4PlTXJIhTvf8aUG5tR68inU4d0FZ4pRlu
         XaXkmS07vnevc7avge4aXcq4ck1mp7woKQhRaQMVAQH33oKbTivMOxKEfgfbfkb+b1Mk
         zR1lmyzeu0qN3FDmbt2NHb22nGXYzDZStBU/h/cv4RUAFWxQRynELPZmGeCtDGG9XeOg
         UIaA==
X-Received: by 10.68.132.10 with SMTP id oq10mr17966054pbb.18.1358634670947;
        Sat, 19 Jan 2013 14:31:10 -0800 (PST)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPS id a9sm6097981pav.24.2013.01.19.14.31.08
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 19 Jan 2013 14:31:09 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <732444561.1327663.1358589465467.JavaMail.ngmail@webmail24.arcor-online.net>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213995>

Hi Thomas,

Thomas Ackermann wrote:

> Git changed its 'official' system name from 'GIT' to 'Git' in v1.6.5.3
> (as can be seen in the corresponding release note where 'GIT' was 
> changed to 'Git' in the header line).
>
> Alas the documention uses 'GIT', 'Git' or even 'git' to refer to the
> Git system. So change every occurrence of 'GIT" and 'git' to 'Git'
> whenever Git as a system is referred to (but don't do this change
> in the release notes because they constitute a history orthogonal
> to the history versioned by Git).

I don't have any opinion about the subject at hand, except that making
a consistent convention and documenting it somewhere to avoid future
churn sounds like a fine idea.

Instead, I'm writing for a procedural nitpick ;-): please move the
above rationale to one of the commit messages, so it gets recorded
somewhere that future readers can easily find it.

Hope that helps,
Jonathan
