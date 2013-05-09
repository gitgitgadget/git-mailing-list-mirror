From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 5/5] do not die when error in config parsing of buf occurs
Date: Thu, 9 May 2013 14:23:08 -0400
Message-ID: <CAPig+cTxcQ4o+6RrEHU3iaCvuscX2CoB9hiQsA+0cRM_OD8AUA@mail.gmail.com>
References: <20130509154020.GA26423@book-mint>
	<20130509162102.GG3526@book-mint>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Jens Lehmann <jens.lehmann@web.de>, Jeff King <peff@peff.net>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Thu May 09 20:23:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UaVUp-0007pd-OD
	for gcvg-git-2@plane.gmane.org; Thu, 09 May 2013 20:23:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751222Ab3EISXL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 May 2013 14:23:11 -0400
Received: from mail-lb0-f181.google.com ([209.85.217.181]:44132 "EHLO
	mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750903Ab3EISXK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 May 2013 14:23:10 -0400
Received: by mail-lb0-f181.google.com with SMTP id w10so3360470lbi.40
        for <git@vger.kernel.org>; Thu, 09 May 2013 11:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=I12QbWdoj89gmoPZw8jrmP9tmr1d+3yE+Tym+Ru6HXs=;
        b=OFB2tCAla4ticDms9iQhUMJENzX+PtIU4N/FBBPEbK6UTuRLJys1MiYTnzx/H8U5pu
         EIPoZTbCyZ2qyXLLBrOZ7yGX7UqckUj15wn0GyPnAPhXBX1bQ2OKmDFJAELS8I57lpiB
         k+MydH9C8bRhmRAHJxcr+6W4CUIQdzlybJ/QRfYtJ1q6NXI2GHAybOMbXy0yeooiTVyu
         Lb5nz/xd4OplK/twTyMVQ0yKWjLglT1lQOJC6PU1VpsVbRTGtV/gMnTpOVig9JyUU3l7
         eHIuV66zvJHI6k86dzk+0kXaC3PCpVPZuMg+HQBNLWgKta3FWwX3XmHDfBFjVzNmetnE
         KFKA==
X-Received: by 10.152.120.4 with SMTP id ky4mr6035664lab.5.1368123788620; Thu,
 09 May 2013 11:23:08 -0700 (PDT)
Received: by 10.114.181.3 with HTTP; Thu, 9 May 2013 11:23:08 -0700 (PDT)
In-Reply-To: <20130509162102.GG3526@book-mint>
X-Google-Sender-Auth: Q02VkktnRUEGFOijAp6rVebUYWM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223766>

On Thu, May 9, 2013 at 12:21 PM, Heiko Voigt <hvoigt@hvoigt.net> wrote:
> If a config parsing error in a file occurs we can die and let the user
> fix the issue. This is different for the buf parsing function since it
> can be used to parse blobs of .gitmodules files. If a parsing error
> occurs here we should proceed since otherwise a database containing such
> an error in a single revision could be rendered unuseable.

s/unuseable/unusable/

> Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
