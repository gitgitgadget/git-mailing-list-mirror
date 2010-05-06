From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Bizarre behavior on git commit
Date: Wed, 5 May 2010 23:57:26 -0500
Message-ID: <20100506045726.GA27055@progeny.tock>
References: <s2t6f5a4e781005042246sb9ef3d48j134b22b5b41133ed@mail.gmail.com>
 <20100505060110.GA21260@progeny.tock>
 <n2m6f5a4e781005052032sf47733ebwf490e0369bebd03f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Dan Loewenherz <dloewenherz@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 06 06:57:07 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O9t8z-0004A8-92
	for gcvg-git-2@lo.gmane.org; Thu, 06 May 2010 06:57:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751442Ab0EFE45 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 6 May 2010 00:56:57 -0400
Received: from mail-iw0-f197.google.com ([209.85.223.197]:61011 "EHLO
	mail-iw0-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750962Ab0EFE44 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 May 2010 00:56:56 -0400
Received: by iwn35 with SMTP id 35so7430885iwn.21
        for <git@vger.kernel.org>; Wed, 05 May 2010 21:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=vvqQjGxpxYa8QxnqlrJ1y4jyd159Jy+kS1Q8yCb3yOs=;
        b=tjcIY0qf2J3k3uvvVR14m005TrMKWR1XhX72ymsti58dvS3zLy+iRponQ0BTIrDPUf
         OvvM2D55aRy6jo0alFvO2E1Hc5m8Q55ic8g4Xhyj3AW30vbpsgAhdE29DZtdjFnfe1+G
         vfOwf2rVWrRn01jEypzFXJomKY59ej0bENzPo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=RfffPF8C8RpI3bfIekx1bZ2b7QQilRhsWX3L390YHrf9cr751wGpu8iYIIMaLk3+Vy
         JrXm2PO7DdoISNH+4FQYUa7QJeXdHOZbB8t1aH7D/fznhAsdDkaq94lh7aNR/s7rleQe
         LMg/HVu5mseWR/4kHQ7158/GoazhH2npsCbNQ=
Received: by 10.231.145.146 with SMTP id d18mr792892ibv.16.1273121815484;
        Wed, 05 May 2010 21:56:55 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 20sm459532iwn.5.2010.05.05.21.56.53
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 05 May 2010 21:56:54 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <n2m6f5a4e781005052032sf47733ebwf490e0369bebd03f@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146435>

Dan Loewenherz wrote:
>> Dan Loewenherz wrote:

>>> $ git commit -m "my commit message"
>>> usage: git show-ref [-q|--quiet] [--verify] [--head]
[...]
> The GIT_TRACE helped--it was a hook script. The script's been in my
> local repo for quite a while, strange that it only started having thi=
s
> behavior recently.

My bad.

$ git show -s v1.6.6-rc0~34^2~17
[...]
    Does anybody use "show-ref -h"?  It was in Linus's original, most
    likely only because "it might be handy", not because "the command
    should not show the HEAD by default for such and such reasons".
    So I think it is okay if "show-ref -h" (but not "show-ref
    --head") gives help and exits.
   =20
    If a current script uses "git show-ref -h" without any other
    arguments, it would have to be adapted by changing "-h" to
    "--head".
   =20
    Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
    Signed-off-by: Junio C Hamano <gitster@pobox.com>

I was too dense to notice the connection until just now.

> Removed the script and all works normally.

If you still have the script, I would be happy to look it over, for
curiosity=E2=80=99s sake.

Cheers,
Jonathan
