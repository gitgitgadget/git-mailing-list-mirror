From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: If you would write git from scratch now, what would you change?
Date: Mon, 26 Nov 2007 11:48:20 -0500
Message-ID: <9e4733910711260848h29bf96c0x961c09cbe600936b@mail.gmail.com>
References: <200711252248.27904.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 26 17:53:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IwhCI-0007Pw-H6
	for gcvg-git-2@gmane.org; Mon, 26 Nov 2007 17:52:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758528AbXKZQs0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Nov 2007 11:48:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758511AbXKZQsZ
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Nov 2007 11:48:25 -0500
Received: from nz-out-0506.google.com ([64.233.162.226]:65431 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758486AbXKZQsW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Nov 2007 11:48:22 -0500
Received: by nz-out-0506.google.com with SMTP id s18so393084nze
        for <git@vger.kernel.org>; Mon, 26 Nov 2007 08:48:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=LtTf8759IZ0krHF2qd6w03GuHcVhs61EDLMObFIgvFU=;
        b=lIVsN04b/NIGOAvjfooFiikPN233tFrsxYXlfegCWH3zuPXRavzGUv64etG3Za6OENyrdlVFvX126F3sKEgtLt7BK/+OIAQSKaO88XNrjj2/3mkfOozWcdOuI0b9wsTrpLHjZ1AzXMUE3jeSSYPYGw7PcvQfA8wJiwBhtBeJXgo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=b7JvssURHIhPYcfbY/IEVVSeCRDQ0OuRFEgQa79ey8+lwNOUYLqzbKCJothZB4vjaL4DnKYSWg/JHNwBnE1TJaeTyVUiTc/NefupcjdIokGSqRajq7QiPPnL1jPrx4Kd4jBQMBBvtJtOl4rHzHxvjZNHrhqxCF3W2U7hMdO79/s=
Received: by 10.114.161.11 with SMTP id j11mr269050wae.1196095700248;
        Mon, 26 Nov 2007 08:48:20 -0800 (PST)
Received: by 10.114.160.3 with HTTP; Mon, 26 Nov 2007 08:48:20 -0800 (PST)
In-Reply-To: <200711252248.27904.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66083>

On 11/25/07, Jakub Narebski <jnareb@gmail.com> wrote:
> If you would write git from scratch now, from the beginning, without
> concerns for backwards compatibility, what would you change, or what
> would you want to have changed?

I would sit down and carefully design the command syntax. git's
biggest criticism is that it is hard to use and this is mainly caused
by the seemingly very complex commands. Much of this complexity could
be hidden from the user.

I'd also integrated a patch management system like stgit. I'm using
stgit commands for 90% of my tasks and it has a different syntax than
git (its trying to fix some of the problems).

Most current git users are knowledgeable programmers and could handle
a rework of the git command syntax. The sooner the syntax is reworked
the better in my opinion. The current syntax grew organically as we
learned what git needed. Now's the time to use this knowledge and
design an optimal command structure.

-- 
Jon Smirl
jonsmirl@gmail.com
