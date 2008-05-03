From: "=?ISO-8859-1?Q?Santi_B=E9jar?=" <sbejar@gmail.com>
Subject: Re: [PATCH 0/2] Show committer ident in some cases
Date: Sat, 3 May 2008 12:18:59 +0200
Message-ID: <8aa486160805030318oa9d7f85y4b83ec52905338e5@mail.gmail.com>
References: <1209752541-19111-1-git-send-email-sbejar@gmail.com>
	 <7vwsmcwfcn.fsf@gitster.siamese.dyndns.org>
	 <8aa486160805021507s44d7946ejc48ac8a4af08e8cc@mail.gmail.com>
	 <7vbq3owd4o.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 03 12:20:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JsEqU-0001ur-97
	for gcvg-git-2@gmane.org; Sat, 03 May 2008 12:19:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756410AbYECKTG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 May 2008 06:19:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758691AbYECKTF
	(ORCPT <rfc822;git-outgoing>); Sat, 3 May 2008 06:19:05 -0400
Received: from yw-out-2324.google.com ([74.125.46.30]:43784 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756410AbYECKTB (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 May 2008 06:19:01 -0400
Received: by yw-out-2324.google.com with SMTP id 9so104231ywe.1
        for <git@vger.kernel.org>; Sat, 03 May 2008 03:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=81Ihq3zvAlDSh42tHSNlXD9odAz3c3RZODplUKFXz6U=;
        b=IxQCxdvnjyprdmdXVW189qUFCpAvU9MkwIRcdD2Hezbr7s58zdhAwvJNHwXZjp0qQWsdGiM1xv5rCOUMWHr38zL2LPDmeBciDA0ZDj1yyUHH7OLXyHq7ynnWhk7L/zKRtjK/Lmth3b7w0NYXspvtQ2FzwFlnb/L1tUq518btlS4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Z/M6Vgr/VWgdKOJLvmcZyquinT2kCKXv3/u0BDemt6vh4nb+4JpPas9eGs++Vu1hnF8/X4zoKSzTlGfHMRrDFd8WhpN7L3t+q4om5B9xhZCIOjPOiT4pYWhhDKUXobK83rNLoeVTPgTInoUQEeEcIleTa6EA8zG0BY7/qreLuBk=
Received: by 10.150.199.21 with SMTP id w21mr4407938ybf.58.1209809939252;
        Sat, 03 May 2008 03:18:59 -0700 (PDT)
Received: by 10.150.152.19 with HTTP; Sat, 3 May 2008 03:18:59 -0700 (PDT)
In-Reply-To: <7vbq3owd4o.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81066>

>
>  By the way, wasn't it you who wanted to refuse use of user.name _and_
>  user.email that come from ~/.gitconfig, so that you can be sure you use
>  different pseudonym for each project?
>

Yes, that's me. But what I wanted was to refuse the use of the
automatic setting.

Santi
