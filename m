From: "Carlos R. Mafra" <crmafra2@gmail.com>
Subject: Re: Performance issue of 'git branch'
Date: Thu, 23 Jul 2009 05:27:16 +0200
Message-ID: <20090723032715.GA7630@Pilar.aei.mpg.de>
References: <20090722235914.GA13150@Pilar.aei.mpg.de> <alpine.LFD.2.01.0907221714300.3352@localhost.localdomain> <20090723012207.GA9368@Pilar.aei.mpg.de> <alpine.LFD.2.01.0907221850000.3352@localhost.localdomain> <alpine.LFD.2.01.0907221921570.3352@localhost.localdomain> <20090723031843.GA9152@Pilar.aei.mpg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Jul 23 05:28:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MToz4-0006HE-68
	for gcvg-git-2@gmane.org; Thu, 23 Jul 2009 05:28:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753068AbZGWD2e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Jul 2009 23:28:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753037AbZGWD2e
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Jul 2009 23:28:34 -0400
Received: from mail-fx0-f218.google.com ([209.85.220.218]:55509 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752983AbZGWD2d (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jul 2009 23:28:33 -0400
Received: by fxm18 with SMTP id 18so571939fxm.37
        for <git@vger.kernel.org>; Wed, 22 Jul 2009 20:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=F9GqbkjnCw7eMw4RBKl4jlxXGqWeo+6e1X2e7l3DxIw=;
        b=elJmBVcGLrdv1VyjIV7LJJpjYCRdd8yw26ac5uk2knQN/f1ImKda9+OniZDi+erRGn
         v9io1QqRL1oEA7WkfiBjBytCf+44rHTnC+hy5Yx/7uRbPnvz7qE8d/0KxCO5Sc35MKXC
         ok6Flt9pylqOPFMXk/onzJhJ3ObHr38xyl6JU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=aBjJlNPhLPsn/iriDr5aBj79UclMrfth3iHYlWFhcagQ9psBnwGl4UztQEdqOGJtVP
         5mf3yUvQYahTlXQcE9tmU6Enq6vQpfVmrXLAcSYze3ffK1mRznmU3Sh+rRg9pwawCDbK
         GG06FdGX8tuDNwzsIId5My8QrC1K8SSHq6mUE=
Received: by 10.86.98.18 with SMTP id v18mr1440562fgb.13.1248319713033;
        Wed, 22 Jul 2009 20:28:33 -0700 (PDT)
Received: from Pilar.aei.mpg.de ([82.113.121.18])
        by mx.google.com with ESMTPS id 4sm2668331fgg.12.2009.07.22.20.28.29
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 22 Jul 2009 20:28:32 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20090723031843.GA9152@Pilar.aei.mpg.de>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123829>

On Thu 23.Jul'09 at  5:18:44 +0200, Carlos R. Mafra wrote:

>       * GIT_DEBUG_LOOKUP=1 git branch produced ugly 2200+ lines

With your patch applied it went down to 132 lines.
