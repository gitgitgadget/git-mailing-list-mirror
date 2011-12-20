From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [RFC/PATCH 0/2] Re: git-svn: multiple fetch lines
Date: Mon, 19 Dec 2011 19:22:36 -0600
Message-ID: <20111220012236.GB20979@elie.hsd1.il.comcast.net>
References: <CA+7g9Jxd3mhbra34f+MiJRt36Lb6gVHi1nOCP8Zo5y-G9jB3qA@mail.gmail.com>
 <20111217100521.GA12610@elie.hsd1.il.comcast.net>
 <CA+7g9JzatFYViMk302uU-X=YQGF2wEsmASkLPm0tDfQvpL_-vQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
To: Nathan Gray <n8gray@n8gray.org>
X-From: git-owner@vger.kernel.org Tue Dec 20 02:22:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RcoPr-00045I-IF
	for gcvg-git-2@lo.gmane.org; Tue, 20 Dec 2011 02:22:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753652Ab1LTBWr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Dec 2011 20:22:47 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:64466 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753205Ab1LTBWq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Dec 2011 20:22:46 -0500
Received: by yhr47 with SMTP id 47so4419610yhr.19
        for <git@vger.kernel.org>; Mon, 19 Dec 2011 17:22:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=ldA/CuJpC20xwHzOtKo+VIT3VBoaw9aiHLTE8U1KEJk=;
        b=fKaqCLhouLHZcXK2Cn9YyUK2sJJ+Z6CVk4gH0IFbDWIW7ZSCVrBDh2M6e0fRzGGpbM
         gtcrkSkNO/LW0KRbbo7zduygJUSVlG7iv1M+JBct8M5rUEHO0rvDn8cvHUqXi8F/k2uk
         X3RpoqzdGMWsJmY8IvfpvrWq8rD7MsrHdeX9o=
Received: by 10.236.187.97 with SMTP id x61mr31661487yhm.97.1324344165574;
        Mon, 19 Dec 2011 17:22:45 -0800 (PST)
Received: from elie.hsd1.il.comcast.net (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id s12sm199790and.15.2011.12.19.17.22.43
        (version=SSLv3 cipher=OTHER);
        Mon, 19 Dec 2011 17:22:44 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CA+7g9JzatFYViMk302uU-X=YQGF2wEsmASkLPm0tDfQvpL_-vQ@mail.gmail.com>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187489>

Nathan Gray wrote:

> How about something along these lines:

Sounds sensible.  Here's a patch series along those lines to get
things started.  Please feel free to try them (use "make -C
Documentation git-svn.1" to test), tweak to taste, and resend when
ready for Eric to pick up.

Thanks,

Jonathan Nieder (1):
  git-svn: clarify explanation of --destination argument

Nathan Gray (1):
  git-svn: multiple fetch/branches/tags keys are supported

 Documentation/git-svn.txt |   31 ++++++++++++++++++++++++++-----
 1 files changed, 26 insertions(+), 5 deletions(-)
