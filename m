From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: ref name troubles, was Re: [PATCH v2] Introduce %<branch> as 
	shortcut to the tracked branch
Date: Fri, 20 Mar 2009 06:59:00 +0100
Message-ID: <fabb9a1e0903192259m3b1516a3h315baf84ce65aa35@mail.gmail.com>
References: <200903181448.50706.agruen@suse.de> <20090318182603.GM8940@machine.or.cz> 
	<alpine.DEB.1.00.0903182210310.10279@pacific.mpi-cbg.de> <alpine.DEB.1.00.0903182245280.10279@pacific.mpi-cbg.de> 
	<7vr60ubgul.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0903182343580.10279@pacific.mpi-cbg.de> 
	<alpine.DEB.1.00.0903200121330.10279@pacific.mpi-cbg.de> <alpine.DEB.1.00.0903200137230.10279@pacific.mpi-cbg.de> 
	<20090320004029.GX23521@spearce.org> <20090320004450.GY23521@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Petr Baudis <pasky@suse.cz>,
	Andreas Gruenbacher <agruen@suse.de>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Mar 20 07:00:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkXmi-0000CM-UH
	for gcvg-git-2@gmane.org; Fri, 20 Mar 2009 07:00:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752735AbZCTF7T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Mar 2009 01:59:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752205AbZCTF7S
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Mar 2009 01:59:18 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:63524 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751201AbZCTF7S (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Mar 2009 01:59:18 -0400
Received: by fxm2 with SMTP id 2so768501fxm.37
        for <git@vger.kernel.org>; Thu, 19 Mar 2009 22:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :received:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=MCL2cxE6guyyk72p/qg7RgCTRILOEu5mFihpFEnWvNc=;
        b=sjW8s10//flpyYk7Dqdny8PGQ1JqAwPoh4AS6eTtWogbc9gpQqqD279DemMFaU1NAG
         kYYpnKSqCfpivz2v2sUxmjM7xHltxaq3ZB/nsTzCdbwPsFecMQnDBAsmnOaCrVA/5YKd
         +5uBk6vB+/t6mdRiAscZAr/bsrA4KOhivdSsM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=G+448U2KTteCYQToLgb2CeIFQQJ0zcWw3+thRJj9Uqr3JqL2sET1n9SnuovwCY8fxO
         MWyvt9bJfchyOlpepcEQQNvl+bMBvTifuB3KLwCV1CK0EDD4pM4DhkhaizU8DzUzTh85
         725TK54yr73yisADOwJ+fMJYQa674Kl0Nq6l0=
In-Reply-To: <20090320004450.GY23521@spearce.org>
Received: by 10.103.160.9 with SMTP id m9mr1515053muo.96.1237528755314; Thu, 
	19 Mar 2009 22:59:15 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113897>

Heya,

On Fri, Mar 20, 2009 at 01:44, Shawn O. Pearce <spearce@spearce.org> wrote:
> In hindsight, I wish we had reserved all of the "fun" characters
> like !@#$%^&*():;~'"\ and prevented them from ever appearing in a
> ref name.

Maybe we should add a --pedantic which whines when you use any of
those in a branch name; oh wait, wrong project... :P.

-- 
Cheers,

Sverre Rabbelier
