From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v5 1/3] test: use unambigous leading path (/foo) for MSYS
Date: Mon, 14 Oct 2013 15:40:59 -0400
Message-ID: <CAPig+cT+TQoO6tS-bbzstVbJSw=+B=_pbGzHo20+86+RCvf39w@mail.gmail.com>
References: <52570EC8.3050207@gmail.com>
	<cover.1381717700.git.worldhello.net@gmail.com>
	<4a078e41976b25488571b1478a51e287ffdd55c8.1381717700.git.worldhello.net@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Git List <git@vger.kernel.org>,
	Sebastian Schuberth <sschuberth@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j6t@kdbg.org>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 14 21:41:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VVo0t-0002V0-Ps
	for gcvg-git-2@plane.gmane.org; Mon, 14 Oct 2013 21:41:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757366Ab3JNTlE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Oct 2013 15:41:04 -0400
Received: from mail-la0-f47.google.com ([209.85.215.47]:48168 "EHLO
	mail-la0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756906Ab3JNTlB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Oct 2013 15:41:01 -0400
Received: by mail-la0-f47.google.com with SMTP id eo20so6083126lab.34
        for <git@vger.kernel.org>; Mon, 14 Oct 2013 12:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=IRO9MdpJVK831ujF8X65JBNZr6BROK5cSAr69H5qXAk=;
        b=P6Ewez/sDhMBBxS4Ve+ojL6+x/LUXejEemmspOwlJOKj4TeaMKF6dfDzLnGRWjdSxm
         KpPuZ1vk3ONLA73rTzNWj9n8on7VYP1N8a4LqpTYqz7rjwbyNzq22xId+9Fx03hHvi1g
         UxsrnUdXuBmOTG0TrWstRuzp1w0sBx0Pf5jH+XIaiOUOscStagwSeBuQgDGUxURVwoIK
         XRBNOxcdjgYRJYUIVgb62tMyq0h1eUnoBqIDwEPP3c3bVg9iCwl6vEc1aK/slCw7vU7i
         9Km14jSpb87TgeSSwrqvnYfYmSrqGF7p26QlLDLfP+nBWU9vEy+GwYXIoIyTm7LHWdD8
         UbCA==
X-Received: by 10.112.128.166 with SMTP id np6mr32070629lbb.7.1381779659941;
 Mon, 14 Oct 2013 12:40:59 -0700 (PDT)
Received: by 10.114.182.236 with HTTP; Mon, 14 Oct 2013 12:40:59 -0700 (PDT)
In-Reply-To: <4a078e41976b25488571b1478a51e287ffdd55c8.1381717700.git.worldhello.net@gmail.com>
X-Google-Sender-Auth: CbhrhT9yeRLqsv53tNzu3yx7iOc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236115>

On Sun, Oct 13, 2013 at 10:29 PM, Jiang Xin <worldhello.net@gmail.com> wrote:
> In test cases for relative_path, path with one leading character
> (such as /a, /x) may be recogonized as "a:/" or "x:/" if there is
> such DOS drive on MSYS platform. Use an umambigous leading path
> "/foo" instead.
>
> Also change two leading slashes (//) to three leading slashes (///),
> otherwize it will be recognized as UNC name on MSYS platform.

s/otherwize/otherwise/

> Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
