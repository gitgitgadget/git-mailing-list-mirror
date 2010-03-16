From: Mark Lodato <lodatom@gmail.com>
Subject: Re: FEATURE REQUEST: Comment assignment on branches
Date: Mon, 15 Mar 2010 20:35:03 -0400
Message-ID: <ca433831003151735u697c5e3fm431dd98bcf48f7bf@mail.gmail.com>
References: <be8f531d1003150133n3ea64109u7d573dbd533ffa48@mail.gmail.com> 
	<4B9EA22E.1010103@lsrfire.ath.cx> <7v3a01jmp9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	Maxim Treskin <zerthurd@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 16 01:35:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NrKkr-0006ii-Ko
	for gcvg-git-2@lo.gmane.org; Tue, 16 Mar 2010 01:35:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756259Ab0CPAfY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Mar 2010 20:35:24 -0400
Received: from mail-yw0-f176.google.com ([209.85.211.176]:56587 "EHLO
	mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754685Ab0CPAfX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Mar 2010 20:35:23 -0400
Received: by ywh6 with SMTP id 6so2092589ywh.16
        for <git@vger.kernel.org>; Mon, 15 Mar 2010 17:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=F7fYLVcQKafR0bKF315EtoI1W91QQqMneRJOH3KeP50=;
        b=lsqyfd2lxs+qw4SgSNmV2I6jzPTpG/Kd9QUEJdepmL8PFsMIhHauXDItBGpWy9g+ov
         qFCfyAOoLNiaCPEgC958prIiJ8c3+1MiWockVR5TcMX0KMzP5tXgW2NM8JrY22GqIAds
         MQygxNRGjbrJxIg11+RqsvwnELesXShyAQYBQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=T56bwiykvWvseDkwftLpFXZZjiy3dSBcaBcQIIAie7aMT9fYC/y6UQpoPMLo9qvrBw
         ZHBRS6O+P3TwQrch+wCkmxO7Ck9d3XF0a1Bh64rlKaXX9bW4Ccgs7U2CMyXRjNew2ckp
         D4IfeZI+poPqPvSK8bDHx2WcVgThJNUdGVGs0=
Received: by 10.91.51.37 with SMTP id d37mr1615205agk.65.1268699723081; Mon, 
	15 Mar 2010 17:35:23 -0700 (PDT)
In-Reply-To: <7v3a01jmp9.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142283>

On Mon, Mar 15, 2010 at 5:32 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
> Another thing to worry about is how "--comments" and "-v" would interact
> with each other.

What about putting the comment on the line below, with the same level
of indentation?

  maint    8fcaca3 don't use default revision if a rev was specified
           (preparation for the next maintenance release)
* master   c24138b Merge branch 'sd/format-patch-to'
           (preparation for the next feature release)
  next     0ae494e Merge branch 'pb/log-first-parent-p-m' into next
           (semi-stable test branch for integration into master)
