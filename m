From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [RFC/PATCH] Documentation/technical/api-fswatch.txt: start with outline
Date: Tue, 12 Mar 2013 15:13:39 +0530
Message-ID: <CALkWK0m+CS25=Z91y90z49g4GK+b7oFugiXoH0h0J6P-yQXRCQ@mail.gmail.com>
References: <1362946623-23649-1-git-send-email-artagnon@gmail.com> <20130311170542.GB4167@sandbox-ub.fritz.box>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Duy Nguyen <pclouds@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	Robert Zeh <robert.allan.zeh@gmail.com>,
	Jeff King <peff@peff.net>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Karsten Blees <karsten.blees@gmail.com>,
	Drew Northup <n1xim.email@gmail.com>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Tue Mar 12 10:44:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UFLky-00006v-Gd
	for gcvg-git-2@plane.gmane.org; Tue, 12 Mar 2013 10:44:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932236Ab3CLJoA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Mar 2013 05:44:00 -0400
Received: from mail-ie0-f175.google.com ([209.85.223.175]:62611 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754946Ab3CLJn7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Mar 2013 05:43:59 -0400
Received: by mail-ie0-f175.google.com with SMTP id c12so6109318ieb.34
        for <git@vger.kernel.org>; Tue, 12 Mar 2013 02:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=6VkW7+nUcE3QV/iKgOWd8jhVrefPxgSSWfFtwfYLy7E=;
        b=ibg+0u9KwXIjv6LCaEV5U5TB2HoBIIJFUR65LT3J41vWl81MThYsPByokfHp7fPEqm
         f9KUMxnc118TR0K7CCxMwkA730JqqzL/2HRmsyKplPFOTtPoj1U1DUmMrFx209QEnyPS
         nOXYNRBm6Nw73ssTBPBRJSjfzLuY07Ab0Q52aRiKUBBnvvuMj0gOF+xsVuraIMZoG/ko
         WEuvHjsoK38+kcsNYSNhgqIBvVOUtI5myb/AzEmUkeIpsuWhc/Yo++aCYODTEseJ9NKB
         Y4uOP6MMkgCsGLarj4N9zG94+/JKmpjyNbEtM/J1VH7ZX5aevMhzSOHc7+SQ2idzwkQD
         AeSA==
X-Received: by 10.43.9.68 with SMTP id ov4mr3063922icb.22.1363081439576; Tue,
 12 Mar 2013 02:43:59 -0700 (PDT)
Received: by 10.64.166.33 with HTTP; Tue, 12 Mar 2013 02:43:39 -0700 (PDT)
In-Reply-To: <20130311170542.GB4167@sandbox-ub.fritz.box>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217939>

Heiko Voigt wrote:
> While talking about platform independence. How about Windows? AFAIK
> there are no file based sockets. How about using shared memory, thats
> available, instead? It would greatly reduce the needed porting effort.

What about the git credential helper: it uses UNIX sockets, no?  How
does git-credential-winstore [1] work?

[1]: https://github.com/anurse/git-credential-winstore
