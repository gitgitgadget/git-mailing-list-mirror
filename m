From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] improve doc heading for git-bisect
Date: Sat, 07 Jun 2008 02:22:14 -0700 (PDT)
Message-ID: <m37id1y4zj.fsf@localhost.localdomain>
References: <20080607070637.79B17C7C0E@rwavmlap>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: rwa000@gmail.com (Robert Anderson)
X-From: git-owner@vger.kernel.org Sat Jun 07 11:23:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4udj-0006AP-FQ
	for gcvg-git-2@gmane.org; Sat, 07 Jun 2008 11:23:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753978AbYFGJWT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Jun 2008 05:22:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754452AbYFGJWS
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Jun 2008 05:22:18 -0400
Received: from fg-out-1718.google.com ([72.14.220.158]:44072 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753869AbYFGJWS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Jun 2008 05:22:18 -0400
Received: by fg-out-1718.google.com with SMTP id 19so916626fgg.17
        for <git@vger.kernel.org>; Sat, 07 Jun 2008 02:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=SbZjNVP8Nf5D15osiVLN8PUgghAyd4HtTRGt69wT1zY=;
        b=eapMVJy5ZuNantpezbOlr2YxvxN2FZ64No7gehHT1WrIUZOrWd11hiZP/zo+EyUjyU
         TxUORMEm/qQUfaq950wFks5zLKJ+J49O04Z0Q9poFEEHAicETF9uWbOfZuS3Xtxf5bfy
         nMvMTiRF/kpoO30gbaA87RFYkUeHeFdyiCL48=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=mQVT+HaRjj4OS3u1DVzne3TRaVXVhHnEhOlmpJq0577Z2FypvmjufgoJv/5cxxdrtZ
         YqGokxjVrOkDZCg9nLPSw8TCD22yLKl2coVGnQAyeRqplkpzjKKRsQVzLGURcB7NxIHW
         3TpmnFUqxHJFjNnrPRl+esF0bKgCwpqPiFoGs=
Received: by 10.78.194.8 with SMTP id r8mr470203huf.88.1212830536123;
        Sat, 07 Jun 2008 02:22:16 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.218.155])
        by mx.google.com with ESMTPS id 11sm6711271hug.62.2008.06.07.02.22.13
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 07 Jun 2008 02:22:14 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m579MAM4031728;
	Sat, 7 Jun 2008 11:22:10 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m579M8RS031724;
	Sat, 7 Jun 2008 11:22:08 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20080607070637.79B17C7C0E@rwavmlap>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84192>

rwa000@gmail.com (Robert Anderson) writes:

> From 7af03a835b7311c501f2147e25f428642fc3acb7 Mon Sep 17 00:00:00 2001

FYI this line is not necessary, and should be removed from
git-format-patch output when pasting it to your MUA.

> From: Robert W. Anderson <rwa000@gmail.com>
> Date: Fri, 6 Jun 2008 23:53:37 -0700
> Subject: [PATCH] improve doc heading for git-bisect

FYI the above isn't strictly necessary: if you have 'From:' header set
correctly you can simply set subject of email, and put in body the
rest of commit message and patch only, without extra mail-like
headers.

> Improve awkward heading in git-bisect documentation.
[...]
> -Avoiding to test a commit
> -~~~~~~~~~~~~~~~~~~~~~~~~~
> +Changing the revision to test
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>  
>  If in a middle of bisect session, you know what the bisect suggested
>  to try next is not a good one to test (e.g. the change the commit

It is, I guess, better, but is it the best heading?  What we want to
describe here is how to deal when bisect stops on commit which cannot
be tested (e.g. project does not compile).

-- 
Jakub Narebski
Poland
ShadeHawk on #git
