From: Stephen Boyd <bebarino@gmail.com>
Subject: Re: [PATCH 0/2] teach am and rebase -q/--quiet
Date: Sun, 14 Jun 2009 00:07:24 -0700
Message-ID: <4A34A1AC.2070808@gmail.com>
References: <1244924500-27391-1-git-send-email-bebarino@gmail.com> <7vk53fvini.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 14 09:08:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MFjpm-0001zQ-Fh
	for gcvg-git-2@gmane.org; Sun, 14 Jun 2009 09:08:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752281AbZFNHH0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Jun 2009 03:07:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752152AbZFNHHZ
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Jun 2009 03:07:25 -0400
Received: from mail-pz0-f187.google.com ([209.85.222.187]:58047 "EHLO
	mail-pz0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752109AbZFNHHZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Jun 2009 03:07:25 -0400
Received: by pzk17 with SMTP id 17so1353265pzk.33
        for <git@vger.kernel.org>; Sun, 14 Jun 2009 00:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=lJ8N+LFOLFAst3fWxyIpy4b0q6ymGgjLmqBkrFzNRvE=;
        b=Psxm1Pfm0nftg6wEtsfvGiMeoPAKtA8TKABdftL74xPaOS8xcx16e3dkB9q/qW90vt
         MG4KYKMbXpBcFSBmA2aMYzIbuQbdbi4MyNTIO5r/YZ/0x7L1ryn66I6u9xw+fueP0G6A
         +BDYEoyUcWQgy+WSEWhCFxcd6JcaOYn46/SbA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=HokbVo9JpE0zDS8+1hzho6Jz2ghI8O1rG9RveKT9lFSlZxmDyIcQaVN7ob94r4khs5
         vBawFqHozfXnuMegIye6EcjPNBD0xBYmafzDabLxe1bNXOA99o5t1JCbcDw+qYd8XPqG
         DwthdSV1bXI4LAQ5pKwELDNVNzpqcC1LNQ8wE=
Received: by 10.114.190.6 with SMTP id n6mr9224817waf.133.1244963247140;
        Sun, 14 Jun 2009 00:07:27 -0700 (PDT)
Received: from ?192.168.1.2? ([76.89.212.195])
        by mx.google.com with ESMTPS id n30sm3911150wag.6.2009.06.14.00.07.25
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 14 Jun 2009 00:07:26 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.21 (X11/20090429)
In-Reply-To: <7vk53fvini.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121537>

Junio C Hamano wrote:
> There are many valid cases where it makes sense to use stderr for messages
> that are not errors (e.g. diagnostics, prompts, progress reports, and
> informational messages that otherwise would clutter machine parsable
> output meant to go to stdout).
>
> I do not understand why some people seem to think stderr is only for
> errors.  I think we even saw a broken interpretive language environment
> where the system considers it an error if a program it launched said
> anything to stderr, instead of correctly diagnosing the exit status from
> it?
>
> It is a disease.
>   

If I understand you correctly, wrapping them in quiet checks is fine.
Also, thanks for the explanation. I'll consider my self inoculated.
