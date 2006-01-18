From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] "sleep 1" sleeps too little on cygwin
Date: Wed, 18 Jan 2006 14:50:04 +0100
Message-ID: <81b0412b0601180550k4df9b89fwf73af7966095ffc7@mail.gmail.com>
References: <81b0412b0601170325y60094b4w693ac37490c67410@mail.gmail.com>
	 <7vvewi2typ.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 18 14:50:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EzDhU-0003fK-Ie
	for gcvg-git@gmane.org; Wed, 18 Jan 2006 14:50:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030313AbWARNuI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Jan 2006 08:50:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030311AbWARNuI
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jan 2006 08:50:08 -0500
Received: from uproxy.gmail.com ([66.249.92.199]:56215 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030313AbWARNuG convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jan 2006 08:50:06 -0500
Received: by uproxy.gmail.com with SMTP id s2so319759uge
        for <git@vger.kernel.org>; Wed, 18 Jan 2006 05:50:05 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=dnQNnC0Sex6o7+YYh+mFHEJRqQMWN23iGR4obWfuq3LLnh7xlM8ZfSftCw3oNjru5GZdTlNvd5SjYsNKa46+8jWU05ljDqGo3tc6CAuEGTzyBXPFYwmKn0+OOxFI3heGrqYufJ5jIIzSJrCEiSA0XcBCz90+IXIfQdc1fD/wejU=
Received: by 10.49.7.17 with SMTP id k17mr444115nfi;
        Wed, 18 Jan 2006 05:50:05 -0800 (PST)
Received: by 10.48.248.4 with HTTP; Wed, 18 Jan 2006 05:50:04 -0800 (PST)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vvewi2typ.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14824>

On 1/18/06, Junio C Hamano <junkio@cox.net> wrote:
> Instead of depending on $SECONDS (isn't it a bashism?), how
> about doing something like this?

Probably not, even QNX6 ksh has it, and being the most broken shell
I ever met, I'd consider $SECONDS safe 8-)
