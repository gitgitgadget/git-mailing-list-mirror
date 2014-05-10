From: David Turner <dturner@twopensource.com>
Subject: Re: Watchman support for git
Date: Sat, 10 May 2014 11:38:29 -0700
Organization: Twitter
Message-ID: <1399747109.11843.137.camel@stross>
References: <1399072451-15561-1-git-send-email-dturner@twopensource.com>
	 <CACsJy8B6AVOHH7HhreqvusQN=UFZzj1mkjqekrOb62Lmq_8VQw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 10 20:38:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WjCAS-00057g-Gu
	for gcvg-git-2@plane.gmane.org; Sat, 10 May 2014 20:38:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752297AbaEJSie (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 May 2014 14:38:34 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:38709 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750912AbaEJSid (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 May 2014 14:38:33 -0400
Received: by mail-pa0-f45.google.com with SMTP id ey11so5747328pad.32
        for <git@vger.kernel.org>; Sat, 10 May 2014 11:38:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:content-transfer-encoding
         :mime-version;
        bh=L4ZAZmkbH/AH7EI7vxScs12iztjQjssYWHYjiTh+Qfk=;
        b=lKxHfrHoONXFwElnjJxH8cW6tgFMbLrzz21g1RnG+Nq8vtlkp/qavDMXP3lwHl5TSS
         2DYxMnWO7oN4jVIEJfyw6rFufuofzY6dpXbGrEpiSMmhCeAPoYCUYuNIGRoJ7NCrYXXn
         46G/uulAwRTp3DFBPFNwzc95q9UyWfktOKY0oMgy2UX98KI6V4oIVbSqtxzV+UZYodxy
         YUmtp7rDHQlo6i793wz2PII8k9rGw68F5e6lWPWwzSEoYkHsLNlXvGi3bB4gVvuAPb9c
         jJY6++cwI+VyAhcjpi+DzwB7+sKJqrIfhBZatkga2Y1fZ+jxclUGmcxwU+rRzptBTeZk
         8fgQ==
X-Gm-Message-State: ALoCoQkv7z3PN9MpPhSOTPZ0FSj8ERzf9JKGxNeH3XcuvYUcNDgE+nMyr7zQltSRqlhfAjylO4h2
X-Received: by 10.66.227.193 with SMTP id sc1mr35684329pac.102.1399747113358;
        Sat, 10 May 2014 11:38:33 -0700 (PDT)
Received: from [192.168.0.2] (65-102-19-155.ptld.qwest.net. [65.102.19.155])
        by mx.google.com with ESMTPSA id hk5sm14002748pbb.86.2014.05.10.11.38.30
        for <multiple recipients>
        (version=SSLv3 cipher=RC4-SHA bits=128/128);
        Sat, 10 May 2014 11:38:32 -0700 (PDT)
In-Reply-To: <CACsJy8B6AVOHH7HhreqvusQN=UFZzj1mkjqekrOb62Lmq_8VQw@mail.gmail.com>
X-Mailer: Evolution 3.2.3-0ubuntu6 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248663>

On Sat, 2014-05-10 at 12:26 +0700, Duy Nguyen wrote:
> On Sat, May 3, 2014 at 6:14 AM,  <dturner@twopensource.com> wrote:
> > The most sigificant patch uses Facebook's watchman daemon[1] to monitor
> > the repository work tree for changes.  This makes allows git status
> > to avoid traversing the entire work tree to find changes.
> 
> I got "warning: Watchman watch error: Got bad JSON from watchman
> get-sockname: '[' or '{' expected near end of file". Any ideas what I
> did wrong? I'm using watchman.git and libwatchman.git. check-0.9.11
> and jansson-2.4 were installed by system (gentoo).

What do you get from watchman get-sockname on the command-line?  Do the
watchman tests pass?

I don't know that I have tested with Jansson 2.4, but I've tried 2.2.1,
2.5, and 2.6.  

I also haven't tried on gentoo (I use Ubuntu).  But if you still have
problems, I can try installing gentoo in a vm and seeing if it's
something gentoo-specific.
