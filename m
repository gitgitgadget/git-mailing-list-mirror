From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: Git terminology: remote, add, track, stage, etc.
Date: Wed, 27 Oct 2010 20:33:19 +0530
Message-ID: <20101027150314.GB1136@kytes>
References: <8835ADF9-45E5-4A26-9F7F-A72ECC065BB2@gmail.com>
 <AANLkTimkovH9OysLSxA+=di89Xi+dTCYL5hRPmNaADDH@mail.gmail.com>
 <20101019175103.GA28847@kytes>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thore Husfeldt <thore.husfeldt@gmail.com>, git@vger.kernel.org,
	Scott Chacon <schacon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 27 17:03:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PB7Xb-0005pW-9C
	for gcvg-git-2@lo.gmane.org; Wed, 27 Oct 2010 17:03:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756870Ab0J0PDq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Oct 2010 11:03:46 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:60965 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752013Ab0J0PDp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Oct 2010 11:03:45 -0400
Received: by gxk23 with SMTP id 23so439396gxk.19
        for <git@vger.kernel.org>; Wed, 27 Oct 2010 08:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=xTEU5RgflG/3J8udj2VwXSt1sIi3gr8gA23fnbuRGXs=;
        b=ZY/l5wc2X33b6t3ld2kq4JGV4+dWPxEoUqbCWXrwmvPZ4fWigtFuoGYQmIA8/EtZEr
         9DiIsDUxhJ/C5OAYO/aBV4PQyZpxTcC2KeiFYxsImPIeoue67Ci98m7TKtIFfMede5xJ
         jMZPPKOyNaNLyqOrgQ3wXYV7Jzjvz7FGPCIRU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=V3gDPOEUch9esYTTM/yyPCeOZoT3nZwwITwzmFjqfsmOP6HeEaQU8swdbR8KOELjIv
         W75pbO7huk79t4tv2X/jMo/pdxc7wYPEh4rgmqOyyJrRsnAWIOW8ZIlXFC4zfNvo/rFA
         cFbHXEw22AsqasScwoO/H6K0RmVNuHGoxa9CE=
Received: by 10.151.42.9 with SMTP id u9mr13115071ybj.418.1288191824365;
        Wed, 27 Oct 2010 08:03:44 -0700 (PDT)
Received: from kytes ([203.110.240.41])
        by mx.google.com with ESMTPS id p30sm8788099ybk.8.2010.10.27.08.03.38
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 27 Oct 2010 08:03:42 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20101019175103.GA28847@kytes>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160083>

Hi,

Ramkumar Ramachandra writes:
> From a863e58d240956191c2fa9cbe992aaca5786730b Mon Sep 17 00:00:00 2001
> From: Ramkumar Ramachandra <artagnon@gmail.com>
> Date: Tue, 19 Oct 2010 22:42:05 +0530
> Subject: [PATCH] Documentation: Consistently use the hyphenated "remote-tracking"
> 
> Replace instances of the term "remote tracking" with "remote-tracking"
> in the documentation for clarity.
> 
> Reported-by: Thore Husfeldt <thore.husfeldt@gmail.com>
> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>

and

> From 7422c2af1ef40c922d8f628715ad96172e4a5734 Mon Sep 17 00:00:00 2001
> From: Ramkumar Ramachandra <artagnon@gmail.com>
> Date: Tue, 19 Oct 2010 23:16:04 +0530
> Subject: [PATCH] UI: Don't say "working directory" when we really mean "working tree"
> 
> While in some places "working directory" is used to refer to the
> (current) working directory, it's incorrectly used in places where Git
> actually means "working tree" or worktree. Weed out and replace these
> instances in the UI.
> 
> Reported-by: Thore Husfeldt <thore.husfeldt@gmail.com>
> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>

Junio: Are these patches suitable for inclusion?

-- Ram
