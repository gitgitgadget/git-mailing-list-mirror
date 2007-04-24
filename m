From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: What's cooking in git.git (topics)
Date: Tue, 24 Apr 2007 18:14:31 +0200
Message-ID: <81b0412b0704240914o1096476dn7f26210be987e3fd@mail.gmail.com>
References: <7vodly0xn7.fsf@assigned-by-dhcp.cox.net>
	 <7v647tcjr6.fsf@assigned-by-dhcp.cox.net>
	 <7vejmdq63w.fsf@assigned-by-dhcp.cox.net>
	 <7v647ninbq.fsf@assigned-by-dhcp.cox.net>
	 <81b0412b0704231007i81ee20cx9a37f1c8a3df62b1@mail.gmail.com>
	 <7vvefnf1wb.fsf@assigned-by-dhcp.cox.net>
	 <20070423211658.GA21404@steel.home>
	 <7v4pn6ep41.fsf@assigned-by-dhcp.cox.net>
	 <81b0412b0704240858w6121430fj624582539f14ceee@mail.gmail.com>
	 <Pine.LNX.4.64.0704241802420.6954@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <junkio@cox.net>, git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Apr 24 18:14:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HgNf1-00048U-UM
	for gcvg-git@gmane.org; Tue, 24 Apr 2007 18:14:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161806AbXDXQOd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Apr 2007 12:14:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161816AbXDXQOd
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Apr 2007 12:14:33 -0400
Received: from wx-out-0506.google.com ([66.249.82.234]:13744 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161806AbXDXQOc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Apr 2007 12:14:32 -0400
Received: by wx-out-0506.google.com with SMTP id h31so2253010wxd
        for <git@vger.kernel.org>; Tue, 24 Apr 2007 09:14:32 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=nNLRX5SA9xh4z4dVcf8UR52t6Ox3MCpW8+Rf89QrGKmK6CzLnFwLJ381ocbhNH+1BmUnvpVVTJZ8UDxKFalvARhk303/DJTG3/EiwpERmCmtE2eFBNXOb5Xtu9tgd5Kr7cAHWHQ0Nn8aMY2u1buOlruvEXlLN5XNc4fwt3wcSA8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=a9k46dSCKVM0Ejt4MuC06h/v+vZ8x74OwAtkb+45t7/bYj8ak668nagIKw98lNitkgYBdx6U296XzECjGeUYYFCTSj68zxrSGiIyo4xx/IFU0atlTboWnqnKWY5ykSB/dhKBhYMn1kiRCTPTcvRFB+ftyypdjpuk7es0YAaDmnk=
Received: by 10.90.56.14 with SMTP id e14mr6258740aga.1177431271948;
        Tue, 24 Apr 2007 09:14:31 -0700 (PDT)
Received: by 10.100.86.19 with HTTP; Tue, 24 Apr 2007 09:14:31 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0704241802420.6954@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45464>

On 4/24/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> >
> > which will be a PITA to setup in each and every clone of the
> > repository, unless it is cloned with the repo.
>
> Not if you do it with templates. If it is such a special case that you
> absolutely _need_ filters, and cannot use it without filters, it is
> probably in a very small group. And there, you just setup the templates,
> and voila: you have your filters without much ado.

It can be a very big group. Than, even if it is the only group in the world,
it can complain loud and long enough to become a major annoyance.
