From: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
Subject: Re: git bisect code 125 - "WFT?"
Date: Wed, 16 Mar 2011 23:06:32 +0100
Message-ID: <AANLkTikRttGnxex1CYSQnSg4PgctFj0-qNjf5un+fL0W@mail.gmail.com>
References: <AANLkTikZ3Po-YdhO-qCn5usVkt4J196eFF6YdbAeMG_X@mail.gmail.com>
	<7v1v267no9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git Mailing List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 16 23:06:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PzyrX-0006zN-55
	for gcvg-git-2@lo.gmane.org; Wed, 16 Mar 2011 23:06:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752077Ab1CPWGe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Mar 2011 18:06:34 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:37347 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751859Ab1CPWGd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Mar 2011 18:06:33 -0400
Received: by vws1 with SMTP id 1so2233307vws.19
        for <git@vger.kernel.org>; Wed, 16 Mar 2011 15:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=7fvB1CDjF2LAStb5d4LGepc9NgwUXS4rwlwXC5Nz8Pk=;
        b=rJbRP30/q1S7fjlVcuTh98dfSlTP9mFl4I4B/AvzswzZ5j0GxObq8MiYZrLNrR2q00
         TEiGxTRf3CUPArOMNEZoz9VyZC2dJ8K8PjJkJlgqRByGjoWNmJx2lP+k7naWdBlUbuVb
         fgaA+4Ee43WGMBJ06P4UVcW8U+Ylgs3zYlak8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=j1qjuSlP8Gg1Rc2hrGY0IB+XmVKjM601pMiF0oMT7GO4D9dPC5A9rufT55HzLYTLRX
         4J2PCSF+su7MhvTo8jyTKH+ZgScB28222rIZWst4Gusuh4mfk2QDeyaWHiwCjPlcRtON
         4dn1ZxJGICCz3Af+CgzycWwyLtxSgti+tDwg0=
Received: by 10.220.7.142 with SMTP id d14mr150168vcd.59.1300313192398; Wed,
 16 Mar 2011 15:06:32 -0700 (PDT)
Received: by 10.220.202.140 with HTTP; Wed, 16 Mar 2011 15:06:32 -0700 (PDT)
In-Reply-To: <7v1v267no9.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169201>

On Wed, Mar 16, 2011 at 10:36 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Piotr Krukowiecki <piotr.krukowiecki@gmail.com> writes:
>
>> Opinions? Would it be possible to change the meaning of the codes now
>> (in 1.8.0)?
>
> How about just documenting why it is a bad idea to use 126 or 127 as you
> found out somewhere, and stopping there, iow, without changing the code to
> use 126/127 that we consider it is a bad idea to use and avoided using so
> far?

Documenting it won't help. If you get 126 code, you won't know if user
returned it to mark the code as bad, or if bash returned it to say
that it can't
execute a command.

Of course if changing the meaning is out of option it's better to document
then not to document.

-- 
Piotr Krukowiecki
