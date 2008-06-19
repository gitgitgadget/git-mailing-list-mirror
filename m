From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git-diff question
Date: Thu, 19 Jun 2008 05:03:30 -0700 (PDT)
Message-ID: <m3tzfpmy2b.fsf@localhost.localdomain>
References: <556d90580806190448y2bfeebardb05c5b0b91e53a7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Alf Clement" <alf.clement@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 19 14:04:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9IsU-0003ZO-6u
	for gcvg-git-2@gmane.org; Thu, 19 Jun 2008 14:04:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754380AbYFSMDi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jun 2008 08:03:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754569AbYFSMDi
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jun 2008 08:03:38 -0400
Received: from ik-out-1112.google.com ([66.249.90.183]:13074 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754309AbYFSMDh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2008 08:03:37 -0400
Received: by ik-out-1112.google.com with SMTP id c28so435850ika.5
        for <git@vger.kernel.org>; Thu, 19 Jun 2008 05:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=aEz2PJjCSPEgS1NmAhuEbd8h3uRtlD5JT0GLnjEbi9Y=;
        b=fZaNOzoEiyCGEsuG4C6m8r3l+S/PfMyK3xY1eMNBFc/wrK4NmqMupKDL3BhdcAtoRq
         /WRzchG7iXIyTnAlRAqfT//TDQ2udfjRk9SZV8d81Opii+ZXFSjeNERfo0aYtM1nVJBA
         YxJX6WIi6N0vqIBhG7m0g3hKMBSh9tHej1y+w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=u5r52AdPQd1NXJ7gIBCQ9CbrPMi42wdZu6mjR5ZTYZHlHtfYj/GBHNEl7w0yOODrwQ
         KDZsUDi5yTjq36C42/9HFCYqsFlN5l+MNB9za46EoBYvqq9Fg1c/aw9L40NRjtrwl2au
         b9Ud7vy1Jag6cPAjEyHl+zJhWz9d7ZOb9oelg=
Received: by 10.210.75.6 with SMTP id x6mr1781263eba.31.1213877011778;
        Thu, 19 Jun 2008 05:03:31 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.242.161])
        by mx.google.com with ESMTPS id c25sm819678ika.11.2008.06.19.05.03.28
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 19 Jun 2008 05:03:30 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m5JC3QaT030216;
	Thu, 19 Jun 2008 14:03:26 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m5JC3PmY030213;
	Thu, 19 Jun 2008 14:03:25 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <556d90580806190448y2bfeebardb05c5b0b91e53a7@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85472>

"Alf Clement" <alf.clement@gmail.com> writes:

> $ git diff
> diff --git a/Firmware/Firmware.ccscc b/Firmware/Firmware.ccscc
> old mode 100755
> new mode 100644
> ....
> returns a list of files where the mode was changed, which seems to be
> correct. Also
> modified files are flaged.
> I wonder why
> $ git diff --diff-filter=T
> outputs nothing.

Isn't 'T' about *t*ype change, i.e. change between ordinary file,
symlink, directory and commit (submodule)?

> I am running this under Cygwin.

Or perhaps this is a cause.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
