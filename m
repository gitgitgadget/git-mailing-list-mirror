From: Santhosh <santhoshmani@gmail.com>
Subject: Re: [RFC/PATCH] show tracking branches with their associated branch names
Date: Mon, 12 Dec 2011 19:49:54 +0530
Message-ID: <CABtqY3zwRooPUyPrLu3pf0fnHS+WP0XVKDFhZ1S0sR4cq=aP5A@mail.gmail.com>
References: <1323502829.1698.6.camel@sdesktop>
	<4EE32C1B.8070306@lyx.org>
	<1323516226.1698.80.camel@sdesktop>
	<7vsjkq5h0i.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Vincent van Ravesteijn <vfr@lyx.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 12 15:20:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ra6jZ-0004fh-En
	for gcvg-git-2@lo.gmane.org; Mon, 12 Dec 2011 15:20:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752720Ab1LLOT4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Dec 2011 09:19:56 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:57734 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752467Ab1LLOTz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Dec 2011 09:19:55 -0500
Received: by ghbf1 with SMTP id f1so1026277ghb.19
        for <git@vger.kernel.org>; Mon, 12 Dec 2011 06:19:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=nY4dBo4I2x0y13/ad6lQEJU/aEDnQUybiygkqf003XQ=;
        b=pH8cf/Gfku9y4M2MtiyfAvJqEuDXkU8tkQ6TjIcFKXJGcFxknzZSQ1NGFQgHMEjpos
         kIH0e+D6sq8szrxnW0fxu5IdUvRHhOigGEFkmvIC78f0CwneMHLmJ4DJJiELrcE+I3YA
         SBoVFbIwIi4J7u2gI38t6rJTn3dBFMdj3ekyY=
Received: by 10.236.115.40 with SMTP id d28mr25724077yhh.37.1323699595168;
 Mon, 12 Dec 2011 06:19:55 -0800 (PST)
Received: by 10.236.191.225 with HTTP; Mon, 12 Dec 2011 06:19:54 -0800 (PST)
In-Reply-To: <7vsjkq5h0i.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186911>

On Mon, Dec 12, 2011 at 12:44 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
> It makes sense to make the various information available, but it does not
> mean it makes sense to add it by default for everybody at all. Given that
> against all common sense, many newbie web-tips and third-party documents
> suggest "git branch | sed -ne 's/^\* //p'" as a way to find the current
> branch in scripts, I am sure such a change will cause trouble to many
> while only helping a few.
>

You certainly have a point.

> I wouldn't mind a new option --verbose-format=... that takes various
> formatting letters similar to how --pretty=format:... does, though.
>

I will explore this option and see if it is worth the trouble.
Probably I can accomplish this locally with an alias.

~Santhosh.
