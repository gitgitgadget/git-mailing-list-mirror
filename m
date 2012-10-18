From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] Add new git-remote-hd helper
Date: Thu, 18 Oct 2012 10:48:51 +0200
Message-ID: <CAMP44s3=pv4kHiZ2KM+e1tnGo=38oy76Sm3i3VMDFseWXZH85Q@mail.gmail.com>
References: <1350478721-3685-1-git-send-email-felipe.contreras@gmail.com>
	<20121017225913.GC21742@sigill.intra.peff.net>
	<CAMP44s0+Fhtj2rMQ1Av-49Koa=DumX8JZs5angOFSRzqtDc+9Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Oct 18 10:49:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TOlmq-0006Hl-8S
	for gcvg-git-2@plane.gmane.org; Thu, 18 Oct 2012 10:49:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754718Ab2JRIsx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2012 04:48:53 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:57974 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754624Ab2JRIsw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Oct 2012 04:48:52 -0400
Received: by mail-ob0-f174.google.com with SMTP id uo13so8299907obb.19
        for <git@vger.kernel.org>; Thu, 18 Oct 2012 01:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=icsWGoROMhXIilAHDWGZ2xNSeb3KN7+al+JqXK559Ew=;
        b=Uh/dnDwP9q4c/7GS01paZeUCMT3A54PsY8GsPpSSm3vt/o5tuD8AJuYeMuAeXW2/8o
         NUz4Lh/vrZEAI0sjXF+85JsbHKucAwHuv/dU6Xz6A7KsU6KdJ6D9hGfWDFHZZe8lrcS+
         tk+I4JlxatJ7O6L86E4lBvuiarKmqfQ6nt1i/owHiE0ys7b5ujBg712rnQgE83a4NOTS
         Eg55Hi8vwFdhwo4Nunlh3Tgu7enlhWqijhIDYC4RK58GK075Cs0vlISVAumPhImpzJYy
         X7wZoXYKhm/8MBqeRuV4GBNteDJp2DNWcCqs6222DTbW35+JEhXttE/y6ypMs095YqgH
         pydA==
Received: by 10.60.27.71 with SMTP id r7mr18389843oeg.96.1350550131411; Thu,
 18 Oct 2012 01:48:51 -0700 (PDT)
Received: by 10.60.58.137 with HTTP; Thu, 18 Oct 2012 01:48:51 -0700 (PDT)
In-Reply-To: <CAMP44s0+Fhtj2rMQ1Av-49Koa=DumX8JZs5angOFSRzqtDc+9Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207979>

On Thu, Oct 18, 2012 at 5:44 AM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> On Thu, Oct 18, 2012 at 12:59 AM, Jeff King <peff@peff.net> wrote:

>> The first thing I tried was:
>>
>>   $ git clone hg::https://code.google.com/p/dactyl/
>
> Right, doesn't look like it works for remote repositories. I think
> that's the next feature I want to implement, but to be honest, I don't
> think it's a big issue. To replace this:

Done, now you should be able to clone and fetch remote repositories :)
https://github.com/felipec/git/commit/783e4b380ab4fabb4e2fb200722c92afc8494a83

-- 
Felipe Contreras
