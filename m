From: "Lars Hjemli" <hjemli@gmail.com>
Subject: Re: Is there any plan to support partial checkout or submoudule improvement?
Date: Tue, 16 Oct 2007 10:42:39 +0200
Message-ID: <8c5c35580710160142x1f699208gfc226072a27e997a@mail.gmail.com>
References: <8c5c35580710160108s4faeaa61k7585d01703c0c8fc@mail.gmail.com>
	 <20071016082720.E5EDA7E6F@mail.kooxoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: franky <yinping@kooxoo.com>
X-From: git-owner@vger.kernel.org Tue Oct 16 10:44:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ihi12-0007QR-0U
	for gcvg-git-2@gmane.org; Tue, 16 Oct 2007 10:43:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932431AbXJPImv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2007 04:42:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757875AbXJPImv
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Oct 2007 04:42:51 -0400
Received: from wa-out-1112.google.com ([209.85.146.181]:2598 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754415AbXJPImu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2007 04:42:50 -0400
Received: by wa-out-1112.google.com with SMTP id v27so2300025wah
        for <git@vger.kernel.org>; Tue, 16 Oct 2007 01:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=4CAShOS9696BBwHvuZ8GFeL6bheOlt3oYKOUoEfCfIw=;
        b=O6I+0APT5GmoyPFhsIIvggoWCsQJcEp8JcEZxSAskIKcR9m9uMUjYB5lrtU1SEOG9VeTDplD7wSeaxdhUNER12invJq2sR9opOBzn1nel8FFFAuh3EbUjq9mOWskHKRe5t+lVI/wWTflJxUvyPBuG2U30HNN6Xf84WncpvHhtD0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=EnM2ocbrczfqh86vABzWLUgVtjQpajMnWCyNAkxbo84kQA/nANJ7qhPAN4UXna37U1QufEs0Vbjxt1POyFFJLxoAy4a1D3j0i1qBR0foTl3ORmPQLZzKfd0hSb7q1odpSg0yiAjHxvAeGvRfWg1jqSmPrTN1MwPq0I6qLdlgV1Q=
Received: by 10.114.78.1 with SMTP id a1mr8134767wab.1192524169819;
        Tue, 16 Oct 2007 01:42:49 -0700 (PDT)
Received: by 10.114.235.4 with HTTP; Tue, 16 Oct 2007 01:42:39 -0700 (PDT)
In-Reply-To: <20071016082720.E5EDA7E6F@mail.kooxoo.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61118>

On 10/16/07, franky <yinping@kooxoo.com> wrote:
> I want a single "git-pull" to deploy a new version and a
> single "git-reset" to back to versions before

Well, there is always

$ git archive --remote=<repo> <revspec> <path> | tar -x

This is effectively a partial checkout of an arbitrary revision from a
remote repo.

--
larsh
