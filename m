From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [StGIT PATCH 1/5] Allow stack.patchorder.all to return hidden patches
Date: Thu, 5 Jun 2008 12:46:01 +0100
Message-ID: <b0943d9e0806050446w27fc5482i9e96a0f5201586c@mail.gmail.com>
References: <20080604210655.32531.82580.stgit@localhost.localdomain>
	 <20080604211316.32531.84226.stgit@localhost.localdomain>
	 <20080605064152.GA23209@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
X-From: git-owner@vger.kernel.org Thu Jun 05 13:46:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4Dvn-000070-H2
	for gcvg-git-2@gmane.org; Thu, 05 Jun 2008 13:46:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755547AbYFELqG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Jun 2008 07:46:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755215AbYFELqF
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jun 2008 07:46:05 -0400
Received: from py-out-1112.google.com ([64.233.166.177]:29835 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753390AbYFELqC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 Jun 2008 07:46:02 -0400
Received: by py-out-1112.google.com with SMTP id p76so440672pyb.10
        for <git@vger.kernel.org>; Thu, 05 Jun 2008 04:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=k5B3iT3jT1W8fBHJwslCNTUI3n+DDrqEd/hBCR91ShY=;
        b=fN8I1Plr0+eM+dOHcrAbjAGW3/ApXX+dOFgpEwBMaTjPpJmTdXRJtFPQ0dU60wf96e
         HFdwV/GslZSVYkg3v0OVIRB5BL0XrNjnaj2EoKHQC5lxz0otDZrn1Sh/38A//AJrLsiw
         EG40xH2ICUH16mj3PTvmvQEBfbygwmJJ7tgc4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=Y8Hxr5Xl/LSg1JWspE601TONcAHB8ETRfpXFpITbCUF4Kf61wSLSznuEM5yJxF1+EG
         fX4sJfU4JF26zuLYsX/CA1XsYGpoledwjihnb+yXNmAPvteJpWkrgkc0FQoaTo3hrTxd
         /5bsJQUORMsIUZ4wwebPe5M84vhFuUn1lsyr8=
Received: by 10.114.168.1 with SMTP id q1mr1336417wae.72.1212666361690;
        Thu, 05 Jun 2008 04:46:01 -0700 (PDT)
Received: by 10.114.171.16 with HTTP; Thu, 5 Jun 2008 04:46:01 -0700 (PDT)
In-Reply-To: <20080605064152.GA23209@diana.vm.bytemark.co.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83907>

2008/6/5 Karl Hasselstr=F6m <kha@treskal.com>:
> On 2008-06-04 22:13:17 +0100, Catalin Marinas wrote:
>>          if bad:
>>              raise common.CmdException('Bad patch names: %s'
>
> Forbidding commit to operate on hidden patches? OK, why not? But
> saying "Bad patch name" if the user gives a hidden patch is probably =
a
> bit on the grumpy side ... :-)

OK. Changed it to "Nonexistent or hidden patch names". Could be done
better but I wouldn't bother too much with this error.

--=20
Catalin
