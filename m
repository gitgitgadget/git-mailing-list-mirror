From: BJ Hargrave <bj@bjhargrave.com>
Subject: Re: git-http-backend: hook output not delivered to client
Date: Sat, 6 Mar 2010 17:53:08 -0500
Message-ID: <25C95FB3-B827-46F1-9355-549BD6F2BC1E@bjhargrave.com>
References: <3C07BFC0-BC5E-4901-A846-A337B5F1B8F4@bjhargrave.com> <20100306223031.GG2529@spearce.org>
Mime-Version: 1.0 (Apple Message framework v1077)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Mar 07 00:00:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1No2zD-0001OQ-9c
	for gcvg-git-2@lo.gmane.org; Sun, 07 Mar 2010 00:00:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751641Ab0CFXAi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Mar 2010 18:00:38 -0500
Received: from mail-gx0-f217.google.com ([209.85.217.217]:42568 "EHLO
	mail-gx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750971Ab0CFXAi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Mar 2010 18:00:38 -0500
Received: by gxk9 with SMTP id 9so2620548gxk.8
        for <git@vger.kernel.org>; Sat, 06 Mar 2010 15:00:37 -0800 (PST)
Received: by 10.151.88.17 with SMTP id q17mr2584591ybl.193.1267915991538;
        Sat, 06 Mar 2010 14:53:11 -0800 (PST)
Received: from hargrave.hargrave.local (125.69.205.68.cfl.res.rr.com [68.205.69.125])
        by mx.google.com with ESMTPS id 21sm1151878ywh.17.2010.03.06.14.53.09
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 06 Mar 2010 14:53:10 -0800 (PST)
In-Reply-To: <20100306223031.GG2529@spearce.org>
X-Mailer: Apple Mail (2.1077)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141627>

Thanks for the quick feedback. I will keep my eye out for 1.7.0.2.

-- 

BJ Hargrave



On Mar 6, 2010, at 17:30 , Shawn O. Pearce wrote:

> BJ Hargrave <bj@bjhargrave.com> wrote:
>> I have compiled and installed git 1.7.0.1 on a RHEL4 box
> ... 
>> So the push properly fails in both cases because the hook exits
>> with a non-zero return code, but it seems there is a problem with
>> git-http-backend not ferrying the hook output messages back to
>> the client.
> 
> Yes, we know about this problem.
> 
> You need commit 466dbc42f5 ("receive-pack: Send internal errors over
> side-band #2") on both the client and the server for hook messages
> to work over HTTP.
> 
> This hasnt been released yet.  It is slated for 1.7.0.2.
> 
> -- 
> Shawn.
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
