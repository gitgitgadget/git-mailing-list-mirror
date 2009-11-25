From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH] grep: --full-tree
Date: Thu, 26 Nov 2009 00:29:54 +0100
Message-ID: <fabb9a1e0911251529v2f4a3426rcc6b79cfb567df18@mail.gmail.com>
References: <7vk4xggv27.fsf@alter.siamese.dyndns.org> <fabb9a1e0911250656k31229c42jd79fb94c1a619e59@mail.gmail.com> 
	<7vr5rmwgbn.fsf@alter.siamese.dyndns.org> <fabb9a1e0911251219t3ad0dacen67d8615ef6eefa02@mail.gmail.com> 
	<7vd436uzet.fsf@alter.siamese.dyndns.org> <fabb9a1e0911251246l4684f357pb5f379b191aaa64a@mail.gmail.com> 
	<alpine.DEB.1.00.0911260030130.4985@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Nov 26 00:30:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDRJd-0008Hw-2V
	for gcvg-git-2@lo.gmane.org; Thu, 26 Nov 2009 00:30:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934892AbZKYXaQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Nov 2009 18:30:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934886AbZKYXaQ
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Nov 2009 18:30:16 -0500
Received: from mail-vw0-f192.google.com ([209.85.212.192]:44028 "EHLO
	mail-vw0-f192.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759943AbZKYXaP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Nov 2009 18:30:15 -0500
Received: by vws30 with SMTP id 30so58536vws.33
        for <git@vger.kernel.org>; Wed, 25 Nov 2009 15:30:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=rsztaxi2ZcsLNu2opyspkhnjbtJus8YalVeBGbWSNLs=;
        b=ZS+VGUnsgg1S0Av1y8iV/RMACQUveHMexreV5lKW6DBN5crzTj3OuENchZUnD7cCeE
         ElKYKGK68DAprSSe5kiyk98Hq6ox4Qs8WA0/CRUDHrTgf8LKit9Q9WGPQ2I4rJfPi5gO
         hQmavUHIM87gHzrXLFQcnTQNgX4Mxlgd//jUk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=mnXWwAH8WQRvYuNlWY3+rB/iRf4zbYLsldm8nC/5hrjlarBiM3ivfbfEl+CNrimAfH
         aYzjkdqYLc72+OFW6XiPMi8hVLDucFaspAXK9LL7TUGPHNv50DBKYCjFfvvJ/4rVgkvJ
         D6hEDoCIbbXFi8dMftrJBJoancuIbIuz3/zss=
Received: by 10.220.66.74 with SMTP id m10mr318286vci.2.1259191814066; Wed, 25 
	Nov 2009 15:30:14 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.0911260030130.4985@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133702>

Heya,

On Thu, Nov 26, 2009 at 00:31, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> You mean like the many people who wanted to keep the dashed commands, but
> unlike who you do speak up _before_ your expectations are broken?

Yes, kinda like that, but with the note that I do think we should not
lock down the UI in favor or not breaking expectations. I mean, if
people want to retain a specific behavior forever, maybe they should
just keep using that version of git forever? Nah, that doens't work of
course, but I do think a balance is needed between the two (improving
the UI and not breaking people's expectations).

-- 
Cheers,

Sverre Rabbelier
