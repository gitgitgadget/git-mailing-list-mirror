From: "Sverre Rabbelier" <alturin@gmail.com>
Subject: Re: blame vs annotate?
Date: Thu, 4 Sep 2008 11:16:13 +0200
Message-ID: <bd6139dc0809040216v40914e82h6a4032941cf65996@mail.gmail.com>
References: <57518fd10809030943i35af222fw82cf591c737b8c04@mail.gmail.com>
	 <7v8wu9cd7i.fsf@gitster.siamese.dyndns.org>
	 <vpq7i9smg5e.fsf@bauges.imag.fr>
Reply-To: sverre@rabbelier.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Jonathan del Strother" <maillist@steelskies.com>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Matthieu Moy" <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Thu Sep 04 11:18:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KbAxv-0003m8-BT
	for gcvg-git-2@gmane.org; Thu, 04 Sep 2008 11:17:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756315AbYIDJQQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Sep 2008 05:16:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756099AbYIDJQQ
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Sep 2008 05:16:16 -0400
Received: from ik-out-1112.google.com ([66.249.90.178]:42218 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755574AbYIDJQP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Sep 2008 05:16:15 -0400
Received: by ik-out-1112.google.com with SMTP id c28so1623914ika.5
        for <git@vger.kernel.org>; Thu, 04 Sep 2008 02:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=coXF4ExKKMN2kDHCuvWayXSs0xbjDh5qsj1uMRwHZjI=;
        b=AAt7BiFjjv2bQYsCPlR/rmfwWU2ep1tL9PEdEup3mHzEOo/s/32FmuRxLm8lh9Qxpk
         7uxGcg8WGL9R3XyC1SdTwwdzaZ70ZWi35v3kM6KfDGkHs4SAuiGDqe4H2spmF0/U63GD
         eh38aby6QrH19aBdgVg+8CKhSrVNRZ/371BTg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:cc:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:references;
        b=B5ns/izXMBwWtgdB3/A9L1768cSqOc5OCgZap4IV8XglsImrx8ogH+8PZruANowv+D
         KR7ken9BFMPq3DauLvW9NvFnBnxPGf0sggAJjBedEsmDGHmxT6hza2Z5RbUB1iSdhenw
         ZexC2TTr0FC4kR1j74SKEzWNEPTTXDwyKjxe4=
Received: by 10.187.166.12 with SMTP id t12mr2342738fao.2.1220519773235;
        Thu, 04 Sep 2008 02:16:13 -0700 (PDT)
Received: by 10.187.213.8 with HTTP; Thu, 4 Sep 2008 02:16:13 -0700 (PDT)
In-Reply-To: <vpq7i9smg5e.fsf@bauges.imag.fr>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94912>

On Thu, Sep 4, 2008 at 11:09, Matthieu Moy <Matthieu.Moy@imag.fr> wrote:
> +This command exists for backward compatibility. If you don't have
> +existing scripts using 'git annotate', you should use
> +linkgit:git-blame[1] instead.

This implies that if you do have a script that uses git-annotate, you
should use it in your daily use too. Maybe something like "For regular
use you should use ...."?

-- 
Cheers,

Sverre Rabbelier
