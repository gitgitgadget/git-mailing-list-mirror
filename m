From: Dylan Reid <dgreid@gmail.com>
Subject: Re: [PATCH] blame: can specify shas of commits to ignore on command 
	line
Date: Tue, 4 May 2010 19:08:56 -0400
Message-ID: <z2lfd211a421005041608n1e302cbbt1bb628e9b51b3e3@mail.gmail.com>
References: <1272939687-17686-1-git-send-email-dgreid@gmail.com>
	 <4BE0918C.9090204@lsrfire.ath.cx>
	 <j2sfd211a421005041446ub9c2247ai484c2473df856b31@mail.gmail.com>
	 <7vtyqnl19w.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 05 01:09:07 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O9REg-0003zM-Ds
	for gcvg-git-2@lo.gmane.org; Wed, 05 May 2010 01:09:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934579Ab0EDXI7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 4 May 2010 19:08:59 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:33506 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934571Ab0EDXI7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 May 2010 19:08:59 -0400
Received: by gwj19 with SMTP id 19so1896019gwj.19
        for <git@vger.kernel.org>; Tue, 04 May 2010 16:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=QYxUX41JxuuMSkVYEt162ZHJODt83/7EDgK5SUNI6lA=;
        b=cdZUoNoxQUxCWmr1Xfs4S1dvu3HQcVPmtCnjkBu9vFKbLDvT7+AEdsxSgsDKYlmx5J
         lHC6AqLHQqFuWaCIoumoJo7ZeG6heel0UF39x8yg16vzSFJNu5nXA+Na/xH9dybfxgN3
         I7lU4gkICZilKd9q6aBCVcPvaA92OsgJoBi9w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=sscb6QkahSpqEP24jrN/RxtOruTMB4fx/67NBZjD7d1omXnfhvl4FwkE1mbobDQdhA
         Jn72YcW/GPhHoS8UiW2KlWZ6fNWsp6hT6d5/KGYgHqyp+Hb/Djw/OowCU1j+lcaIMA1h
         XovQCjyDKLKqkCVvELQZnddPcyl+F4G4kvEVo=
Received: by 10.150.128.7 with SMTP id a7mr12360137ybd.230.1273014536732; Tue, 
	04 May 2010 16:08:56 -0700 (PDT)
Received: by 10.150.145.11 with HTTP; Tue, 4 May 2010 16:08:56 -0700 (PDT)
In-Reply-To: <7vtyqnl19w.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146356>

> I am already confused. =A0If the command must return C when you say "=
ignore
> C" and C introduced a line you are interested in, then what is the po=
int
> of specifying commits to be ignored?
>

I was thinking that it would ignore changed lines, not added lines.  Ma=
ke sense?
