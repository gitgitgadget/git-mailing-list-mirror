From: John Szakmeister <john@szakmeister.net>
Subject: Re: The imporantance of including http credential caching in 1.7.7
Date: Fri, 9 Sep 2011 06:32:25 -0400
Message-ID: <CAEBDL5VtVZcmQnj2CH7XzZ0YV_X61gO69-dXriGiYsAqk=NLPg@mail.gmail.com>
References: <CAFcyEthzW1AY4uXgpsVxjyWCDXAJ6=GdWGqLFO6Acm1ovJJVaw@mail.gmail.com>
	<4E6769E3.4070003@drmicha.warpmail.net>
	<20110908191053.GA16064@sigill.intra.peff.net>
	<4E69C8F0.9070204@drmicha.warpmail.net>
	<87pqjaxbrm.fsf@lifelogs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Kyle Neath <kneath@gmail.com>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 09 12:32:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R1yNt-00054W-GP
	for gcvg-git-2@lo.gmane.org; Fri, 09 Sep 2011 12:32:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758729Ab1IIKc1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Sep 2011 06:32:27 -0400
Received: from mail-vw0-f43.google.com ([209.85.212.43]:60517 "EHLO
	mail-vw0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758411Ab1IIKc0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Sep 2011 06:32:26 -0400
Received: by vws10 with SMTP id 10so1217109vws.2
        for <git@vger.kernel.org>; Fri, 09 Sep 2011 03:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=Abvm2AVyqfIIb23ak0dfZn98yWs4xl1Qj/iJdB6CRdY=;
        b=qWAAiRcLva+koBn4zXP/fJQ21g2Uy7Du5R9LByMaHV/ayPcjTP942O2pk9wpaRO7KC
         +Nf16UmEIs20Tjp/wPk0BNzyMXS5SgSweFyy6NsP1jwiWGE+iQ/7BGpR0RcbuDe8nw4B
         71mbxXdmkTw7QG/M1lsGUj7hiME2456HyJRfE=
Received: by 10.52.38.99 with SMTP id f3mr201723vdk.392.1315564345908; Fri, 09
 Sep 2011 03:32:25 -0700 (PDT)
Received: by 10.52.160.196 with HTTP; Fri, 9 Sep 2011 03:32:25 -0700 (PDT)
In-Reply-To: <87pqjaxbrm.fsf@lifelogs.com>
X-Google-Sender-Auth: YFfvg3-KIkX40ODlALG6HSHCbiU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181045>

[Added back some of the CC's]

Ted: we don't usually cull the CC list on the git mailing list.

2011/9/9 Ted Zlatanov <tzz@lifelogs.com>:
[snip]
> MJG> ... and one for Git on Windows? It seems we're lacking both Win and OS X
> MJG> developers here.
>
> Windows doesn't have a standard keychain service, does it?

No, it doesn't, but you can use the wincrypt API which allows you to
at least encrypt the password from the user's login credentials.  In
particular, CryptProtectData() and CryptUnprotectData().  That way you
can at least have the password stored encrypted on disk.

-John
