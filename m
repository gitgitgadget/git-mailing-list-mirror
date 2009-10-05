From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH/RFC] builtin-checkout: suggest creating local branch when 
	appropriate to do so
Date: Mon, 5 Oct 2009 23:26:39 +0200
Message-ID: <fabb9a1e0910051426n7f4f8602l8fad733ac3ba82b3@mail.gmail.com>
References: <1254775583-49452-1-git-send-email-jaysoffian@gmail.com> 
	<alpine.DEB.1.00.0910052314580.4985@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Oct 05 23:32:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Muv9u-0000SI-L1
	for gcvg-git-2@lo.gmane.org; Mon, 05 Oct 2009 23:31:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754875AbZJEV1i convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 5 Oct 2009 17:27:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753681AbZJEV1h
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Oct 2009 17:27:37 -0400
Received: from mail-ew0-f225.google.com ([209.85.219.225]:63088 "EHLO
	mail-ew0-f225.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754105AbZJEV1h convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 Oct 2009 17:27:37 -0400
Received: by ewy25 with SMTP id 25so3099475ewy.21
        for <git@vger.kernel.org>; Mon, 05 Oct 2009 14:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=hwCzj5dQyPvt6wIilRQ4QUxYmRTRaVHdY6wU4SPDOI8=;
        b=AWTFlQAAViNIMR6cQwqHlSLEvYqut5njPBezQgKk1PmUV1NQMN5nq7C9kQ8BCDJiqR
         2T5LIyDcmgVhTxiw20nG825DbeZS7HcInJFx7DRJmd8ornq7ETFd7N31ZozfD0FHbD/M
         seG+fSIzqw7uFVx+mALkiw7JqFYgl42YuSEHE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=i7TChaiqmpBmu062Vj03hP9+6XSPy6JTluf4so1kv1Iv5GJ0VsexAv1orfra8Ip+tj
         7ZA0nL18//tA7RTlfSDbm+yFROHoMqVX9Gbqr46wgKzH+MBKAE22hM6/vwXGzGinRb13
         oTy+UM0PK4DXxywA4uHuzQmcsR3mAoh52tvrM=
Received: by 10.216.85.133 with SMTP id u5mr108697wee.91.1254778019449; Mon, 
	05 Oct 2009 14:26:59 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0910052314580.4985@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129596>

Heya,

On Mon, Oct 5, 2009 at 23:17, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Actually, we should really think long and hard why we should not
> automatically check out the local branch "next" in that case. =A0I me=
an,
> really long and hard, and making sure to take user-friendliness into
> account at least as much as simplicity of implementation.

If git was a little more interactive I'd say prompt the user, problem s=
olved?

$ git checkout next
No such branch 'next', do you want to check out a local branch for
'origin/next' instead? [Y/n]

@jay: you assume that if there is more than one matching remote the
user is experienced (as they have multiple remotes) enough to know
what to do?

--=20
Cheers,

Sverre Rabbelier
