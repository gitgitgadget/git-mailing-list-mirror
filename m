From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 2/7] completion: get rid of empty COMPREPLY assignments
Date: Wed, 10 Apr 2013 05:47:49 -0400
Message-ID: <CAPig+cR7mSiG-s4S6wgL0R4fQOuriyNndHT568WDC076NB7Z9A@mail.gmail.com>
References: <1365577077-12648-1-git-send-email-felipe.contreras@gmail.com>
	<1365577077-12648-3-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	=?ISO-8859-1?Q?SZEDER_G=E1bor?= <szeder@ira.uka.de>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 10 11:47:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPrdE-0004Zf-Re
	for gcvg-git-2@plane.gmane.org; Wed, 10 Apr 2013 11:47:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937067Ab3DJJrw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Apr 2013 05:47:52 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:57795 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935771Ab3DJJrv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Apr 2013 05:47:51 -0400
Received: by mail-lb0-f174.google.com with SMTP id s10so319576lbi.5
        for <git@vger.kernel.org>; Wed, 10 Apr 2013 02:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=WyUGJb1xNP9E/vTCtHSkAhpsCU0MvxxrW9tR9h1ftqI=;
        b=bFX00LaQMu7pecAoLr8dBnJOQuKtqRI9+KjqNd6Dz8/lPo6T5wqG3/XaEqJ7l5y0x+
         5dr6ZAeJz6Th9KKxkRANE/dBLf/FFSa8lkj2GXT0/MeyptJj/LPClP3RDi8oKyHxnqrP
         uxSm6NV/rBjPcrx2p45Oeo6mpj2DBB1GKGk1GK4fYb/AZ2ckT068NuA/qeuX3HJKW3jY
         rGfWVoxQQ5yrUG/1Z6an0r/V4s9o5g6B0fp1XN9ePW8o541KBTPr9bXknkVloUCf7H5d
         39ncdRYXWAjlx6B7dE3KVawPnXz/++T8jLSGDOHsf5/87mpr3pfvI2GJRhES0RIxGx8Q
         Z3Bg==
X-Received: by 10.152.122.100 with SMTP id lr4mr661695lab.28.1365587269891;
 Wed, 10 Apr 2013 02:47:49 -0700 (PDT)
Received: by 10.114.174.104 with HTTP; Wed, 10 Apr 2013 02:47:49 -0700 (PDT)
In-Reply-To: <1365577077-12648-3-git-send-email-felipe.contreras@gmail.com>
X-Google-Sender-Auth: XSsTzf-oEo9CzPAPO5HWGT39ue0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220675>

On Wed, Apr 10, 2013 at 2:57 AM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> There's no functional reason for those, the only purpose they are
> supposed to serve is to say "we don't provide any words here", but even
> for that it's not used consitently.

s/consitently/consistently/

> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
