From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 00/12] Support columinized output in tag/branch/ls-files/grep
Date: Wed, 10 Mar 2010 19:12:23 +0700
Message-ID: <fcaeb9bf1003100412x7c08a312o4df114f91ebd7e8c@mail.gmail.com>
References: <1267963785-473-1-git-send-email-pclouds@gmail.com>
	 <4B9504C9.5000703@lsrfire.ath.cx>
	 <fcaeb9bf1003080632o622c8c79x85b816edcf893bc3@mail.gmail.com>
	 <4B967C36.90309@lsrfire.ath.cx>
	 <fcaeb9bf1003091627p65ad6e60u4bbae2eb4e859f13@mail.gmail.com>
	 <4B974998.5030708@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Mar 10 13:12:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NpKm8-0003PI-CM
	for gcvg-git-2@lo.gmane.org; Wed, 10 Mar 2010 13:12:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751354Ab0CJMM1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 10 Mar 2010 07:12:27 -0500
Received: from mail-yx0-f200.google.com ([209.85.210.200]:51078 "EHLO
	mail-yx0-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751090Ab0CJMMZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 Mar 2010 07:12:25 -0500
Received: by yxe38 with SMTP id 38so1538021yxe.22
        for <git@vger.kernel.org>; Wed, 10 Mar 2010 04:12:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Z9iO+3CnyUR8y8DNmG7EwKVekvjMIHeEqt+1bkpAfnQ=;
        b=vfreqakC3eLmREBRdMJWAqMLowYVr73QdiXp9sVG3In2KHOfXYsdWyQU+XJljMrF7W
         aqCVcVcTMnV9jWkVIPxDQOE9zGIk1xKgJ30Tsyo3VvEhEf4YH87lHT9mcnPIAHSUYEQd
         xPZyDcqp3lTK8e5124m6QIC7rwS9A7/vB/HP8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=ip8i8s+Q7viw0huDMO4JX12np94AYQ0W61JHcuE2UK8XEHZwbkKmg54uED2Yg40oUW
         1gLsB513t1lNZ1DN4WXpv04c0Yc9yaGdqtgFvCip523LJwJLHLcFikwxJ7oUhJjR8EhO
         WTY2F609s9i98eWnhfCIlKXwyyBkKJqhke/6Q=
Received: by 10.100.70.17 with SMTP id s17mr2124606ana.135.1268223143932; Wed, 
	10 Mar 2010 04:12:23 -0800 (PST)
In-Reply-To: <4B974998.5030708@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141874>

On 3/10/10, Johannes Sixt <j.sixt@viscovery.net> wrote:
> Nguyen Thai Ngoc Duy schrieb:
>
> > On 3/9/10, Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> wrote:
>
> >> OK, forking out is easy, but replacing printf() calls with calls t=
o feed
>  >>  the columnizer shouldn't be _that_ intrusive, either.
>  >
>  > Well, also fwrite() and write(). If disliked "if (blah) feed_it();
>  > else printf(as normal);" construct. But we can wrap it to
>  > feed_or_printf().
>
>
> How about merging this into color_fprintf and friends?

Good idea.
--=20
Duy
