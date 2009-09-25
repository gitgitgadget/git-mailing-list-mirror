From: Howard Miller <howard@e-learndesign.co.uk>
Subject: Re: How does gitosis know who the key belongs to
Date: Fri, 25 Sep 2009 09:31:46 +0100
Message-ID: <26ae428a0909250131k5fb04637ndbe765dce5afcc63@mail.gmail.com>
References: <26ae428a0909240751k3a799750h121935a79439b389@mail.gmail.com>
	 <20090924172610.GA31309@book.hvoigt.net>
	 <vpqskeckuto.fsf@bauges.imag.fr>
	 <26ae428a0909242310r259ccf5eya7c95b8f43fc5c23@mail.gmail.com>
	 <26ae428a0909242315x3cf1aafcue004a73f5c471450@mail.gmail.com>
	 <vpqhburigfs.fsf@olympe.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Heiko Voigt <hvoigt@hvoigt.net>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Sep 25 10:31:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mr6Da-0004jz-3y
	for gcvg-git-2@lo.gmane.org; Fri, 25 Sep 2009 10:31:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752602AbZIYIbp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Sep 2009 04:31:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752548AbZIYIbo
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Sep 2009 04:31:44 -0400
Received: from mail-ew0-f211.google.com ([209.85.219.211]:44409 "EHLO
	mail-ew0-f211.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752540AbZIYIbn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Sep 2009 04:31:43 -0400
Received: by ewy7 with SMTP id 7so2362283ewy.17
        for <git@vger.kernel.org>; Fri, 25 Sep 2009 01:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type;
        bh=wSjQuzDjMMjbUOZ1qa9CVhSIKRhxDkLQtmbTFoX3OVw=;
        b=EHcYMR12yhBwaPg7M0+wK7aLTm7/eu0DefFj9Eewxg/5gUx/3ULk/kzO4KcmepfmkF
         0KjJXpGUoMHzA5Sq7e91pPqwBkS7lIHYTcGz8wmEwnF6tf57ZCM6tgZQot3LvwWDIVyL
         PYX9z7WFF0C7wRDtX/Usrfvi1/RZKsQBddy2Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        b=JIP4z/PbTLsfqTp4rlZfuG8J0+mnW61xXatUnctY5UzenLQ6OC1duwq/N9NNObDay8
         RMGop5ljkbmH8p4ObCzHvu95KWHUwXpK1nRE3B2UaF6vlQS3pUuZjFyFi7/EGF6iNSLu
         EMy4egKsGSFCyeNpn2Gw7GuBssyTqrgL+Ztqk=
Received: by 10.216.87.140 with SMTP id y12mr1022549wee.4.1253867506789; Fri, 
	25 Sep 2009 01:31:46 -0700 (PDT)
In-Reply-To: <vpqhburigfs.fsf@olympe.imag.fr>
X-Google-Sender-Auth: cb181281ba845aa0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129069>

>
> If you're confused with "name", then just think about "filename
> holding the key".
>
> If you want to name yourself "howard", then put your key in
> keydir/howard and then use "howard" in the config file. gitosis will
> add the relevant
>
> command="gitosis-server howard" ssh-whatever <your-key-here> <irrelevant-comment>
>
> to the ~git/.ssh/auhtorized_keys file.
>
> You chose your "name" by chosing the filename, then you use this name
> in the config file, and then gitosis does the job.

Ok... so is it completely ignoring the @host bit then? None of my
public key files are called howard@host1.pub (for example).

Just so you don't think I'm completely crazy, I actually use three
different machines for development and (of course) I'm 'howard' on all
of them. I was trying to get my head around the best way to set it up.
I wasn't clear if I could simply recycle the same public key or if I
needed to be three different users in gitosis.

Cheers.... Howard
