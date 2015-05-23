From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH/RFC 0/3] using stat() to avoid re-scanning pack dir
Date: Sat, 23 May 2015 08:21:20 +0700
Message-ID: <CACsJy8CY-_b6NzQrd==vrVZnTx-r7jYu4dtep8wEcgGRX79_Zg@mail.gmail.com>
References: <7FAE15F0A93C0144AD8B5FBD584E1C5519758FC3@C111KXTEMBX51.ERF.thomson.com>
 <CACsJy8AMhEKe-eM7jvYcEx+7ZmfvdD+p1s4VYHjKuAwZsDWc-w@mail.gmail.com>
 <CACsJy8Cs6GcRQ-kgnSqwxP4MPHfds9qiir1_O1hc5cZ+0QP-EA@mail.gmail.com>
 <7FAE15F0A93C0144AD8B5FBD584E1C5519759641@C111KXTEMBX51.ERF.thomson.com>
 <CACsJy8BULBJ=cL1+4TFX_7tYSCFL3MNEz1Ay0YGqx8W_8=nwAg@mail.gmail.com>
 <20150522071224.GA10734@peff.net> <7FAE15F0A93C0144AD8B5FBD584E1C551975ADA4@C111KXTEMBX51.ERF.thomson.com>
 <CACsJy8DMqj8sCowZ5f-QZMgrAMFjGOaWfYjZWHxs+jvBsDpp5w@mail.gmail.com>
 <7FAE15F0A93C0144AD8B5FBD584E1C551975B851@C111KXTEMBX51.ERF.thomson.com>
 <20150522235116.GA4300@peff.net> <CACsJy8BjFM_OecoVU9DV3GmJafatSR2yPt6Xb6dETEpYjc1ODA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: steve.norman@thomsonreuters.com,
	Git Mailing List <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat May 23 03:21:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yvy8S-0002KC-FP
	for gcvg-git-2@plane.gmane.org; Sat, 23 May 2015 03:21:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757185AbbEWBVw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 May 2015 21:21:52 -0400
Received: from mail-ie0-f170.google.com ([209.85.223.170]:32794 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756314AbbEWBVv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 May 2015 21:21:51 -0400
Received: by iebgx4 with SMTP id gx4so42540251ieb.0
        for <git@vger.kernel.org>; Fri, 22 May 2015 18:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=eUJLLn9YiqTyMU5m7wm9evfxWTnnj4W/853R5mObscM=;
        b=VlDWQLlHb2r1dNWMr65PX2WMeI5RrZRM82zg9K6yjZLQAl9/xLRKPJpqEqCiagfOFg
         8dwXgBEDjICKhGMFfb316xNGHHoI1osB1BqI5EMfN9vBtcFoYnOhhiCiYdCm2oN5PUIO
         TDlhmMIp+5T2RW+5m5PzPch1f8xvHXJRiiMf6w8+rNc2kokozn86X36Zo4B0cYB5kr/Y
         TP6Z3CQuVfNwTUNL9/J9SMUGAUrzxUm8luHsWiPDl9vZeN2w5I6SnagdPBOC1P6q0dxI
         DHk6QBJn7hmpCeNGIPSMNVfDx9zJR3gMF6OQwn9dCts8HZEii5EsaMoYjhj9xeNrBYmb
         5RXw==
X-Received: by 10.107.128.30 with SMTP id b30mr14003556iod.84.1432344110804;
 Fri, 22 May 2015 18:21:50 -0700 (PDT)
Received: by 10.107.181.136 with HTTP; Fri, 22 May 2015 18:21:20 -0700 (PDT)
In-Reply-To: <CACsJy8BjFM_OecoVU9DV3GmJafatSR2yPt6Xb6dETEpYjc1ODA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269788>

On Sat, May 23, 2015 at 8:19 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> But people often just do open operation of a time and this racy is not an issue.

Very bad proof reading. This should read "But people often do one
operation at a time.."
-- 
Duy
