From: Aghiles <aghilesk@gmail.com>
Subject: Re: git pull opinion
Date: Tue, 6 Nov 2007 02:45:13 -0500
Message-ID: <3abd05a90711052345v7cc74524g588e03c0c1a93c68@mail.gmail.com>
References: <3abd05a90711051352t2f6be00bsa862585abd370fb1@mail.gmail.com>
	 <20071105234049.GA31277@genesis.frugalware.org>
	 <3abd05a90711052016s615cd66cy5a5f932900d89143@mail.gmail.com>
	 <176851C5-D735-4DDC-B799-A5106CD03989@lrde.epita.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "git list" <git@vger.kernel.org>
To: "Benoit Sigoure" <tsuna@lrde.epita.fr>
X-From: git-owner@vger.kernel.org Tue Nov 06 08:45:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpJ7s-00047x-3t
	for gcvg-git-2@gmane.org; Tue, 06 Nov 2007 08:45:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754504AbXKFHpS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Nov 2007 02:45:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754462AbXKFHpR
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Nov 2007 02:45:17 -0500
Received: from nf-out-0910.google.com ([64.233.182.189]:53794 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751938AbXKFHpP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Nov 2007 02:45:15 -0500
Received: by nf-out-0910.google.com with SMTP id g13so1604814nfb
        for <git@vger.kernel.org>; Mon, 05 Nov 2007 23:45:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=gWEDR42YaulWNQemdfdTW1kAncBO9SwUyydZOx7F99o=;
        b=ZCHwJNC1CKFW8FMPdN3jZUiiqJM5PHPzXRPA7YDm8WBEqpPw39bEc9lwJWGcBVtJb6CAJ9cB2R34jKLCzv1BFy6zVcVzlZFUfqeXjtmrh+MXiBjmUAGkb8tFO5PS/TnO6bI9HTuRHOj2P4uZFKo/uwxFk7QeIIrE7Dk0SuCgh1o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=IFP6nG7Vw2tlof1v/pymMo8p9Bi/EBXeu12DmA4+WGRbTn7ab7R85eXQ8Bb1EazsccaxnDJlSBj9P7QHJVsajUzWO6oihgddL1DcQfGJhN2+JLGG3j5crpU5rHv9Bm1Bz3bXCIt/P4Wphbh7ODUQEsQ0MaiukxPTMgfzItjNCsA=
Received: by 10.78.185.15 with SMTP id i15mr4563388huf.1194335113512;
        Mon, 05 Nov 2007 23:45:13 -0800 (PST)
Received: by 10.78.185.1 with HTTP; Mon, 5 Nov 2007 23:45:13 -0800 (PST)
In-Reply-To: <176851C5-D735-4DDC-B799-A5106CD03989@lrde.epita.fr>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63635>

Hello,

> As far as I remember, a patch was proposed to change this mis-
> behavior of "git stash" (one could argue that it's a PEBCAK issue,
> but I really think this command is *way* too dangerous) but I don't
> think it's been accepted at this time.

I think that people will use this a lot with the pull command and some
accidents will happen.  I am of the opinion that the semantics of this
command must be  changed.
Additionally, having "git stash [command]" and "git stash [argument]"
mixed together seems strange. One suggestion would be:

    git stash store/add/create [stash-name]
    git stash apply [stash-name]
    git stash clear <stash-name>  (accepts wildcards but no empty args)
    ...

- Aghiles.
