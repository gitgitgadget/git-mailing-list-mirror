From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: Add Gitweb support for LZMA compressed snapshots
Date: Sat, 1 Aug 2009 16:04:07 +0200
Message-ID: <40aa078e0908010704k7581b656h1ed98a8852efa445@mail.gmail.com>
References: <E0C39B59-E2C5-4C28-9570-D33FEA2A44EB@uwaterloo.ca>
	 <m3r5vy1siq.fsf@localhost.localdomain>
	 <alpine.DEB.1.00.0907301042300.7467@intel-tinevez-2-302>
	 <94a0d4530907310845k51dbafbfy8e240467113dfc16@mail.gmail.com>
	 <alpine.DEB.1.00.0908011431060.8306@pacific.mpi-cbg.de>
	 <94a0d4530908010610n31261414yc08060f3de9c115f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jakub Narebski <jnareb@gmail.com>,
	Mark A Rada <marada@uwaterloo.ca>, git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 01 16:04:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MXFC7-0006nG-NO
	for gcvg-git-2@gmane.org; Sat, 01 Aug 2009 16:04:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751675AbZHAOEK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Aug 2009 10:04:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751660AbZHAOEJ
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Aug 2009 10:04:09 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:41100 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751649AbZHAOEI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Aug 2009 10:04:08 -0400
Received: by bwz19 with SMTP id 19so1668040bwz.37
        for <git@vger.kernel.org>; Sat, 01 Aug 2009 07:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=SdIZ+AOYiVQozg8Aq0/VdQaXAUWkSpKqERQFh79tUzk=;
        b=r0fP7mVXEvVVN0i49/LfExGQg1iWCSwaQxpiEJFqA95D5MN1sqh5VVxDmMufJHEItk
         tmHwNEAnNP+nITrMcHmAEEgLXNGZOlCFagP60/Bft4A2hjCTBNx7RL4upOj1ixbzbKKd
         nwLAo1ZzgYInrxjP1qC8KE4PcjfDZIecGbYsk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=mTMyzgabFAjJibGc/8+UxB0g24sD2iqfk2qZbvTaOhctxYb33a2d+AzJx+uDre0+Nk
         jOAk7ov4JYTwlhhbpeheFSRzmh/IjtGNGTjA4ADYYsbMN+iWhGuQ2eIYJQpzkUJ98qsm
         QWLOe5M0Y0DeHJxBNFBj/q4AuwHUqSyXOtZ5g=
Received: by 10.204.54.4 with SMTP id o4mr4450458bkg.208.1249135447662; Sat, 
	01 Aug 2009 07:04:07 -0700 (PDT)
In-Reply-To: <94a0d4530908010610n31261414yc08060f3de9c115f@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124623>

On Sat, Aug 1, 2009 at 3:10 PM, Felipe
Contreras<felipe.contreras@gmail.com> wrote:
> Windows can't extract .tar.gz?

Not without installing 3. party software. Zip-support is built into
the operating system.

-- 
Erik "kusma" Faye-Lund
kusmabite@gmail.com
(+47) 986 59 656
