From: Paul Tan <pyokagan@gmail.com>
Subject: Re: [PATCH] pull.sh: quote $upload_pack when passing it to git-fetch
Date: Fri, 31 Jul 2015 19:01:03 +0800
Message-ID: <CACRoPnR5z95xGNgcPThnGO1KfftcETBprs8HyeskroXGD4ZPgw@mail.gmail.com>
References: <CAPc5daXPY7RQSM6oyFYJ2LjYjaT9dDG-+3=nbHONirGh50pdBA@mail.gmail.com>
	<1438288803-17953-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Joey Hess <id@joeyh.name>
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Fri Jul 31 13:01:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZL83v-0005Ug-PW
	for gcvg-git-2@plane.gmane.org; Fri, 31 Jul 2015 13:01:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751912AbbGaLBI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Jul 2015 07:01:08 -0400
Received: from mail-la0-f48.google.com ([209.85.215.48]:35112 "EHLO
	mail-la0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751361AbbGaLBF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Jul 2015 07:01:05 -0400
Received: by lacct8 with SMTP id ct8so8640956lac.2
        for <git@vger.kernel.org>; Fri, 31 Jul 2015 04:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=4+FR4GjLCuTFdnXhT+snELe6gkHUFcJrqfJJBaULF3M=;
        b=lYe3MeFcflpaUa6YZWYXUYsHMHTOPxjzixieUZmLGFazK4+i/5Pc7o2oB3nugk8eMC
         Tp1uQqeSxJ19vrKmeXRKn9NIpIwBHsWiMxuRFcKP/qoyYoBeNp9sg1et71MzJFcVjAeu
         UOqD/+OG61RGsmEejpM2gifz15j/qeErB/ZzL5Iob8UVlO2AwsaZt3eqOGEI0Iq9D7X2
         FOdIr3ANsjYD2WZIsFwFF6FKd80PYjpVc7gAbxKsE4HUm3SditSmCeYhVIatKZgLy1HF
         zJTrIEDqZ35LGExK2EwYw4IXi3kgL8E1KIuB3h2QLlpbThbnpQGjacH/tC184fasrj2s
         pBlQ==
X-Received: by 10.152.3.199 with SMTP id e7mr2121569lae.98.1438340463798; Fri,
 31 Jul 2015 04:01:03 -0700 (PDT)
Received: by 10.112.62.196 with HTTP; Fri, 31 Jul 2015 04:01:03 -0700 (PDT)
In-Reply-To: <1438288803-17953-1-git-send-email-Matthieu.Moy@imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275045>

On Fri, Jul 31, 2015 at 4:40 AM, Matthieu Moy <Matthieu.Moy@imag.fr> wrote:
> The previous code broke for example
>
>   git pull --upload-pack 'echo --foo'
>
> Reported-by: Joey Hess <id@joeyh.name>
> Fix-suggested-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>

Thanks for cleaning up my mess! ><

Regards,
Paul
