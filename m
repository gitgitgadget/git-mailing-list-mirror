From: "Sverre Rabbelier" <srabbelier@gmail.com>
Subject: Re: [RFC PATCH] Make the rebase edit mode really end up in an edit state
Date: Thu, 15 Jan 2009 13:55:09 +0100
Message-ID: <bd6139dc0901150455i3a978f9co3fd938c03a788a78@mail.gmail.com>
References: <87ab9th0rh.fsf@cup.kalibalik.dk>
	 <alpine.DEB.1.00.0901150149130.3586@pacific.mpi-cbg.de>
	 <496EE74F.6000205@viscovery.net>
	 <200901151101.53441.johan@herland.net>
	 <bd6139dc0901150352t2d2fa388x3eb842bbc8c4baa6@mail.gmail.com>
	 <alpine.DEB.1.00.0901151325310.3586@pacific.mpi-cbg.de>
	 <19A8FAC6-A27A-4D6B-A276-02EE17F0E5F5@frim.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Johan Herland" <johan@herland.net>, git@vger.kernel.org,
	"Johannes Sixt" <j.sixt@viscovery.net>,
	"Anders Melchiorsen" <mail@cup.kalibalik.dk>, gitster@pobox.com
To: "Pieter de Bie" <pieter@frim.nl>
X-From: git-owner@vger.kernel.org Thu Jan 15 13:56:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNRm1-00043u-9B
	for gcvg-git-2@gmane.org; Thu, 15 Jan 2009 13:56:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756473AbZAOMzN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jan 2009 07:55:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756150AbZAOMzM
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Jan 2009 07:55:12 -0500
Received: from yx-out-2324.google.com ([74.125.44.30]:3693 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755614AbZAOMzK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jan 2009 07:55:10 -0500
Received: by yx-out-2324.google.com with SMTP id 8so442474yxm.1
        for <git@vger.kernel.org>; Thu, 15 Jan 2009 04:55:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references
         :x-google-sender-auth;
        bh=zDtF2s+DB5tw1sd18jiP36bXCF/kepbGmvgw1ctRz4Q=;
        b=czyGOrABFYSWSxLeWvsZpFkHzYdZRMh4yImk1WDyOn5z0g6Iw+XGtHg2MT4lH54Qvh
         IQ3G4iwk7QCkKxBaby1eL2gxscEbfTfEIxSOsRx7rjr9F5mxdMA6myA0d75CtqBDuAwA
         Trv9HOVgSz+dIjrmhIj/K5IRX/YBvN4RqvSmU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references:x-google-sender-auth;
        b=IepcTQQcekJk28cpIvEQzEh8sszEQX6zfFy+L6uIj2+E8t+rCX9fbBu1VwwNgmGqMa
         c4GU+w1Sf2o/8HDoVFB4NE0fZbKNamIyqiULIUSdwtQww+D+XC6TY/1Esx8X+JYfAiJs
         5PeN5VewZ86DGvtlGSo3NVN3Cxn2FTH5+qEic=
Received: by 10.151.110.14 with SMTP id n14mr1187149ybm.123.1232024109502;
        Thu, 15 Jan 2009 04:55:09 -0800 (PST)
Received: by 10.150.121.4 with HTTP; Thu, 15 Jan 2009 04:55:09 -0800 (PST)
In-Reply-To: <19A8FAC6-A27A-4D6B-A276-02EE17F0E5F5@frim.nl>
Content-Disposition: inline
X-Google-Sender-Auth: f80004e1c47115d4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105788>

On Thu, Jan 15, 2009 at 13:52, Pieter de Bie <pieter@frim.nl> wrote:
> I think this demonstrates that you can do a lot more with 'edit' than just
> edit.
> 'redact' etc also don't cover it. Perhaps just a general 'pause' or
> something?
>
> You can then put something like 'pause  --  pause, for example to amend
> commit'
> in the description part.

That makes sense, perhaps we could name the feature described by the
OP something like "reset", as that is what it actually does?


-- 
Cheers,

Sverre Rabbelier
