From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [StGit PATCH] Test that we can add a new file to a non-topmost patch with refresh -p
Date: Fri, 25 Jul 2008 22:37:23 +0100
Message-ID: <b0943d9e0807251437u4c01fb45n98e1b0b29e9c4c78@mail.gmail.com>
References: <20080718084127.GA7042@diana.vm.bytemark.co.uk>
	 <20080718170225.10086.17504.stgit@yoghurt>
	 <20080718180109.GA14825@diana.vm.bytemark.co.uk>
	 <b0943d9e0807211501g68d1cffeh12bcb34df0f28dae@mail.gmail.com>
	 <20080722071438.GA16807@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, "Jon Smirl" <jonsmirl@gmail.com>
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
X-From: git-owner@vger.kernel.org Fri Jul 25 23:38:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMUzg-0006ZQ-UN
	for gcvg-git-2@gmane.org; Fri, 25 Jul 2008 23:38:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752136AbYGYVh1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 25 Jul 2008 17:37:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756501AbYGYVh0
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Jul 2008 17:37:26 -0400
Received: from wa-out-1112.google.com ([209.85.146.181]:42948 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756441AbYGYVhY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 25 Jul 2008 17:37:24 -0400
Received: by wa-out-1112.google.com with SMTP id j37so2183670waf.23
        for <git@vger.kernel.org>; Fri, 25 Jul 2008 14:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=1gTIdq0G5OADkGz20lZpPiRLJL09CZjApIOswZwNsV0=;
        b=C6UvzqAhRPsugXVfsA95QOj4VU9v09/kRsYIa7d1/bzz86GwnA+rqb5VZqn+yDMxdr
         78hKY5QqT6uobVtxrocdGdL08sM7jw7lex+Y/CDU7EH0a4y/hfc45X5efT7sgyiEquZU
         cYwzbcXuaVys3zm1s/e492AUvaukmb+TMXmCI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=Rio3hrnosIW+bLOTl8zGcZL0kf4zt06oTvdKUHCX8YBgK8pT9MhCtOtu2HCWukwPYI
         2wSqv6ac0MRqY9YowR7WgiYJ1oWu7EvbSHdceWZB+BkyWEUrteXpJkJXBoKnr1aHDUSG
         pv/ichMgekEfIMGLODmG+2gJFVARX0RJa17yY=
Received: by 10.114.24.1 with SMTP id 1mr2633370wax.74.1217021843714;
        Fri, 25 Jul 2008 14:37:23 -0700 (PDT)
Received: by 10.114.193.12 with HTTP; Fri, 25 Jul 2008 14:37:23 -0700 (PDT)
In-Reply-To: <20080722071438.GA16807@diana.vm.bytemark.co.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90119>

2008/7/22 Karl Hasselstr=F6m <kha@treskal.com>:
> On 2008-07-21 23:01:17 +0100, Catalin Marinas wrote:
>
>> I don't think we should spend time on fixing the current code as you
>> already have a new implementation. Maybe we could add a simple test
>> and refuse refreshing other than the topmost patch in case of files
>> added to the index.
>
> Yes, I guess that's OK. Hmm, how do we check that cheaply?

In the stable branch, we already call git.check_status() in the
refresh implementation, so it's pretty cheap to test.

--=20
Catalin
