From: "David Symonds" <dsymonds@gmail.com>
Subject: Re: [PATCH] pretty.c: add %z specifier.
Date: Fri, 21 Mar 2008 16:50:04 +1100
Message-ID: <ee77f5c20803202250w1b1f4228y3613109762c93454@mail.gmail.com>
References: <5d46db230803201745mb736e98w4925e14b5d92d71d@mail.gmail.com>
	 <7veja4u1gv.fsf@gitster.siamese.dyndns.org>
	 <20080321045137.GA5563@coredump.intra.peff.net>
	 <7vtzj0slx4.fsf@gitster.siamese.dyndns.org>
	 <5d46db230803202242j60b0e9f6q798afd6c5f468207@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, "Jeff King" <peff@peff.net>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Govind Salinas" <govind@sophiasuchtig.com>
X-From: git-owner@vger.kernel.org Fri Mar 21 06:51:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jca9i-000330-Ca
	for gcvg-git-2@gmane.org; Fri, 21 Mar 2008 06:51:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753380AbYCUFuI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Mar 2008 01:50:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753379AbYCUFuI
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Mar 2008 01:50:08 -0400
Received: from wf-out-1314.google.com ([209.85.200.170]:19130 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753370AbYCUFuH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Mar 2008 01:50:07 -0400
Received: by wf-out-1314.google.com with SMTP id 28so1348237wff.4
        for <git@vger.kernel.org>; Thu, 20 Mar 2008 22:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=kLoADnjOfx5SPWkyZLSjFu4h2PV7ItPvpT0RuZlYzKo=;
        b=IO609y6N5CoLpkUyOX33TnEdy/QtubMBiU1/NRM/bnqyYYyIvWsGGr8eusA9igOkAU5KebRh6fzl1Z9GKpXpqdZcQcacbQnVDdlu/UAlLVdhdXniF5UmiRoYAOcxT7dXDKFHCxiKamnRHXmSGVhRXIdXAsJwTlDcTCqAOaUKVCI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=gD7xyhpbL4Cmb+OucGR4il5NrumMj8hh1A+/5GKfLTt/QizJXjny7RchnMRbo3I2Rw3E84XHYwK5+HZ+puDusExG/vsuaHZ2EbF5Co7RgpCNqupyFOU22pv0eOK2zFe6XVxYSaFHVsjjD/36dc43xmbJgjp6Ndvf50WDQtlnRa4=
Received: by 10.142.11.2 with SMTP id 2mr2072029wfk.223.1206078604873;
        Thu, 20 Mar 2008 22:50:04 -0700 (PDT)
Received: by 10.142.173.10 with HTTP; Thu, 20 Mar 2008 22:50:04 -0700 (PDT)
In-Reply-To: <5d46db230803202242j60b0e9f6q798afd6c5f468207@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77718>

On Fri, Mar 21, 2008 at 4:42 PM, Govind Salinas
<govind@sophiasuchtig.com> wrote:
>
>  Sorry, I'm a bit confused.  Should I alter the patch to use a different code
>  for null, that would be fine by me?  The above seems to be an unrelated issue.

I'm pretty sure the suggestion is that you should change the patch to
allow for *any* specific byte value, where the null byte is just a
special case. %x00 would be used instead of %z, in other words, and
%x20 would be a space character, etc.


Dave.
