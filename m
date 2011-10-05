From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [RFC/PATCH] Add multiple workdir support to branch/checkout
Date: Wed, 5 Oct 2011 16:50:45 -0400
Message-ID: <CAG+J_DynQ8U6T9YMsWstKF_Cf6CSCr8b8E4T=p5uyGPh28G=kA@mail.gmail.com>
References: <1317786204-57335-1-git-send-email-jaysoffian@gmail.com>
	<CACsJy8AqYq+YF+rvUp=BBeFUAtUz783iF2jbUp3fO58yLp9ptQ@mail.gmail.com>
	<CAG+J_DygQTD5ibco=-NOiKg0BLgBGFJnvV8zPyhngC2iZv_H8g@mail.gmail.com>
	<7vpqib8jzk.fsf@alter.siamese.dyndns.org>
	<CAG+J_Dz-GXvRbYUXSoyfyHfOO-_BszcOza9x=ysHhmL5YBW-Jw@mail.gmail.com>
	<7vzkhf713u.fsf@alter.siamese.dyndns.org>
	<CAG+J_Dzg2D+vmFRfLX01S2k98YZQBE0FFv76VAyPnXdetyWADQ@mail.gmail.com>
	<20111005200043.GA32732@inner.h.iocl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Andreas Krey <a.krey@gmx.de>
X-From: git-owner@vger.kernel.org Wed Oct 05 22:50:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBYQV-0003xZ-Hz
	for gcvg-git-2@lo.gmane.org; Wed, 05 Oct 2011 22:50:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932299Ab1JEUur (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Oct 2011 16:50:47 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:33356 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755909Ab1JEUuq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Oct 2011 16:50:46 -0400
Received: by gyg10 with SMTP id 10so1962015gyg.19
        for <git@vger.kernel.org>; Wed, 05 Oct 2011 13:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=oA+KTN3vVjyG9VHtbNb2FBfmHDtGgh3jVVJwtQloOh4=;
        b=S3MX8REmD0bV6b3JUkd9inH30tgoow8GOyR/OmLN7aaZuW4I5CdbctzFv/Phk0ZSYM
         Rhi9JOJF74pm8J1X5nXmrg9qf+ZS0Bsud756ziN1X+R6ZmzNLnvhDiuMTysu9CYETvYa
         iI700KKMnNzwRqY/x8JdfX1GdoEYppXh+NLb0=
Received: by 10.236.76.102 with SMTP id a66mr16142573yhe.25.1317847845789;
 Wed, 05 Oct 2011 13:50:45 -0700 (PDT)
Received: by 10.147.32.18 with HTTP; Wed, 5 Oct 2011 13:50:45 -0700 (PDT)
In-Reply-To: <20111005200043.GA32732@inner.h.iocl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182883>

On Wed, Oct 5, 2011 at 4:00 PM, Andreas Krey <a.krey@gmx.de> wrote:
> Hmm. You mean forcing the user to make a new branch *earlier* than at
> commit time is better?

In my mind, we're trying to make new-workdir usable for non-advanced
users. I think it's conceptually simplest to allow a branch to be
checked out only once.

FWIW, I use a modified copy of new-workdir w/this usage:

  git new-workdir <repo> <workdir> <ref> [<start>]

Which allows me to create a new branch and workdir checked out to the
new branch in one shot. It refuses to create the <workdir> if <ref>
resolves to a checked-out branch. (If I want to start detached I can
do so with <ref>^0, but I rarely if ever do that.)

j.
