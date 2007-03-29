From: Tom Prince <tom.prince@ualberta.net>
Subject: Re: SEGV in git-merge recursive:
Date: Thu, 29 Mar 2007 16:58:03 +0400
Message-ID: <20070329125803.GA16739@hermes>
References: <20070329075010.GA3493@hermes> <81b0412b0703290429k63642a34u6bea1e08803ffba7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 29 14:58:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HWuCV-0002WZ-M1
	for gcvg-git@gmane.org; Thu, 29 Mar 2007 14:58:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753417AbXC2M54 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Mar 2007 08:57:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753423AbXC2M54
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Mar 2007 08:57:56 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:44874 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753417AbXC2M54 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Mar 2007 08:57:56 -0400
Received: by ug-out-1314.google.com with SMTP id 44so502502uga
        for <git@vger.kernel.org>; Thu, 29 Mar 2007 05:57:54 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:date:from:to:cc:subject:message-id:mail-followup-to:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:sender;
        b=I8mqEHMn2jN6loTzMPGN23KpkPg7W6kqm0vT9hsuV04kXbx18Tek8jzRb5Nfbl3/2ZDpIRFmmEauAZxproCTliVS3rYJITgftq4B3WnyYw7yL8/01G+DUeRMToF4f06hD1MAMV9wf6s92w34ad6jgDFPQeNWjV2tYAVLZJyD9B0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:date:from:to:cc:subject:message-id:mail-followup-to:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:sender;
        b=dxlmhDvqwezwauY3DSRQf8TORIMaNq9WDdvoitL5c1jpZawDBp3tYvJ8bfckAEqDQ1/iaKKmRaM1A2TJQGDjLZSUQnG/dJ6BG8PmsEQtPjdGxTMfWNCabfFFv8oU78pF3vYr2PGbCzBotgNa5IznujTrSKg6WcZzZFo45ps/N0g=
Received: by 10.67.29.12 with SMTP id g12mr1414538ugj.1175173074799;
        Thu, 29 Mar 2007 05:57:54 -0700 (PDT)
Received: from hermes ( [80.240.215.209])
        by mx.google.com with ESMTP id x33sm1569186ugc.2007.03.29.05.57.52;
        Thu, 29 Mar 2007 05:57:54 -0700 (PDT)
Received: by hermes (nbSMTP-1.00) for uid 500
	(using TLSv1/SSLv3 with cipher DES-CBC3-SHA (168/168 bits))
	Tom; Thu, 29 Mar 2007 16:58:07 +0400 (MSD)
Mail-Followup-To: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <81b0412b0703290429k63642a34u6bea1e08803ffba7@mail.gmail.com>
User-Agent: Mutt/1.5.14 (2007-02-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43431>

On Thu, Mar 29, 2007 at 01:29:46PM +0200, Alex Riesen wrote:
> On 3/29/07, Tom Prince <tom.prince@ualberta.net> wrote:
> >I have been keeping my Maildir in git, a non-trivial merge that causes a
> >segfault in git-merge-recursive.
> >
> >It does not appear to matter which direction I try to merge.
> >
> 
> BTW, what git do you have? git --version?

1.5.1.rc3
