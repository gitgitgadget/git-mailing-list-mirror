From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH 10/12] MINGW: config.mak.uname: drop USE_NED_ALLOCATOR
Date: Mon, 28 Apr 2014 17:23:25 +0200
Message-ID: <CABPQNSZD5jz1A8=zQvU4dYvNb-5M+TV50Uj+oVbWJs3YWBytHw@mail.gmail.com>
References: <1398693097-24651-1-git-send-email-marat@slonopotamus.org> <1398693097-24651-11-git-send-email-marat@slonopotamus.org>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: GIT Mailing-list <git@vger.kernel.org>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Marat Radchenko <marat@slonopotamus.org>
X-From: git-owner@vger.kernel.org Mon Apr 28 17:24:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WenPi-0003s2-PX
	for gcvg-git-2@plane.gmane.org; Mon, 28 Apr 2014 17:24:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756563AbaD1PYJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2014 11:24:09 -0400
Received: from mail-ie0-f178.google.com ([209.85.223.178]:36671 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756561AbaD1PYG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 11:24:06 -0400
Received: by mail-ie0-f178.google.com with SMTP id lx4so6751443iec.37
        for <git@vger.kernel.org>; Mon, 28 Apr 2014 08:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=krKJQBwQbjmKe14tCZoUU2MbchYNy+e8enyHngk181o=;
        b=fSqJX2QaEr6hGEOBNvT6Tb0ZmshSjASfOsMBO2Hsd3qQt9lyRgXpknGzFB+FEfQnhi
         Cwx1weWZ6487wIB5EeydBbLcxTpSj1+XnXOVs3pA1Xi9TN2rlmygbim2ImvmWZZeFzPP
         DfSWITJ+qY8iMOyc0iSTQTYxa5uns6lbEIxZSBw7fvuakgswz37LgKQ16uV4rwo8tkJP
         ZgHLcRo/Hl5l4je+HVx71uaL9KrvKT7C0cYFi1T0wxt2gWilJs9mBlHHd1GUYlyGryWf
         9KHYdPBznSNR2kO+iDDaUHi+v9iK9jG/0m6Cn4tDrM6txD/TWtLf7Ibgm53cjehbqRQj
         0Egw==
X-Received: by 10.50.30.6 with SMTP id o6mr24368259igh.43.1398698645533; Mon,
 28 Apr 2014 08:24:05 -0700 (PDT)
Received: by 10.64.166.135 with HTTP; Mon, 28 Apr 2014 08:23:25 -0700 (PDT)
In-Reply-To: <1398693097-24651-11-git-send-email-marat@slonopotamus.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247361>

On Mon, Apr 28, 2014 at 3:51 PM, Marat Radchenko <marat@slonopotamus.org> wrote:
> nedalloc was initially added in f0ed82 to fix slowness of standard WinXP
> memory allocator. Since WinXP is EOLed, this point is no longer valid.
>
> The actual reason behind this commit is incompatibility of malloc.c.h
> with MinGW-W64 headers. Alternative solution implies updating nedalloc
> to something newer.

Did you measure that malloc on newer Windows-versions are actually
faster? AFAIK, malloc does a lot more inside the CRT than in the
kernel...
