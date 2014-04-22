From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Project idea: github-like diff view
Date: Tue, 22 Apr 2014 11:11:46 -0500
Message-ID: <535694c23647e_3e5aed730839@nysa.notmuch>
References: <CACsJy8CQxPrqs31nBvr_oPRD3EJ6Hu-Lq=++7nWpxx5BQZYi8Q@mail.gmail.com>
 <20140420144620.GA16596@sigill.intra.peff.net>
 <CACsJy8DnJeZ-43Ydg_j00CO6=6NOA1wdzQ+EwCX6idrUOLn8gA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Apr 22 18:22:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WcdSa-0005sC-PV
	for gcvg-git-2@plane.gmane.org; Tue, 22 Apr 2014 18:22:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757242AbaDVQWM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Apr 2014 12:22:12 -0400
Received: from mail-ob0-f181.google.com ([209.85.214.181]:35435 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756765AbaDVQWJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Apr 2014 12:22:09 -0400
Received: by mail-ob0-f181.google.com with SMTP id gq1so5831936obb.26
        for <git@vger.kernel.org>; Tue, 22 Apr 2014 09:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=TGm41ie+caa/cQ4tZ1/DS7tJelaJKXn4UefU1Gz5Vm0=;
        b=oHo28YeT9r2WhSvKtoVcGQJFUDpR4/ECAieAvW+kHCk2CO/iCCAuP8fdwju6ytF/vi
         /c5XJElsGw1MmbBM8lT2sPX+ZyGoqwsbuwB90jKHnMf0i2OejTqJcf7tw0EVX+y3UVEj
         hAIe+rINVRYNWsyhUhJYbuJR4A6Jeb5b/a7eW50sLgOf0LGWaXRIJP+oddNjQu4r8m0h
         SqyA5imC76pMZFp7/MrZVX0/HDOI3ml7txMNPAebbFjSLoLFapwoCecN5qmj/61U2331
         8P15fFclYDE5A7GFg3jLH/xBGM6GzpzsFyV/aBcCw1XwDw7ip7K90EujH+r6ruhfyem2
         qxBg==
X-Received: by 10.60.16.103 with SMTP id f7mr37911765oed.8.1398183728955;
        Tue, 22 Apr 2014 09:22:08 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id sm4sm61317255obc.3.2014.04.22.09.22.06
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Apr 2014 09:22:07 -0700 (PDT)
In-Reply-To: <CACsJy8DnJeZ-43Ydg_j00CO6=6NOA1wdzQ+EwCX6idrUOLn8gA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246747>

Duy Nguyen wrote:
> On Sun, Apr 20, 2014 at 9:46 PM, Jeff King <peff@peff.net> wrote:
> > On Sun, Apr 20, 2014 at 04:58:28PM +0700, Duy Nguyen wrote:
> >
> >> - --color-words within unified diff format, using background color to
> >> show what part of the line has changed. This is only enabled for
> >> 1-line changes.
> >
> > See contrib/diff-highlight.
> 
> Thanks. I'd rather have it built in core git still. I'll try to see if
> I can rewrite it in C. Else, any objection to promote it to a core
> helper and setup pager automatically? We can have a config key to turn
> it off, but if git diff is colored, then it could be on by default.

Having so many tools that should be rewritten to C, I don't see why anybody
should spent time rewriting scripts that are not part of the core and for the
most part do their job already.

-- 
Felipe Contreras
