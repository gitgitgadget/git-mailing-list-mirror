From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: git-branch, older repos and more confusion
Date: Thu, 12 Apr 2007 17:06:27 +1200
Message-ID: <46a038f90704112206j65af1039hc96be93f723b7c28@mail.gmail.com>
References: <46a038f90704112114t520374b2qea4f860575c21bce@mail.gmail.com>
	 <20070412042308.GA22539@coredump.intra.peff.net>
	 <461DBBA0.3070609@vilain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Jeff King" <peff@peff.net>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Sam Vilain" <sam@vilain.net>
X-From: git-owner@vger.kernel.org Thu Apr 12 07:06:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HbrVw-0004SA-4X
	for gcvg-git@gmane.org; Thu, 12 Apr 2007 07:06:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030735AbXDLFG2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Apr 2007 01:06:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030816AbXDLFG2
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Apr 2007 01:06:28 -0400
Received: from wx-out-0506.google.com ([66.249.82.235]:42770 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030735AbXDLFG1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Apr 2007 01:06:27 -0400
Received: by wx-out-0506.google.com with SMTP id h31so441535wxd
        for <git@vger.kernel.org>; Wed, 11 Apr 2007 22:06:27 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=WxLq8Fu8HivuyZHoS4yiP64h/o5vQHeg2/Mqa0lZ62AqCnKotr+bCYix2fvljde2fDdsM91rCN74jdVsoVC8AxgHHvtM26vULvmd5+w3kJsc6nu+Ac0/z7MgQDZoD5yIxUW3HgHTIV4cuUHxqOvFjr8D+KM8h8b3cMmks8kJXXw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=bba9xzCIvM9MX1yXKx5C0X8zvwDwDplmdsrokvKYUM+47bN5D4VgU7jMKw+VgR4rk8XtEcIEMnoQgPNeOdhSn3aW7MFLJHUZztGVTbBvVM/yyfB3MMAO1DVBLH3NvM/jSxAMbr/hJtbLPEu6dZkvMM/chpjizWIVa20sDgPf408=
Received: by 10.90.93.6 with SMTP id q6mr1340299agb.1176354387060;
        Wed, 11 Apr 2007 22:06:27 -0700 (PDT)
Received: by 10.90.120.11 with HTTP; Wed, 11 Apr 2007 22:06:27 -0700 (PDT)
In-Reply-To: <461DBBA0.3070609@vilain.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44321>

On 4/12/07, Sam Vilain <sam@vilain.net> wrote:
> I sent a patch for 'git remote prune -c' recently that would help in the
> transition between the two remotes formats.

Good one. BTW, if you are hacking git-remote, it's missing a "delete"
command ;-)



m
