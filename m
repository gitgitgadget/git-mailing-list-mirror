From: Nicolas Sebrecht <nicolas.s-dev@laposte.net>
Subject: [RFC/PATCH 0/2] Re: New 'stage' command
Date: Sun, 5 Apr 2009 21:34:48 +0200
Message-ID: <20090405193448.GB12929@vidovic>
References: <1238939331-10152-1-git-send-email-felipe.contreras@gmail.com> <7vmyausz3h.fsf@gitster.siamese.dyndns.org> <94a0d4530904051228m4e57ec90y810dded41f47e443@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 05 21:39:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LqY8p-0005zH-Pu
	for gcvg-git-2@gmane.org; Sun, 05 Apr 2009 21:36:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756884AbZDETe4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Apr 2009 15:34:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756885AbZDETez
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Apr 2009 15:34:55 -0400
Received: from ey-out-2122.google.com ([74.125.78.25]:35901 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756869AbZDETey (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Apr 2009 15:34:54 -0400
Received: by ey-out-2122.google.com with SMTP id 4so447496eyf.37
        for <git@vger.kernel.org>; Sun, 05 Apr 2009 12:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:to:cc
         :subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=g3dc7+9ASHRhbQ7cQ914HeUTwgHFx5wjEHgN04kNsqM=;
        b=DONkunxgnexKjso2b0ThcDUyVAy+bLaQqVJPRimbUM4m+pVuG4+ex8lfsDKNILhSA8
         r6V4fC+c1I9oaO3TPk7XutOcoNlroSMDjcHowHmwqCm7XC2llTQuzNqUC/qqPKcGJ2c7
         Fz89XHcadi7Mhpyz8m8Svjc7dN3ZBbEExHrh8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=iqR01o/I2KcgLW3T97i5mZIz9AcAIvB+2FJTrL18PkFZ78JYQVdgI7kRylE0pC6LDL
         pJ86hPwK78g478+/Ts/IetJffdp2SIivOJmc7kJ4EDnyTdcpy9Iym+OuD96JILzCsHdO
         NCmyO3dckjfCLtjQBaA12EXqu6EcgqxHOquu8=
Received: by 10.210.127.13 with SMTP id z13mr2294849ebc.93.1238960091655;
        Sun, 05 Apr 2009 12:34:51 -0700 (PDT)
Received: from @ (83-154-175-191.rev.libertysurf.net [83.154.175.191])
        by mx.google.com with ESMTPS id 28sm5800359eye.14.2009.04.05.12.34.50
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 05 Apr 2009 12:34:51 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <94a0d4530904051228m4e57ec90y810dded41f47e443@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115689>

On Sun, Apr 05, 2009 at 10:28:24PM +0300, Felipe Contreras wrote:

> > I do not think these are good ideas at all, as it just spreads more
> > confusion, not less.

Agreed.

> Do you agree that there's already a lot of confusion? (stage, cache,
> index, etc.)
> 
> And do you agree that many git newbies don't use the stage? Actually
> most of them don't even know what it is, and just do "git commit -a".
> 
> If so, how do you think these issues should be handled?

Read the documentation? Read tutorials?

-- 
Nicolas Sebrecht
