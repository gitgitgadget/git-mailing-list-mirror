From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: git-tag bug? confusing git fast-export with double tag objects
Date: Thu, 14 May 2009 15:42:45 +0200
Message-ID: <fabb9a1e0905140642x26bf5e2ala604a36d0fe520a6@mail.gmail.com>
References: <op.utv93sdo1e62zd@merlin.emma.line.org> <op.utwdsutn1e62zd@merlin.emma.line.org> 
	<7v8wl01iev.fsf@alter.siamese.dyndns.org> <op.utwyczlf1e62zd@merlin.emma.line.org> 
	<81b0412b0905140516k4bc84606scb71981936966caf@mail.gmail.com> 
	<op.utw7buoi1e62zd@balu> <81b0412b0905140616h69ac2919j26734f02455a5f5c@mail.gmail.com> 
	<op.utw9khqa1e62zd@balu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Erik Faye-Lund <kusmabite@gmail.com>
To: Matthias Andree <matthias.andree@gmx.de>,
	Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 14 15:43:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4bDS-00051U-2e
	for gcvg-git-2@gmane.org; Thu, 14 May 2009 15:43:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753461AbZENNnK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 May 2009 09:43:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753047AbZENNnI
	(ORCPT <rfc822;git-outgoing>); Thu, 14 May 2009 09:43:08 -0400
Received: from mail-bw0-f174.google.com ([209.85.218.174]:42540 "EHLO
	mail-bw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752827AbZENNnF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 May 2009 09:43:05 -0400
Received: by bwz22 with SMTP id 22so1298399bwz.37
        for <git@vger.kernel.org>; Thu, 14 May 2009 06:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=/oUcZjrNCvr5rwcTR3AnwJLskf6bwbmqm3ibhg93Irg=;
        b=K5EzEM9CSKiCcUVysVVr2uLYyoUT7yNAuRVTd7BtOeAaoh9WyFZGqF/6O5c1o5b5aC
         t0Ig8I8UizkMAaqZ+s44TWCtuEFuJYAPUWflbgylOXUsB/BMqsyBPlsScBZ6tcLV26/7
         ggEgNbMfJtnbr30x6LgUdz2T0hK2eJJ6TA3Lo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=dG6OeeV14dSPPe5XfLsGquxrrZrzndpvtszJlZiSTEimb5H2ZCK5F3aXcMEhMhIL+2
         OKuFDmqqJoKHI1lwGRbE0Q6gIIiziNynVWn7/j6UTJEJoBMKEWOzcZwN0TYQQ+HSwDFu
         8zwwDGHHCFMXXtPSGP77pfZtFaP1hoYGP38Rc=
Received: by 10.103.193.13 with SMTP id v13mr510460mup.136.1242308585257; Thu, 
	14 May 2009 06:43:05 -0700 (PDT)
In-Reply-To: <op.utw9khqa1e62zd@balu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119191>

Heya,

On Thu, May 14, 2009 at 15:39, Matthias Andree <matthias.andree@gmx.de> wrote:
> The bug itself (references to 'deleted' or 'replaced' tag objects remain
> reachable rather than becoming dangling) is still there without a suggestion
> to the solution, and you're uselessly the bug.

I believe Alex is saying that this is not a bug, but intended
behavior, and Matthias is saying that we should change that behavior
so that users are at least aware that they are creating such a
situation, is that correct?

-- 
Cheers,

Sverre Rabbelier
