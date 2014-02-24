From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] remote: handle pushremote config in any order order
Date: Mon, 24 Feb 2014 17:45:52 -0500
Message-ID: <CALkWK0kVavvJDgn0_YdqexpUP=pAhbPAooXWjcYxNf5fxMyiVQ@mail.gmail.com>
References: <CAMYxyaUwPXXdvGv786_p5n7-biMLOFbur-gQ1pxXOttc0R0=eg@mail.gmail.com>
 <20140224085903.GA10698@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jack Nagel <jacknagel@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 24 23:46:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WI4II-0004tO-8s
	for gcvg-git-2@plane.gmane.org; Mon, 24 Feb 2014 23:46:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752799AbaBXWqe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Feb 2014 17:46:34 -0500
Received: from mail-ig0-f177.google.com ([209.85.213.177]:45796 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752464AbaBXWqd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Feb 2014 17:46:33 -0500
Received: by mail-ig0-f177.google.com with SMTP id h3so5931903igd.4
        for <git@vger.kernel.org>; Mon, 24 Feb 2014 14:46:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=IVHTCbvjhAT/noXnl6YesfLsmTM2w0VmvLM0GwJQb/Q=;
        b=KFND2S0x4nVDk3/2WLfUh50Sq490IiXJHI++R+7CKqSHLQ0OLM04FTxBnIujY1+lqE
         lUltW3XSKDg4w/Mr6XXbS/lgs7kDChc1pNyYeckWXQr51ZwJfgu+7dKo2zjewEC3+ZgO
         MnZoLZx12xvcAA3dIVrx6sueHp52iInt/1FDxSEVyqeFzCMclbPBUB47nU3SUZJPJeCK
         03GSkoUS6DBKCg8HE6USNyuomCbwGMnjCvHH/8rYVf6El+BuretxCZXUE06va1oNxjMJ
         LjByAU9VZ3Qs6oy1fxZih7EaTFsqc/a+cfCyNZb+lN8po03cPB/UsRvoIbRiQ/Ej7V3O
         MCOg==
X-Received: by 10.50.3.9 with SMTP id 9mr16450759igy.16.1393281992576; Mon, 24
 Feb 2014 14:46:32 -0800 (PST)
Received: by 10.64.10.42 with HTTP; Mon, 24 Feb 2014 14:45:52 -0800 (PST)
In-Reply-To: <20140224085903.GA10698@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242651>

Jeff King wrote:
> Thus, config like:
>
>   [branch "master"]
>   pushremote = foo
>   [remote]
>   pushdefault = bar
>
> erroneously ends up pushing to "bar" from the master branch.

Oh, ouch. Thanks for fixing this.
