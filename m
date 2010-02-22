From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCH] git-gui: fix worktree initialization with empty prefix
Date: Mon, 22 Feb 2010 16:39:45 +0100
Message-ID: <cb7bb73a1002220739j1eaae417je9358458f653ef7e@mail.gmail.com>
References: <vpqaav1llpn.fsf@bauges.imag.fr> <1266851964-13044-1-git-send-email-giuseppe.bilotta@gmail.com> 
	<vpqsk8t1e1g.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Feb 22 16:40:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NjaOU-0007GI-4t
	for gcvg-git-2@lo.gmane.org; Mon, 22 Feb 2010 16:40:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753720Ab0BVPkP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Feb 2010 10:40:15 -0500
Received: from mail-ew0-f228.google.com ([209.85.219.228]:64120 "EHLO
	mail-ew0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753259Ab0BVPkO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Feb 2010 10:40:14 -0500
Received: by ewy28 with SMTP id 28so2857315ewy.28
        for <git@vger.kernel.org>; Mon, 22 Feb 2010 07:40:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=pm80e25cEDUC6Z2EnXBI/KenTBx18qu42le7s+vb+Wc=;
        b=lT9OI4ueejVcOS847nrASXQGjkhuOMPz6kM1NL3/hBT8ngh5wDDhHm5yVrUuL75uOh
         2wA9GuEVSI+mhnswdNAaWVu+sbUcGh7Kma8wSioY8b3digDJGc8HVEi+Do6U5pfGOtDN
         ADUIP8/W1oECMc5prQFM7g3LWyUR0FTxcqgU4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=iMmq/Idk8vh598xAe7gjQUG+gTaqMwWW/T1GkqzLT1MYAuOM0q2pjgzoQcQBZw8Ajl
         IrejoWmWfg5vApXYg2vO4GOSa1z4YnQCHvG/qbQpCC5Ax4UwNXbxubfC5krIvBtFHjCM
         YwA08w2f8udyx9RSRJq5yADB7IiKmrp83jQWo=
Received: by 10.213.44.9 with SMTP id y9mr1438433ebe.71.1266853206309; Mon, 22 
	Feb 2010 07:40:06 -0800 (PST)
In-Reply-To: <vpqsk8t1e1g.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140691>

On Mon, Feb 22, 2010 at 4:32 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Giuseppe Bilotta <giuseppe.bilotta@gmail.com> writes:
>
>> This is sort of a chicken-and-egg problem, because we should only
>> bother setting the worktree if we are not in a bare repository, but
>> an unset worktree is one of the conditions we check to see if we have
>> a bare repository.
>>
>> Maintain the same sequence of checks, but swap the check for bareness
>> support and bareness of repository, and check again for an unset
>> worktree if we are not in the bare case.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>

>
> Tested-by: Matthieu Moy <Matthieu.Moy@imag.fr>
>
> (don't forget Signed-off-by)

Damn. Thanks. I just set format.signoff so I won't forget again.

> Thanks,

Thank you for spotting and testing this.

-- 
Giuseppe "Oblomov" Bilotta
