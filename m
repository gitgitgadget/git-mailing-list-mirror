From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: serious performance issues with images, audio files, and other 
	"non-code" data
Date: Tue, 18 May 2010 20:54:19 +0200
Message-ID: <AANLkTintESjlaE_YSYBcZxF0lP7GhXnXdYmYzb4phjas@mail.gmail.com>
References: <4BEAF941.6040609@puckerupgames.com> <20100514051049.GF6075@coredump.intra.peff.net> 
	<4BED47EA.9090905@puckerupgames.com> <20100517231642.GB12092@coredump.intra.peff.net> 
	<4BF2E168.2020706@puckerupgames.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: John <john@puckerupgames.com>
X-From: git-owner@vger.kernel.org Tue May 18 20:54:48 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OERwD-0000h7-FU
	for gcvg-git-2@lo.gmane.org; Tue, 18 May 2010 20:54:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757796Ab0ERSyk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 May 2010 14:54:40 -0400
Received: from mail-gx0-f227.google.com ([209.85.217.227]:42583 "EHLO
	mail-gx0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756476Ab0ERSyk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 May 2010 14:54:40 -0400
Received: by gxk27 with SMTP id 27so3643726gxk.1
        for <git@vger.kernel.org>; Tue, 18 May 2010 11:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=3UQrS1BwaD1YZykmx8hRfxfZuId7xDfpjYH2ItPzH+M=;
        b=m+NKMIsOvzFXu5KkfTrsT7jRj5JeNtTO0fX2+sUw4Pq77Xv/HKQUKqp9456mAVoqBW
         Zd26/1ht00/3PSNrqfQAt2v/49znZA6JhkM0lQqlL7rKxaeMfwhmpFoDxJyt1nzqeKZF
         nCj1ZmgkMXX+3rlfMDO/LzEzk9REAmwMIO0Xg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=fb+R1lZMEdZNGTpxj6kUr8vGxh3KChUk83jw4jwm2ZFh5hQK2aBEuvsOsXMhOFp8Pl
         2nvwhFRfjin4JrX63Fg5Dm1WXz5peg/NQR+Do5RqP5cik0lnm7Pkkw5meCifVyHGDJjt
         6Uanj+4VDym1E4Ku55ZoHJiB8dZYlIFN8ta38=
Received: by 10.151.28.14 with SMTP id f14mr2785043ybj.398.1274208879125; Tue, 
	18 May 2010 11:54:39 -0700 (PDT)
Received: by 10.151.125.11 with HTTP; Tue, 18 May 2010 11:54:19 -0700 (PDT)
In-Reply-To: <4BF2E168.2020706@puckerupgames.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147295>

Heya,

On Tue, May 18, 2010 at 20:50, John <john@puckerupgames.com> wrote:
> I just compiled the latest git. It got worse!!

I think that's got --aggressive got more aggressive :). We now do
--window=200 and --depth=200 for --aggressive gc's.

-- 
Cheers,

Sverre Rabbelier
