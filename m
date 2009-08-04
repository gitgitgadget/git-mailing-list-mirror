From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: Please make git-am handle \r\n-damaged patches
Date: Tue, 4 Aug 2009 23:16:06 +0200
Message-ID: <40aa078e0908041416t69ad9d8dxda218489f675f82e@mail.gmail.com>
References: <4A7735B0.2040703@zytor.com>
	 <81b0412b0908032335s3363849aj32a0e93efa15c012@mail.gmail.com>
	 <7v7hxk5b4y.fsf@alter.siamese.dyndns.org>
	 <40aa078e0908041359p79b111eo2f389dde25bb0876@mail.gmail.com>
	 <81b0412b0908041405u1da859f2lf23d6ba25e3bef1f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Git Mailing List <git@vger.kernel.org>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 04 23:18:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYRMq-0005SY-5I
	for gcvg-git-2@gmane.org; Tue, 04 Aug 2009 23:16:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932848AbZHDVQI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Aug 2009 17:16:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932652AbZHDVQI
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Aug 2009 17:16:08 -0400
Received: from mail-fx0-f217.google.com ([209.85.220.217]:51385 "EHLO
	mail-fx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932582AbZHDVQG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Aug 2009 17:16:06 -0400
Received: by fxm17 with SMTP id 17so3535155fxm.37
        for <git@vger.kernel.org>; Tue, 04 Aug 2009 14:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=vmPo+T+vPIKaxX54YBbHdgkLokFhUBS9SEYwrn5NuTg=;
        b=a7SgOlaT4L/Oelq2ATnhB4XC14lXHGz1RIMHIWydLsy49eHrjKKltCCaIddVexx53l
         Ez9RJ4GKarxifFxZsbm1G9eFgD0Croy/RAbTEIFzGloQ70/LNoPq2q3mEvy5BLeV0JEy
         O6Urz0LjZSZlgxwXNAoczUn1roaDEO1JXyCYA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=r/aRabi6jYNem93ZBupiuS/OrUbDDDbluT9G/iFPPwpGqhSD5HPMFn0W01uH8kQajk
         94CvgsWHED0/JFuJCdg0U5aYqi9pEcOzW/h37aPLAxWeti9uaqCqXgJ4mdkppTS0HKpl
         kF1ae2y6uFXsIcb/CMeCB8d356RQ+IKDLm9U4=
Received: by 10.204.55.140 with SMTP id u12mr111185bkg.127.1249420566085; Tue, 
	04 Aug 2009 14:16:06 -0700 (PDT)
In-Reply-To: <81b0412b0908041405u1da859f2lf23d6ba25e3bef1f@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124815>

On Tue, Aug 4, 2009 at 11:05 PM, Alex Riesen<raa.lkml@gmail.com> wrote:
> You missed this line in original posters e-mail:
> "In a serious case of craniorectal immersion..."
>
> We are not safe from that and alike.

Storing e-mails with CRLFs intact is perfectly sane. Depending on them
not being stored that way is not.

-- 
Erik "kusma" Faye-Lund
kusmabite@gmail.com
(+47) 986 59 656
