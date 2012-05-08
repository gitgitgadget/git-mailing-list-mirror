From: Steven Penny <svnpenn@gmail.com>
Subject: Re: Git commit path vs rebase path
Date: Tue, 8 May 2012 02:11:07 -0500
Message-ID: <CAAXzdLW9_O+feVpBhDSXQH_SFRdrct1tjadpFoJ5d7-Qd1LWEg@mail.gmail.com>
References: <CAAXzdLU6bQ7ta4_-WfGJVaJgt1R5tX=4PW2sq3SdjAB+F72w+Q@mail.gmail.com>
	<7vaa1j7vg1.fsf@alter.siamese.dyndns.org>
	<4FA8BBB0.1080406@viscovery.net>
	<CAAXzdLVaDAQkd_9qjnmTRoy8ccpyrZvwvBJQAfkp7LkYa7Li2A@mail.gmail.com>
	<4FA8C5DB.5060002@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue May 08 09:11:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SReZm-0004fx-2h
	for gcvg-git-2@plane.gmane.org; Tue, 08 May 2012 09:11:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755418Ab2EHHLJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 May 2012 03:11:09 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:47203 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753964Ab2EHHLI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 May 2012 03:11:08 -0400
Received: by yenm10 with SMTP id m10so4527624yen.19
        for <git@vger.kernel.org>; Tue, 08 May 2012 00:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=vFI6Efm+JZQqB71am5aWi9K5ahQy8b0UBGgmdcq2yNo=;
        b=kZapsac0aJhFwzkMgdOqLFMtna2eRU4rC4Y+JJa5CqwYqSIWD6UdDAUr+Ia9oot84m
         T1dAaqzuH/Ekd6PgSzoGNaI9A145VUF8iZNIo7c4g+hWQq0vSv1hOo832EBTndu/qN0S
         TaF4jzW8wVCRhJoY9mt50OEQW/y9UpzithFekxdDJHsqEalyU4smXxVwTYyUbL8JVAqJ
         W5vs/cfAMAc87/guCu3prRmvkmoMu19A7fJWlzaXrK9NcEIax6u9SmdjqW9u8q8ZZSdP
         WHYZMl3C7SlWlpKuGu2VKWrSeGA16bjsMrwTmbLooCTMseVsXsCO6WRBWexomMhyb3mE
         wU3A==
Received: by 10.50.106.132 with SMTP id gu4mr10166377igb.59.1336461067121;
 Tue, 08 May 2012 00:11:07 -0700 (PDT)
Received: by 10.231.80.147 with HTTP; Tue, 8 May 2012 00:11:07 -0700 (PDT)
In-Reply-To: <4FA8C5DB.5060002@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197343>

Johannes Sixt wrote:
> Are you saying that the new pwd function will also be used on Cygwin? That
> would be a bug.

The linked patch should fix the problem for _MinGW_ users.

The problem will persist with _Cygwin_ users.
