From: Stefano Lattarini <stefano.lattarini@gmail.com>
Subject: Re: [PATCH v4 09/14] remote-testgit: report success after an import
Date: Fri, 02 Nov 2012 17:23:25 +0100
Message-ID: <5093F37D.7070705@gmail.com>
References: <1351821738-17526-1-git-send-email-felipe.contreras@gmail.com> <1351821738-17526-10-git-send-email-felipe.contreras@gmail.com> <5093D193.3030108@gmail.com> <CAMP44s2ZPbda7yJ9UtOhWMqaKp4TaAgoyeUWUSrt0vco7RK+Tw@mail.gmail.com> <5093EFF4.5080308@gmail.com> <CAMP44s2T7iOdn6mWXqcUw97d8_-=pR=7ZQ5t_ygPGOphXW5cQw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Elijah Newren <newren@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 02 17:24:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TUK2J-0008C3-Ei
	for gcvg-git-2@plane.gmane.org; Fri, 02 Nov 2012 17:23:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759143Ab2KBQXd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Nov 2012 12:23:33 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:62767 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757663Ab2KBQXb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Nov 2012 12:23:31 -0400
Received: by mail-bk0-f46.google.com with SMTP id jk13so1446251bkc.19
        for <git@vger.kernel.org>; Fri, 02 Nov 2012 09:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:mime-version:to:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=P2r2vyAF1s6B89QHaW1/Dv7UKzf5MoGYXsRbdBwdChE=;
        b=t+9fvE33qTKfAQc1pbMuV+rxpZKTYwax5Y4rJg0Mm7JtFkxFpNC8KDPYnAHfv5AOeT
         kcdBo+2lvzPjI18cKwFgSTPrp2OekfeYskE/8EpBX9ohK9mVhHXPneYwLk5EcosCmv0E
         fFKvWg3K1vphxN/3OPTv/GvHXWmSrLlGgRGggcZJD6LU8RMjWnp0/xCDr9D5PX8r4K79
         nSzrdv2zG5kDt2davYzuKh0R0fcFasA9W41QX/OZaVCFfmmReR/ciyhXWxD4bMh67Y5g
         ltSui/rStAf5wOs4JTes1UBexSImPDpIwr/qKjdOHZx7S90iRlVHgNrgVeaTXbm/1b9L
         2Q6g==
Received: by 10.204.7.88 with SMTP id c24mr546438bkc.118.1351873409834;
        Fri, 02 Nov 2012 09:23:29 -0700 (PDT)
Received: from [192.168.178.21] (host247-100-dynamic.8-87-r.retail.telecomitalia.it. [87.8.100.247])
        by mx.google.com with ESMTPS id 1sm6952831bks.3.2012.11.02.09.23.28
        (version=SSLv3 cipher=OTHER);
        Fri, 02 Nov 2012 09:23:29 -0700 (PDT)
In-Reply-To: <CAMP44s2T7iOdn6mWXqcUw97d8_-=pR=7ZQ5t_ygPGOphXW5cQw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208961>

On 11/02/2012 05:19 PM, Felipe Contreras wrote:
>
> [SNIP]
>
> As things are the options are:
> 
> 1) Remove this code and move to POSIX sh. People looking for reference
> might scratch their heads as to why 'git push' is not showing the
> update.
> 2) Keep this code and remain in bash.
> 
> Until we have a:
> 
> 3) Replace this code with a clean POSIX sh alternative
> 
> I would rather vote for 2)
> 
That's perfectly fine with me, now that you've explained the rationale
for requiring bash in the first place (maybe adding a comment to the
script or the commit messages that reports this rationale for choosing
to require bash might be worthwhile; but it's no big deal anyway).

Thanks,
  Stefano
