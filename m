From: "Jakub Narebski" <jnareb@gmail.com>
Subject: Re: best git practices, was Re: Git User's Survey 2007 unfinished summary continued
Date: Thu, 25 Oct 2007 01:48:12 +0200
Message-ID: <8fe92b430710241648j609d4d00x121836001a69d1e6@mail.gmail.com>
References: <Pine.LNX.4.64.0710212308540.25221@racer.site>
	 <471C9B13.9080603@op5.se>
	 <Pine.LNX.4.64.0710221445170.25221@racer.site>
	 <471CB443.9070606@op5.se>
	 <8fe92b430710221635x752c561ejcee14e2526010cc9@mail.gmail.com>
	 <92320AA3-6D23-4967-818D-F7FA3962E88D@zib.de>
	 <Pine.LNX.4.64.0710231155321.25221@racer.site>
	 <90325C2E-9AF4-40FB-9EFB-70B6D0174409@zib.de>
	 <20071024192058.GF29830@fieldses.org> <471F9FD1.6080002@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "J. Bruce Fields" <bfields@fieldses.org>,
	"Steffen Prohaska" <prohaska@zib.de>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Federico Mena Quintero" <federico@novell.com>, git@vger.kernel.org
To: "Andreas Ericsson" <ae@op5.se>
X-From: git-owner@vger.kernel.org Thu Oct 25 01:48:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ikpxa-0003iv-7S
	for gcvg-git-2@gmane.org; Thu, 25 Oct 2007 01:48:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755374AbXJXXsO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Oct 2007 19:48:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755334AbXJXXsO
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Oct 2007 19:48:14 -0400
Received: from wa-out-1112.google.com ([209.85.146.183]:35618 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755274AbXJXXsN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Oct 2007 19:48:13 -0400
Received: by wa-out-1112.google.com with SMTP id v27so424693wah
        for <git@vger.kernel.org>; Wed, 24 Oct 2007 16:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=WYs4iekXr7xDQ83RBVzH9dkjIdsQyQVXPwuvPEuO308=;
        b=AsF2vd4VDDs3ql2l60aDZSbf7PWyUNiwRo7CFHGsdSM6DHEBfvBRpMzYLrTq2/IlpeE1Qw3vqOctDhnsyZ4cnNUBcpEj+SGmG1GwvI13dbdRYO7nzRQpBq+Am6umnTVzinSq/WGXiWwu90y+ihxCyl8LTaMZ4zL3LKI9+OmbEfA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=qe/aVJo8YJX/bzyQzoyn0tMjfSn/kWzJhoNFnI75W2sOM/6Z84xnO2i2PsG61BYO3yrbNcsIDyScey1gUzs0KQNkYx9e/HFbXvop3EnkEydRpLOnxijn/0bUVEKYyBrhnVX+qxWX47I9AxG0ecs2Rtc12eJxCoQhAWb/OpK3z+o=
Received: by 10.114.166.1 with SMTP id o1mr1313397wae.1193269692333;
        Wed, 24 Oct 2007 16:48:12 -0700 (PDT)
Received: by 10.114.195.16 with HTTP; Wed, 24 Oct 2007 16:48:12 -0700 (PDT)
In-Reply-To: <471F9FD1.6080002@op5.se>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62255>

On 10/24/07, Andreas Ericsson <ae@op5.se> wrote:

> git pull. Not git push. git pull operates on one working branch
> at a time (by default), whereas git push uploads and fast-forwards
> all the common branches (by default). I want git pull to work like
> git push.

git push is opposite (almost) to git fetch, not to git pull.

-- 
Jakub Narebski
