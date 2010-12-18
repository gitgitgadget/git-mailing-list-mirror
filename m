From: Mark Lodato <lodatom@gmail.com>
Subject: Re: [PATCHv2 0/8] docs: use metavariables consistently
Date: Sat, 18 Dec 2010 11:45:11 -0500
Message-ID: <AANLkTi=vj=9-JO9QCb52qJin3Ezoi7WO_uoZaoX=ZEfY@mail.gmail.com>
References: <1292650725-21149-1-git-send-email-lodatom@gmail.com> <20101218084908.GE6187@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 18 17:45:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PTzud-0001vN-CK
	for gcvg-git-2@lo.gmane.org; Sat, 18 Dec 2010 17:45:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756633Ab0LRQpd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 18 Dec 2010 11:45:33 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:41653 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754621Ab0LRQpd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 18 Dec 2010 11:45:33 -0500
Received: by iwn9 with SMTP id 9so1781582iwn.19
        for <git@vger.kernel.org>; Sat, 18 Dec 2010 08:45:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=GIG6NkmmV8qXiKrMT/6/fmsCqFUF1osAPLJbSn65cMc=;
        b=U5YYKJlUnQJ8ggd38MijwEBiFUMrjtz1taf4WNl8NOD+xExtgpN3jqa5LY/5tksmG0
         N7Jmkb237vD984yJARjKZb35/SYFT3K2+Zn3qUHNIBpZIxrpYnmljsdsTRzdUAdIExs7
         YkY28J+LHS+qxDfb1wUa7YS4fiI35OaiKwFi8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=Zzqg60nbi1HtypgcaDWY5zFYrNo9wZLvv33hI6au0vzdkEgc6aBT9ONqtVZf30i4lf
         M5FK74kI/z39sqQwmR+6oqa6mOBrMuz2VkK4V+mr1sUYGWwc66w0knpQph7lJhl0X9Xj
         +90BdyPloEOWqOy11We4+JGHlSjDHVfUaCyL8=
Received: by 10.42.224.2 with SMTP id im2mr717627icb.53.1292690731770; Sat, 18
 Dec 2010 08:45:31 -0800 (PST)
Received: by 10.42.167.201 with HTTP; Sat, 18 Dec 2010 08:45:11 -0800 (PST)
In-Reply-To: <20101218084908.GE6187@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163923>

On Sat, Dec 18, 2010 at 3:49 AM, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
> Mark Lodato wrote:
>> This is a rework of my earlier patch set from March [1], with the fo=
llowing
>> differences:
>>
>> - Drop the patch to commit-tree that makes it accept a tree-ish.
>
> Ah, missed this before. =C2=A0It is not clear to me why this differen=
ce ---
> is it just to be conservative about changing behavior?

Exactly.  Junio replied to my original email saying he did not think
this patch was unsafe, so if you think the patch is a good idea, I'll
re-send it.

>> [1] http://kerneltrap.org/mailarchive/git/2010/3/13/25484
> http://thread.gmane.org/gmane.comp.version-control.git/142078

As an aside, how do you actually find threads on gmane?  I can't find
anything on Google.
