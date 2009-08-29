From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: git clone http://git.savannah.gnu.org/cgit/xboard.git segfaults
Date: Sat, 29 Aug 2009 10:03:17 +0800
Message-ID: <be6fef0d0908281903x652909dfi729782e52528fead@mail.gmail.com>
References: <alpine.DEB.1.00.0908171620160.4991@intel-tinevez-2-302>
	 <20090817135651.GA4570@harikalardiyari>
	 <20090826202053.6e6442a6.rctay89@gmail.com>
	 <20090826131235.GF16486@harikalardiyari>
	 <be6fef0d0908281707o59fdb0c9h9a5a78864b6ad063@mail.gmail.com>
	 <7v8wh35tl8.fsf@alter.siamese.dyndns.org>
	 <7vprafzap3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Ali Polatel <polatel@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 29 04:05:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MhDJQ-0004ip-DO
	for gcvg-git-2@lo.gmane.org; Sat, 29 Aug 2009 04:05:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751232AbZH2CDQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 28 Aug 2009 22:03:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750882AbZH2CDQ
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Aug 2009 22:03:16 -0400
Received: from mail-iw0-f204.google.com ([209.85.223.204]:53403 "EHLO
	mail-iw0-f204.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750799AbZH2CDP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 28 Aug 2009 22:03:15 -0400
Received: by iwn42 with SMTP id 42so1128556iwn.33
        for <git@vger.kernel.org>; Fri, 28 Aug 2009 19:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=6Xb71qw82CvTarJYQBEX5BWn1P5NbLtfFXOVgH3Vb5c=;
        b=GufpPQ1iV+uWeq75ZUfG7LcblSsfVZL+PwHiLasRmNJbNXmkLpSP9+6yfuys4lMju3
         PlVlQ4D2le4IMy9x8Z2lxfv4jDCa9ixWOiE3Pv2TwDn9YQBQmJXfwYM+nLCOthj82Vf4
         9aIFynX7uKbcf+zA7hEDSviiMm7RXp2XegXEw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=MO+LB7Qv+e1BCO+4yOQJ1qx1BnqX23VbbOo7ENywshrWcA6LJAggOaNURI0mbP4t5b
         2OyIqWFZwIyzXi8Q3k76zkc0AnlzxU3EZ1cX9LOiL/FgfA3SOoSj5MsZulUQ8juoKoOb
         Y207vzj5NjgaOK2NOTojNqEidO5cakjc0+cLw=
Received: by 10.231.26.78 with SMTP id d14mr1178755ibc.30.1251511397328; Fri, 
	28 Aug 2009 19:03:17 -0700 (PDT)
In-Reply-To: <7vprafzap3.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127370>

Hi,

On Sat, Aug 29, 2009 at 9:10 AM, Junio C Hamano<gitster@pobox.com> wrot=
e:
> I forgot to add...
>
> In this case, it is _now_ clear to me that you consider your
>
> =A0 =A0Subject: Re: git clone http://git.... segfaults
> =A0 =A0To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> =A0 =A0Cc: Ali Polatel <polatel@gmail.com>, git@vger.kernel.org
> =A0 =A0Date: Wed, 26 Aug 2009 20:20:53 +0800
> =A0 =A0Message-ID: <20090826202053.6e6442a6.rctay89@gmail.com>
>
> to be the final version,

(I refer to this and your previous message) Thanks for taking the time
to explain the procedures/workflow involved. Yes, I thought Ali's
report on the patch was sufficient to flag the patch as
here-is-the-good one, but I didn't indicate this to you clearly
enough. Sorry for all the trouble.

> so I'd just add "noticed by Ali Polatel who later
> tested this patch to verify; Dscho helped to identify the problem spo=
t."
> at the end of the commit log message in the message and apply. =A0IOW=
, no
> need to resend.

Thanks again. Somehow, I neglected to include credits to Ali and Dscho.

--=20
Cheers,
Ray Chuan
