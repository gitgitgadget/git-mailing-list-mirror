From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: What's cooking in git.git (Mar 2011, #04; Wed, 23)
Date: Thu, 24 Mar 2011 10:47:35 +0700
Message-ID: <AANLkTi=6vPmEGt7w=Er7nXDvv8Pr8NUwWg4hb08TyhPS@mail.gmail.com>
References: <7v62r9csqr.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 24 04:48:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q2bWw-0001JP-Ij
	for gcvg-git-2@lo.gmane.org; Thu, 24 Mar 2011 04:48:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933393Ab1CXDsI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 23 Mar 2011 23:48:08 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:53813 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932845Ab1CXDsH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Mar 2011 23:48:07 -0400
Received: by wya21 with SMTP id 21so8306533wya.19
        for <git@vger.kernel.org>; Wed, 23 Mar 2011 20:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=jslxVQWETRoDvSro2Y6ZrLbKeTHygeEft9DXyP59OCo=;
        b=d8O2n6F79RlI6PH30C3tKTCSv4Gg6BkS9TOB4gmBREhPLieqa3tnyGzy6PHTJ7e/pi
         mHN9yg+R/kwSTosJFpMW6x+Sur8P2H7/Zjq1dETS+6adw8o4FDlbzjPnHPargm8yJWgX
         VIYZqjuOfmNX942wBT37BURkDKgaUIV/X46HQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=RWc9/QZBB7v77FWzVH5TaNxeMHozOpfgRoyXmhzHD1cxJPYNFdCns57dbv2BANY3Gc
         /njw3luGrmVh3w55ZjumliQ9IC3RuHvCBHruPR1yXk7Mz5utS64NAsZfZGtrzU2IIIkj
         TU+0wAzQjsTaCCY8OTAaLGOKJHbS0VQmddxb0=
Received: by 10.216.243.195 with SMTP id k45mr7480983wer.66.1300938485121;
 Wed, 23 Mar 2011 20:48:05 -0700 (PDT)
Received: by 10.216.163.202 with HTTP; Wed, 23 Mar 2011 20:47:35 -0700 (PDT)
In-Reply-To: <7v62r9csqr.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169889>

On Thu, Mar 24, 2011 at 6:38 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Here are the topics that have been cooking. =C2=A0Commits prefixed wi=
th '-' are
> only in 'pu' while commits prefixed with '+' are in 'next'.

Out of curiosity, did you just miss the column output series I sent,
or any other reasons?

> * jc/add-u-migration (2011-03-22) 3 commits
> =C2=A0- add: make "add -u/-A" update full tree without pathspec (step=
 3)
> =C2=A0- add: make "add -u/-A" update full tree without pathspec (step=
 2)
> =C2=A0- add: make "add -u/-A" update full tree without pathspec
>
> The message in the bottom one really needs proofreading to move this =
topic
> forward. Of course, perhaps nobody cares enough (even though many peo=
ple
> seem to have complained about the current behaviour) and we may end u=
p
> discarding this topic. We'll see.

Please don't discard it. It's good enough for me. I did not proofread
the warning text, just the code, but I'm not that good at English
anyway.
--=20
Duy
