From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/3] Documentation/Makefile: move infodir to be with
 other '*dir's
Date: Tue, 12 Feb 2013 13:01:38 -0800
Message-ID: <20130212210138.GE12240@google.com>
References: <cover.1360700102.git.john@keeping.me.uk>
 <dcc4f597f26531b79bd9f097c73f6f186b73c81d.1360700102.git.john@keeping.me.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Steffen Prohaska <prohaska@zib.de>,
	Jakub Narebski <jnareb@gmail.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Tue Feb 12 22:02:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U5MzS-0000D2-JT
	for gcvg-git-2@plane.gmane.org; Tue, 12 Feb 2013 22:02:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759468Ab3BLVBq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Feb 2013 16:01:46 -0500
Received: from mail-ie0-f179.google.com ([209.85.223.179]:44799 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754630Ab3BLVBn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Feb 2013 16:01:43 -0500
Received: by mail-ie0-f179.google.com with SMTP id k11so738966iea.10
        for <git@vger.kernel.org>; Tue, 12 Feb 2013 13:01:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=pZXgH1JtPywsGSCDYUAUSzQ9Gmvos9WDIqBcndUTsi8=;
        b=hc0TVgmKGlUbBn19VUq74dtcRn1XLfDrdYCMLmeveH5/tIdlBH6ChO308/AL5OXoU2
         I3+e/1nOZyz0PzdVGJR0XKnPUho3rxQb37OgnXQEIaygwGA4NLg/vygPeYReZ8L5a3fx
         yhkbCCupljAbPcc3/+bY8TXOU8Jw+76yNpQlzn1RrimuS9s6lwZREVPMALdjp0KEZvEM
         D8TQK9h1ddBEq784l0SFxqHuwLmOdEKLpZtt4joifzOfjF8jzqTGrJUrLwjZLH4em5wv
         Kcx6hN9AOAjDvLXlfA5xRfJVZKpprOnWc6U17fX2trRSqd/PEwdeazlUDIAy+sp9rqf2
         9zHA==
X-Received: by 10.50.222.232 with SMTP id qp8mr6458385igc.25.1360702902957;
        Tue, 12 Feb 2013 13:01:42 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPS id nh1sm15970046igc.4.2013.02.12.13.01.40
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 12 Feb 2013 13:01:41 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <dcc4f597f26531b79bd9f097c73f6f186b73c81d.1360700102.git.john@keeping.me.uk>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216198>

John Keeping wrote:

> Signed-off-by: John Keeping <john@keeping.me.uk>
[...]
> --- a/Documentation/Makefile
> +++ b/Documentation/Makefile
> @@ -81,6 +81,7 @@ DOC_MAN7 = $(patsubst %.txt,%.7,$(MAN7_TXT))
>  prefix ?= $(HOME)
>  bindir ?= $(prefix)/bin
>  htmldir ?= $(prefix)/share/doc/git-doc
> +infodir ?= $(prefix)/share/info
>  pdfdir ?= $(prefix)/share/doc/git-doc
>  mandir ?= $(prefix)/share/man
>  man1dir = $(mandir)/man1
> @@ -98,7 +99,6 @@ RM ?= rm -f
>  MAN_REPO = ../../git-manpages
>  HTML_REPO = ../../git-htmldocs
>  
> -infodir ?= $(prefix)/share/info
>  MAKEINFO = makeinfo

Is this another stylefix or is there a functional reason for this
change?
