From: "Dmitry Kakurin" <dmitry.kakurin@gmail.com>
Subject: Re: Windows support
Date: Wed, 25 Jul 2007 20:54:12 -0700
Message-ID: <a1bbc6950707252054p21c48458j5e285604ff8884a5@mail.gmail.com>
References: <a1bbc6950707250335m3d37d4farceffc50945e31f6c@mail.gmail.com>
	 <fcaeb9bf0707250513v587d7a92lb688b52da3c28bb7@mail.gmail.com>
	 <a1bbc6950707251926t11e1d0f7p8e8cd8c936f7ff72@mail.gmail.com>
	 <Pine.LNX.4.64.0707260438210.14781@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>, git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jul 26 05:54:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDuQl-0004QS-Su
	for gcvg-git@gmane.org; Thu, 26 Jul 2007 05:54:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756970AbXGZDyN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 Jul 2007 23:54:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757032AbXGZDyN
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jul 2007 23:54:13 -0400
Received: from rv-out-0910.google.com ([209.85.198.190]:64597 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755772AbXGZDyM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jul 2007 23:54:12 -0400
Received: by rv-out-0910.google.com with SMTP id k20so17016rvb
        for <git@vger.kernel.org>; Wed, 25 Jul 2007 20:54:12 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=EoD9elRPOs0fOYyUhEufrGOTs+EGB8z1MA8URTIqw3jkULzuTH8/oQf9q9kfFS2imGbiKUKi+yNJcA3HnNDEa1J3g2TxlRf06IEKGanrp7dckLSWdRg5Gac+/UcpuL6dpDzjbugQBASH3EdECEZWfX/wBjlP5uHPu2TKpWUqE4I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=LPIrcm2StYcsUsEg/hLnvOrOP57ClHnDbGNJzw5lFutyb+X6jhHQRqsl+SbZQNUB3eClwyLR+2+sBkkZEMh22ABfLR2iLquEEnUsXeOWokPIJZVO5gryBg1imcq9ODTkoWzkWT7cA1mlChYJnhwEKg2r9+sthQ+uql/9GaGc1sw=
Received: by 10.141.167.5 with SMTP id u5mr426963rvo.1185422052274;
        Wed, 25 Jul 2007 20:54:12 -0700 (PDT)
Received: by 10.141.2.18 with HTTP; Wed, 25 Jul 2007 20:54:12 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0707260438210.14781@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53759>

On 7/25/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > On 7/25/07, Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
> > > What features is mingw port missing?
> > Well, 'git commit' from a regular cmd prompt does not work.
> > IMHO, That's a pretty serious omission  :-).
> Not true.

Well, repro is very simple:
* Follow instructions on Git Wiki and install Git from
http://lilypond.org/git/binaries/mingw/
* run git commit:
E:\Git\usr\bin>git commit
git: 'commit' is not a git-command

I've tried on both Win XP and Vista machines.

- Dmitry
