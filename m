From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: [PATCH 1/8] imap-send: remove useless uid code
Date: Fri, 9 Oct 2009 18:12:02 +0200
Message-ID: <40aa078e0910090912t54df0433y8c1bad523bfa6d70@mail.gmail.com>
References: <1255100682-13952-1-git-send-email-kusmabite@gmail.com>
	 <fabb9a1e0910090821n67c86d0kb4eef1b9ff4bdff1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, gitster@pobox.com, Jeff King <peff@peff.net>,
	Erik Faye-Lund <kusmabite@gmail.com>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 09 18:16:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MwI8O-0000xi-Fl
	for gcvg-git-2@lo.gmane.org; Fri, 09 Oct 2009 18:16:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933474AbZJIQMl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Oct 2009 12:12:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932596AbZJIQMk
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Oct 2009 12:12:40 -0400
Received: from mail-fx0-f227.google.com ([209.85.220.227]:54330 "EHLO
	mail-fx0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757733AbZJIQMk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Oct 2009 12:12:40 -0400
Received: by fxm27 with SMTP id 27so6538270fxm.17
        for <git@vger.kernel.org>; Fri, 09 Oct 2009 09:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=k23OBh3AIIM45NPh3dw+z8iAoyTNvkIp2oEjMk7GnGc=;
        b=kX+GyMtVH6tOt3TD4EFj6rSGwXXYRrkzI9pUjNeat+5GjrzBrU7ORSRDgv2nlQk11U
         0IOuuwwnngOEcBx+LPaYSMmJfRFtnQDKuP6EVA4PRGb5XwaVY0aT+O21/DZupkCuCiXM
         VSIw7CHOH4JqaeKvdcA1k/XzBIt3STQwSDFUc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=VAd5QXb+a+mWUw41xbv8bW8/xwYTuSh8ft4qbGkPo3Uf0EBeUgS7JK37enSvl5z64S
         m/SnaeNRiP1EL14EmcnSHTldHsC/iGYeChfsB4AbGqVaLxekCLJtM9MAGKR1NHXjkfe2
         bdz/Rxq23yGy01mgib1mLgYkJHYJMDv/xL1co=
Received: by 10.204.154.216 with SMTP id p24mr2316788bkw.16.1255104722874; 
	Fri, 09 Oct 2009 09:12:02 -0700 (PDT)
In-Reply-To: <fabb9a1e0910090821n67c86d0kb4eef1b9ff4bdff1@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129823>

On Fri, Oct 9, 2009 at 5:21 PM, Sverre Rabbelier <srabbelier@gmail.com> wrote:
> Heya,
>
> On Fri, Oct 9, 2009 at 17:04, Erik Faye-Lund <kusmabite@googlemail.com> wrote:
>
> Please include a cover letter for series as long as these (anything
> larger than 4 should have a cover letter IMHO). Doing so makes it
> easier for those that follow the series to see what changed (assuming
> you write down what changed in the cover letter). Also, it makes it
> easier for those that were not following the series to drop in at the
> current version (assuming you provide a short summary of what the
> series is about in the cover letter)..

Doh, I'm sorry about this. Here's an added cover-letter, I hope it helps:

--->8---
Here's the 2nd iteration of my patches  for Windows-compatibility in imap-send.

Patch 1-3 is about getting rid of or rewriting code with portability issues.

Patch 4 fixes a compilation error on Windows

Patch 5 enables compilation of imap-send

Patch 6-7 enables SSL-suport for mingw

Patch 8 enables imap-send and SSL for msvc

Changes in this iteration compared to the previous are as follows:

 - Patch 7 has been replaced with patch 1 in the current series. All
other patches from the previous iteration has been shifted up a number
due to this.
 - Patch 2 (previously 1) now has a short comment that declares it's intent.
 - Patch 8 has been included

-- 
Erik "kusma" Faye-Lund
kusmabite@gmail.com
(+47) 986 59 656
