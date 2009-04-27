From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: git grep '(' = segfault
Date: Mon, 27 Apr 2009 20:53:35 +0200
Message-ID: <40aa078e0904271153s48fccf1dj4b1bff62abbaf049@mail.gmail.com>
References: <37fcd2780904271046r7740ed42t3c9438e7aa93374@mail.gmail.com>
	 <alpine.LFD.2.00.0904271059060.22156@localhost.localdomain>
	 <40aa078e0904271142u71d7ba97w9df80667c0d9b955@mail.gmail.com>
	 <alpine.LFD.2.00.0904271149480.22156@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Dmitry Potapov <dpotapov@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Apr 27 20:54:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LyVy7-0006lW-Lb
	for gcvg-git-2@gmane.org; Mon, 27 Apr 2009 20:54:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758600AbZD0Sxi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Apr 2009 14:53:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753534AbZD0Sxh
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Apr 2009 14:53:37 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:53998 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753468AbZD0Sxh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Apr 2009 14:53:37 -0400
Received: by fxm2 with SMTP id 2so94310fxm.37
        for <git@vger.kernel.org>; Mon, 27 Apr 2009 11:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=JtbOUhPVqPhWAktQG9PbNYQsCKheaX/vbaoy/L8ASz8=;
        b=CGkr2CrckXe07ngYmCQQudURIfRxaIFYMwS+e5vW3OPrnoY8Ap8JUXIjbNxs2uTzTK
         7HXieQVp4kAHApyUlHQKnA75NgNFqNXYxOov7XTjkWG1zN4gjpvCdE9PnICYHDJuDHeM
         foXzVN6DOjoChcPlWnCewHoBsoemdijst9iSQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=PE26RLLCgKbRhP5ltOHG/1jL5Otydn0M/m1fSr1Y2aAmkuZ3zg4Lyj7frVfQ+Ebo4a
         +SoO+WxdTKkChiVNhxIGgUWKr1QtSrn3kCIopHKrrwjTj8j3sZAbKNWc6OB0QdaAqF94
         ioFL4hk89pXYFEyojO/922vaEBgURRrooEVN8=
Received: by 10.223.108.140 with SMTP id f12mr2051592fap.69.1240858415831; 
	Mon, 27 Apr 2009 11:53:35 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.00.0904271149480.22156@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117706>

> Practical? Maybe.

Confusing? Yes. ;)

-- 
Erik "kusma" Faye-Lund
kusmabite@gmail.com
(+47) 986 59 656
