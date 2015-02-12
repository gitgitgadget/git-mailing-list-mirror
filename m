From: David Glasser <glasser@davidglasser.net>
Subject: Re: Keep original author with git merge --squash?
Date: Thu, 12 Feb 2015 14:19:24 -0800
Message-ID: <CAN7QDo+OnMUXtj7rYqxAT+pMMVyCrySqxn4vtwvFY+kD2WEvLQ@mail.gmail.com>
References: <CAN7QDoKQAZKUt_MHWjgt1k3PvXQv6XTcjdijh8KRodO3=VD47A@mail.gmail.com>
 <20150212092824.GA19626@peff.net> <xmqqpp9erihg.fsf@gitster.dls.corp.google.com>
 <CAN7QDoLKFBCJpFa+QL8dPQtwyAyDNt-ck_sNJ3fS+vTrK_Lg9w@mail.gmail.com>
 <xmqq8ug2rfi2.fsf@gitster.dls.corp.google.com> <CAN7QDoJ+hOFqoc54sAbLeSxvj8TQKQRSVKbNQXZYfPv1uOy=WA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 12 23:19:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YM26v-0001BH-T0
	for gcvg-git-2@plane.gmane.org; Thu, 12 Feb 2015 23:19:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752370AbbBLWTq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Feb 2015 17:19:46 -0500
Received: from mail-wi0-f176.google.com ([209.85.212.176]:44528 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751544AbbBLWTp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Feb 2015 17:19:45 -0500
Received: by mail-wi0-f176.google.com with SMTP id h11so7874902wiw.3
        for <git@vger.kernel.org>; Thu, 12 Feb 2015 14:19:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=+0xO+DkDdZO4qOG1exdk67bE65GIOF9FvxuVCtiu6Z0=;
        b=Nw6ddkrORo1+mKrHMcTJN8TIgvHV4E6Y5C6rXSNKAhuZCNNwTu6xYvhV1Q7FY+xQ/f
         JhlcoOP/KxB3sJT2gXjJDs9D3FNNpw8x8iDV4SgmDi/Bp+tLW2+IudeirSRpRsGT1VtN
         Vv4+3S79/dBAtgEiyFF7R8RERi6d95xTiYlhK0ZcXvNVuZ1zNukQK3o0LiEYa30gwayJ
         aKYio+JZ6pi1xHP31j/S3ROM1/rLtrCvTjvf5/THuOvN6G8UObVxvUB1H0q/TCaO+Ukv
         GTwhRLoy9PXq7Z0J32BdNf3YMIVYe+n1QlTact6pi2A4h1If1tWPYN/mYzC4/1KZN0qa
         aHDg==
X-Received: by 10.180.7.199 with SMTP id l7mr1153897wia.66.1423779584381; Thu,
 12 Feb 2015 14:19:44 -0800 (PST)
Received: by 10.194.29.200 with HTTP; Thu, 12 Feb 2015 14:19:24 -0800 (PST)
In-Reply-To: <CAN7QDoJ+hOFqoc54sAbLeSxvj8TQKQRSVKbNQXZYfPv1uOy=WA@mail.gmail.com>
X-Google-Sender-Auth: nKyDln3Fdut5rp2l-AR69Ln7V9Q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263774>

On Thu, Feb 12, 2015 at 2:16 PM, David Glasser <glasser@davidglasser.net> wrote:
> - Before invoking prepare-commit-msg, all of the `Author:` lines found
>   in SQUASH_MSG have the same value

OK, and to be very specific: I'm just proposing "literally the same
text written after Author"; using mailmap to detect that multiple
different Author lines are actually the same author could be a
potential later improvement.

-- 
glasser@davidglasser.net | langtonlabs.org | flickr.com/photos/glasser/
