From: Max Kirillov <max@max630.net>
Subject: Re: [RFC] add detached HEAD to --all listing
Date: Wed, 27 Aug 2014 17:33:00 +0300
Message-ID: <CAF7_NFRz6Zc-wTDSFdkW4N2wRATZ8-g05j6sFu1t7DB0X72dkg@mail.gmail.com>
References: <CAF7_NFRKzU0_5Eq4kgtW3RChW3z5q8QBjWvvN+TSyOhORkf8hQ@mail.gmail.com>
	<20140827142249.GC31879@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>, Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Wed Aug 27 16:33:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XMeHe-000096-3D
	for gcvg-git-2@plane.gmane.org; Wed, 27 Aug 2014 16:33:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934748AbaH0OdE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2014 10:33:04 -0400
Received: from mail-wg0-f49.google.com ([74.125.82.49]:64536 "EHLO
	mail-wg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933802AbaH0OdD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2014 10:33:03 -0400
Received: by mail-wg0-f49.google.com with SMTP id k14so315122wgh.8
        for <git@vger.kernel.org>; Wed, 27 Aug 2014 07:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=VeY7SDjXyjsSZyybtFiDdMfba8BcNAZZMILSe9zEb5U=;
        b=UK2CDQ2aPsV6WksGzDZdxzCTA8jv6rVUrT5jW9wzn/PBJ+thd7TcItraXnnTbWnPO6
         Z6Io0cfaiiYC+jkb5BQsk7T5gZphPmmD66d3MPT3m8xObBDl9QF9ggtoR/7h761fJ6iz
         aiup8WuGLoh6joAmqZc5aCuM6K69w/aNe7GajOqN1riOhtWu782Eq0c/nPNX/sTLvuad
         0235MI+KgDWoo/qy0yLUBdHLE80gCLPGt5+US60eTcysNoV89eOROhYH2bOMFjqd4Luj
         evxhVIV3z1aOoDsIIBFpRY14iOhyiSRQKnocSsIJLHNeTeQoYCHH6jTjKbYCL5pP7dWn
         vnTQ==
X-Received: by 10.180.36.236 with SMTP id t12mr22934583wij.38.1409149981060;
 Wed, 27 Aug 2014 07:33:01 -0700 (PDT)
Received: by 10.180.9.170 with HTTP; Wed, 27 Aug 2014 07:33:00 -0700 (PDT)
In-Reply-To: <20140827142249.GC31879@peff.net>
X-Google-Sender-Auth: aCHasPiTZ6fSnAcEEyqvarMxavo
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255999>

On Wed, Aug 27, 2014 at 5:22 PM, Jeff King <peff@peff.net> wrote:
> If you mean "git log", I think it is included there, too:
>
>   $ git log --decorate --oneline --all
>   685450f (HEAD) more
>   1290ebd (master) foo

I meant "git log", did not know it's there. Where I actually would
like to see it in gitk --all, apparently it performs its own
filtering.

Thanks.

-- 
Max
