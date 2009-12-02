From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [RFC PATCH 0/8] Git remote helpers to implement smart transports.
Date: Wed, 2 Dec 2009 19:55:04 +0100
Message-ID: <fabb9a1e0912021055m56328d87y11a090a9a9bcb046@mail.gmail.com>
References: <1259675838-14692-1-git-send-email-ilari.liusvaara@elisanet.fi> 
	<7vskbuwhmy.fsf@alter.siamese.dyndns.org> <20091202055632.GD31244@Knoppix> 
	<7vy6llnar5.fsf@alter.siamese.dyndns.org> <20091202160446.GA32667@Knoppix> 
	<alpine.DEB.1.00.0912021832480.4985@pacific.mpi-cbg.de> <fabb9a1e0912021006x2905578bo16dbcaedc0d97bc6@mail.gmail.com> 
	<7vk4x5fcbf.fsf@alter.siamese.dyndns.org> <fabb9a1e0912021050r4fd96ed4rf863917a965a42fb@mail.gmail.com> 
	<7v3a3tfbsx.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 02 19:55:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFuMN-0004nf-UW
	for gcvg-git-2@lo.gmane.org; Wed, 02 Dec 2009 19:55:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753548AbZLBSzT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Dec 2009 13:55:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752938AbZLBSzT
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Dec 2009 13:55:19 -0500
Received: from mail-vw0-f197.google.com ([209.85.212.197]:41599 "EHLO
	mail-vw0-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751821AbZLBSzS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Dec 2009 13:55:18 -0500
Received: by vws35 with SMTP id 35so208467vws.4
        for <git@vger.kernel.org>; Wed, 02 Dec 2009 10:55:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=IhXo7lsgHKtabbpt6tmOk2KtFsDuF0nPe3kZ9p4wBG0=;
        b=il2pKXcDNdtdbJad7Uc/lOeo5Uk5p7lKgy/kyVEZi7mPVIRd/3/n51ltTJvlPm6IX4
         EkTMP13ANvAf9oYAbZLAVlOd+B3LPjK2/edMpOvKfY6PahLPEMb4kqLqPTXUwiS7MtU6
         XSi8k3thmmyR97lwdGhcF04VnH6t+/0Z88wwM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=LSSm0AWQQ7tM04HHcqRV1gs9cyp7tzKLK9jJTpbUNPy6ctZsXY1TJLyz12RUKuE2+9
         2Onswu0IL12MfbNA9E86dl54aT6CFUIFjsr9NjfCaztoqBT5OhirWyolWtQJnsdgMY7r
         NU2j52PCdDEsIxcNpadOM7CTvmcdnwzFjiVbE=
Received: by 10.220.122.96 with SMTP id k32mr541102vcr.96.1259780124150; Wed, 
	02 Dec 2009 10:55:24 -0800 (PST)
In-Reply-To: <7v3a3tfbsx.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134371>

Heya,

On Wed, Dec 2, 2009 at 19:52, Junio C Hamano <gitster@pobox.com> wrote:
> Sure, but please search for "second class citizen" in my message.

I read that, but I don't understand how exactly the mapping will make
it a non-second class citizen. How will your mapping include the
alternative implementation? The word mapping suggests a 1:1 relation
between protocol and implementation, so I don't see how the
alternative implementation would become first-class :(.

-- 
Cheers,

Sverre Rabbelier
