From: Martin von Zweigbergk <martinvonz@gmail.com>
Subject: Re: [PATCH] builtin/reset.c: Fix a sparse warning
Date: Mon, 14 Jan 2013 11:35:36 -0800
Message-ID: <CANiSa6iaZQnoX4bGGLi1UFDr3EUeNgMf2FKvryWd9+yySJXKUA@mail.gmail.com>
References: <50F45C7B.9030608@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Mon Jan 14 20:35:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tupp8-000859-1b
	for gcvg-git-2@plane.gmane.org; Mon, 14 Jan 2013 20:35:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756708Ab3ANTfh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jan 2013 14:35:37 -0500
Received: from mail-ie0-f182.google.com ([209.85.223.182]:63071 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756216Ab3ANTfh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jan 2013 14:35:37 -0500
Received: by mail-ie0-f182.google.com with SMTP id s9so5680775iec.27
        for <git@vger.kernel.org>; Mon, 14 Jan 2013 11:35:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=ltzrMtJbgSRZD1kEO3W5KepTvk8ZT8mncVIuwq8DSbU=;
        b=uEE0/QNZJjqrLzt8oUlASbgl60HnkIBCghHQW3l5CIsLj4WLOUZtBGegRCvhtueIeP
         H+0nKOx4GYZvUKOuvVly952dLP9OISzAaANqxj+4OA6RBI0Xc57pKp8inhFAYf93a8To
         MzYIP91tVHmiOL0xfGo5Y1A13fdjZ0og866T5rbbD2nj91SrodcSFGevnUJ9cVmqrCov
         H5i5aya06DW6OM9rq/OazTn7xIuXwuc/6sSghk/0goTRcqO/i2Ye+7wXbqTml2d8UT1D
         ywUxROcvthNr34eSotMpwNpe+3jyWNIvWoI1e0LqL2n56MTQB29fpVTHOrHUhGICrW51
         4a/g==
X-Received: by 10.50.196.130 with SMTP id im2mr7807248igc.17.1358192136868;
 Mon, 14 Jan 2013 11:35:36 -0800 (PST)
Received: by 10.64.86.68 with HTTP; Mon, 14 Jan 2013 11:35:36 -0800 (PST)
In-Reply-To: <50F45C7B.9030608@ramsay1.demon.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213521>

On Mon, Jan 14, 2013 at 11:28 AM, Ramsay Jones
<ramsay@ramsay1.demon.co.uk> wrote:
>
> In particular, sparse issues an "symbol not declared. Should it be
> static?" warning for the 'parse_args' function. Since this function
> does not require greater than file visibility, we suppress this
> warning by simply adding the static modifier to it's decalaration.

Oops, how did I miss that? Will fix in re-roll. Thanks.

Martin
