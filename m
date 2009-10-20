From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: git fsck not identifying corrupted packs
Date: Tue, 20 Oct 2009 11:25:00 +0200
Message-ID: <81b0412b0910200225g47220cc9wa2e82290a853c85d@mail.gmail.com>
References: <loom.20091019T094924-194@post.gmane.org>
	 <4ADC2D45.3020803@viscovery.net>
	 <alpine.DEB.1.00.0910191202020.4985@pacific.mpi-cbg.de>
	 <7v7hur1a0h.fsf@alter.siamese.dyndns.org>
	 <vpqy6n6shri.fsf@bauges.imag.fr>
	 <7vfx9esgvt.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Sergio Callegari <sergio.callegari@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 20 11:27:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0Axo-0007aH-4f
	for gcvg-git-2@lo.gmane.org; Tue, 20 Oct 2009 11:25:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751545AbZJTJY6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 20 Oct 2009 05:24:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750843AbZJTJY6
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Oct 2009 05:24:58 -0400
Received: from mail-fx0-f218.google.com ([209.85.220.218]:51340 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750771AbZJTJY5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Oct 2009 05:24:57 -0400
Received: by fxm18 with SMTP id 18so6157355fxm.37
        for <git@vger.kernel.org>; Tue, 20 Oct 2009 02:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Kbx5ufZcryktokUiHqfo6P2TWq1mUt2jZcMoOZHJZJs=;
        b=AuoC38v3cxtyKLdIA3MonZHt1xSaaceWq60MSgfx7ZLiHFWR5F3IbGDFSB74sic8BC
         0+ewVZNDr/gAk6bMj/5Efswnp844tvXmTh9wWp+6IgEEOu01+vPi/Q1zvq+VEDox0NGs
         HXsHmwOzrDrpXt0HgZx9mstv0KBUwMSfVHAa8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=t+8TTRKlV925H1HJlYuFkcdXPOQWQnUmBaxdqjt/jBQq3TthHcwaC0mHT74nZ4AU/g
         FjMQ7yBaEvsxs7toTP1lSuMGCBjADl576W0mNagH5YoIQErboBaLs8E6/iIMUx3pAaL+
         eU0Cbr4ddTvsTyCQXZZHSMylFQVVLz45UdKgA=
Received: by 10.204.34.9 with SMTP id j9mr6071192bkd.10.1256030701089; Tue, 20 
	Oct 2009 02:25:01 -0700 (PDT)
In-Reply-To: <7vfx9esgvt.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130779>

On Tue, Oct 20, 2009 at 08:45, Junio C Hamano <gitster@pobox.com> wrote=
:
> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>>> It probably is also a good idea to add a "--loose" option that does=
 what
>>> "fsck" currently does without "--full". =C2=A0It is a good name
>>
>> +1 too.
>
> Actually, I changed my mind. =C2=A0I do not think this so big that we=
 need to
> wait for a major version bump. =C2=A0Why not shoot for 1.6.6?

--no-full works
