From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 02/13] fast-export: support done feature
Date: Sun, 29 Aug 2010 19:32:01 -0500
Message-ID: <AANLkTi=wdvZpPixsQ5B+mJUbnp40Myf4rQDS+pnLezW5@mail.gmail.com>
References: <1283053540-27042-1-git-send-email-srabbelier@gmail.com>
 <1283053540-27042-3-git-send-email-srabbelier@gmail.com> <AANLkTikx__RWGhxZUtdOKJy=X=0trfdnd50tcstHhRO3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 30 02:32:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OpsIU-0005Gk-P2
	for gcvg-git-2@lo.gmane.org; Mon, 30 Aug 2010 02:32:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754187Ab0H3AcW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Aug 2010 20:32:22 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:46304 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753587Ab0H3AcV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Aug 2010 20:32:21 -0400
Received: by ywh1 with SMTP id 1so1472634ywh.19
        for <git@vger.kernel.org>; Sun, 29 Aug 2010 17:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=ut0VR4RKEnKO1aDysossmF/Cqvj2wiuaG1crM7RygYs=;
        b=N6hrNpMaqVwWhOrB6/7YuDqFi2DkVj0t0mLVgf2FVn7R/S608wb2t2XMfXWZ5McbMI
         upnM2eBbhviVLpAjra1nzZayKLV1UVprwssCBEC94U+VZzJDLv0cDThVjznETGpS2oEE
         NZWismcG1co1k2FPh4Ca4A3qBV9L7hUJ5GaoM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=hZb7nhkwKGrPvn3gOCYUX/jxU/AaMDIheCkVYYIoWbc04qpCcxfp5YUhsNAdXbMqVF
         Pp/dG2xttz46fDwJ403qIhRGNzPIEcGF3tqs65p0vhz3BhgXGzIZOJa+MzuyqEm6wgAi
         Zt5wRWgmpGGDyNCzU2P4IrHLdLKgQDZxAJ7gQ=
Received: by 10.150.53.9 with SMTP id b9mr4442507yba.336.1283128341208; Sun,
 29 Aug 2010 17:32:21 -0700 (PDT)
Received: by 10.151.49.17 with HTTP; Sun, 29 Aug 2010 17:32:01 -0700 (PDT)
In-Reply-To: <AANLkTikx__RWGhxZUtdOKJy=X=0trfdnd50tcstHhRO3@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154737>

Heya,

On Sun, Aug 29, 2010 at 18:42, Tay Ray Chuan <rctay89@gmail.com> wrote:
> For a user, what are the advantages of running it with the
> --use-done-feature? Perhaps this should just be made a
> non-configurable default (ie. always use it) to save the user from
> some thinking.

No, that won't do, since not all importers will support this feature.
We might want to make it the default in the future (users can always
specify --no-use-done-feature), but it should definitely not be made
the default now.

-- 
Cheers,

Sverre Rabbelier
