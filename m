From: Fredrik Kuivinen <frekui@gmail.com>
Subject: Re: [PATCH] Makefile: Track changes to LDFLAGS and relink when necessary
Date: Wed, 22 Jun 2011 12:44:05 +0200
Message-ID: <BANLkTi=4Pj0bLswUNLXebkVOqLOiq2eNoA@mail.gmail.com>
References: <1308682726-20971-1-git-send-email-frekui@gmail.com>
	<BANLkTi=XOEFyVu-ZEqpmLaD60FL6dV2ndA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 22 12:44:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QZKur-0005Qu-Ev
	for gcvg-git-2@lo.gmane.org; Wed, 22 Jun 2011 12:44:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755078Ab1FVKoI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Jun 2011 06:44:08 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:50791 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753330Ab1FVKoH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jun 2011 06:44:07 -0400
Received: by fxm17 with SMTP id 17so535755fxm.19
        for <git@vger.kernel.org>; Wed, 22 Jun 2011 03:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=mE90neRoF7FbMAZ3zPf65fKtdRd/lyMB/AlM4DUH8vY=;
        b=SyZdVTlE4X1NmmTS8Yowtvx69olOTOZ5pYwmQPSgogR8lBKmNl08PyG4CemlYMRCC6
         JIoj1v4nFI08Ax/7oy0sLYQbjVVthDS/RPqOGDHoqeIh7GuvC4t1G/D//Ffc7sZYBGij
         FM408/vBq6pzeSw/G0TXM1pSjpKcxZ7VNBTLY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=JeVwbFrdgZkWfiy7C9U3vL1pTwFiT46kCZI0qufy8WTh0z9JZwqeN1NqPKgf7LcxHS
         vwTP7wb1PlaNQxXJJPVgz5AId3BB2FBreROsPUvCryjDEw+Lnpz4iwPJy+gGDs2e/hdb
         ZhA5BsMWFuava6LP0zoOekGOe4QrSuM3PMAQw=
Received: by 10.223.44.86 with SMTP id z22mr709413fae.3.1308739445190; Wed, 22
 Jun 2011 03:44:05 -0700 (PDT)
Received: by 10.223.117.3 with HTTP; Wed, 22 Jun 2011 03:44:05 -0700 (PDT)
In-Reply-To: <BANLkTi=XOEFyVu-ZEqpmLaD60FL6dV2ndA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176233>

On Wed, Jun 22, 2011 at 10:51, Sverre Rabbelier <srabbelier@gmail.com> wrote:
> Heya,
>
> On Tue, Jun 21, 2011 at 20:58, Fredrik Kuivinen <frekui@gmail.com> wrote:
>
> It might be interesting to note in the commit message why this change
> is made (now), and if there are any other similar flags that we ought
> to track.

I agree, will send an updated patch in a minute. I don't know why the
change hasn't been done before. Maybe people don't change LDFLAGS
that often so it has simply been no need for the change.


- Fredrik
