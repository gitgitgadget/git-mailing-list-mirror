From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: Getting rid of a stale remote?
Date: Tue, 6 Apr 2010 23:37:40 +0530
Message-ID: <w2if3271551004061107rb25b83b9p19a284f19e7d4f87@mail.gmail.com>
References: <x2jc115fd3c1004061103z3154b6b3ge34493260f12925e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Tim Visher <tim.visher@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 06 20:08:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NzDC5-0004AZ-As
	for gcvg-git-2@lo.gmane.org; Tue, 06 Apr 2010 20:08:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757327Ab0DFSIF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 6 Apr 2010 14:08:05 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:61247 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755395Ab0DFSIB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 Apr 2010 14:08:01 -0400
Received: by gwb19 with SMTP id 19so63138gwb.19
        for <git@vger.kernel.org>; Tue, 06 Apr 2010 11:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:received:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=1PWvNl41n2PYt1uarJFcx/vQ+VLirKsKY6ZkKkrLmJw=;
        b=F1jVrEX1mpjyfaDFQf2vD2FDXaE1zhfgAKK4cwc0i64ynqpFOYlSDWQNVPwbUW8Pg4
         IfmlDfDB4TJkXeKpfd57HmQkGX3JzveLkU/pHx6rC5LPAUtXWsnrMQZ3ISNcuhhngn7M
         cFTVo0zl6Xehc6YHvPqwn1SMbvwVwcvNVfWX0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=XhOPAehHft++DSCK4nkT2A2jSSyCRZdHnHjT8DMQR+ztXAkiWXW48eq6dAlYng1lg2
         nF3rOB+Xt4GcdC9r1UwdgzWCisqAD6f16H8Z6I1JU6/d0JifjwqYoNOvNESm1W2nCZ2q
         cBZX6S1XsJLZ/k4u1wPs5BulgOw4O5fX7n/5w=
Received: by 10.90.69.14 with HTTP; Tue, 6 Apr 2010 11:07:40 -0700 (PDT)
In-Reply-To: <x2jc115fd3c1004061103z3154b6b3ge34493260f12925e@mail.gmail.com>
Received: by 10.91.50.34 with SMTP id c34mr2267222agk.44.1270577280253; Tue, 
	06 Apr 2010 11:08:00 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144163>

> I'm trying to get rid of a stale remote. =A0I deleted the remote via
> `git remote rm <remote>` and that removed it from .git/config but for
> some reason the references stayed in the listing of `git branch -a`.

See `git remote prune`.

-- Ram
