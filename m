From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH] git-fetch should not strip off ".git" extension
Date: Wed, 22 Oct 2008 00:43:09 +0200
Message-ID: <81b0412b0810211543p6cb8c4ej49fb7fe70c3e2917@mail.gmail.com>
References: <ee2a733e0810180459m5fd20365s3c27bea5c1f3f704@mail.gmail.com>
	 <48FC5F1B.1050608@op5.se> <7vzlkz2jv7.fsf@gitster.siamese.dyndns.org>
	 <ee2a733e0810210323j249c3460x881af6d6aefc647c@mail.gmail.com>
	 <7vej29zy2r.fsf@gitster.siamese.dyndns.org>
	 <81b0412b0810211506y400ba750k2613ba19f01fb57@mail.gmail.com>
	 <7vd4htwp6v.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: SLONIK.AZ@gmail.com, "Andreas Ericsson" <ae@op5.se>,
	git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 22 00:44:29 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KsPxh-0003pJ-W0
	for gcvg-git-2@gmane.org; Wed, 22 Oct 2008 00:44:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751461AbYJUWnM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Oct 2008 18:43:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751179AbYJUWnL
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Oct 2008 18:43:11 -0400
Received: from mail-gx0-f16.google.com ([209.85.217.16]:60928 "EHLO
	mail-gx0-f16.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751127AbYJUWnK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Oct 2008 18:43:10 -0400
Received: by gxk9 with SMTP id 9so6466548gxk.13
        for <git@vger.kernel.org>; Tue, 21 Oct 2008 15:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=fQThhpsaZBDw+EFCvBvJfvWOznUIG7EUAQOwSCRrdV4=;
        b=t0Z8BcZrQxBm+8GLSIrnyc+L0nDJ10nGQVSUaSvOH8QnicAGeMfuqjbBOEQf7hsA7h
         OHFLOV5ii1JHyLE7K99pp/l/94mWaWZQ+11lBni4pStBESGTu/8SHK53mIfSacq5BndS
         nGHrJmMVENvC6N4st4CAyCyzCwnB/cikeUDi8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=F4UGP6v+atIaNA3BuNbeeUoSP3xx6Srd8SxtJZ6hXCbjIoCZowMIU6Fd+ZgU2eTlwW
         WH7LYyVRuO9/4uhJXtwLZl6+Kh4rCGzT/pTZsuT3qyXSrJk4XuDmE7TpLe1gHL4EkRlH
         JTQdzTcZDB0LaYOtpg4L7mvydY5j9vEGsTT/o=
Received: by 10.100.132.2 with SMTP id f2mr4621310and.123.1224628989277;
        Tue, 21 Oct 2008 15:43:09 -0700 (PDT)
Received: by 10.100.91.8 with HTTP; Tue, 21 Oct 2008 15:43:09 -0700 (PDT)
In-Reply-To: <7vd4htwp6v.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98823>

2008/10/22 Junio C Hamano <gitster@pobox.com>:
> "Alex Riesen" <raa.lkml@gmail.com> writes:
>>
>> FWIW, I support Leo on that. The "established" behavior is stupid.
>
> I am not inclined to respond to such an emotional argument.  On the other
> hand, it is fair to say that the existing behaviour is established,
> because it is backed by a long history, which you can objectively verify.

I found it illogical (well, stupid) and inconvinient

> *1* It would be a different matter if the patch at the same time removed
> the fetch/clone DWIMmery.  At least such a patch would be internally self
> consistent.

Good idea.
