From: =?UTF-8?B?QW5kcsOpcyBTaWNhcmQtUmFtw61yZXo=?= <asr@eafit.edu.co>
Subject: Re: make profile issue on Git 2.1.0
Date: Tue, 19 Aug 2014 10:33:34 -0500
Message-ID: <CAOUWSGDYwMUL4_w8NNMYJCeC-r9AMMzCTmZ-8sEagdjHJOENYQ@mail.gmail.com>
References: <CAOUWSGA+6gX8ZBv3Wo8FgUdyd99TYWOybTwGT6ADv_HtNFsFMQ@mail.gmail.com>
 <20140819061203.GA14924@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Andi Kleen <ak@linux.intel.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Aug 19 17:34:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XJlQT-00031n-3X
	for gcvg-git-2@plane.gmane.org; Tue, 19 Aug 2014 17:34:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753278AbaHSPeP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 19 Aug 2014 11:34:15 -0400
Received: from mail-yh0-f54.google.com ([209.85.213.54]:55303 "EHLO
	mail-yh0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752941AbaHSPeO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Aug 2014 11:34:14 -0400
Received: by mail-yh0-f54.google.com with SMTP id v1so5903455yhn.13
        for <git@vger.kernel.org>; Tue, 19 Aug 2014 08:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=iDHKw7rjWLk5Own2gzdAYVfO6jDJd+PqZ/YrEwB9GU4=;
        b=R/lnxHH/yM0GWtnSEEGbqUn1LuzUWuKc1j+gpnFgL/aDiMktEHONPvqq7pv2hR0ZUb
         7o/YqpxBiOeX8aCJiaZqnKL/TxE6RDQ5jpEwC1Icz+4d4+xTLqFToETTQmwz4wvJzaBI
         ytfEtBId/pLfCJCELqoaumUeike7rc6WTgoL0p3jMLl716vgns3QX87otNDSa4OvcclF
         FmuN8XIkUYt1chsBCdhgr03hCnso3uNjBTYf1vJ1XTJr+kKcvyBVklSnP5Mxqf25RozK
         4vpQk7rW8NZFleoUnYL4fkCDeVLWkyYSWU+nRQywrLdoogiV0j3y6ATcQYyOuCQeg6dM
         1qNQ==
X-Received: by 10.236.192.99 with SMTP id h63mr1580951yhn.177.1408462454179;
 Tue, 19 Aug 2014 08:34:14 -0700 (PDT)
Received: by 10.170.91.11 with HTTP; Tue, 19 Aug 2014 08:33:34 -0700 (PDT)
In-Reply-To: <20140819061203.GA14924@peff.net>
X-Google-Sender-Auth: Q0W_bSDrdmRmG4s7VDbkmlPArP4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255461>

On 19 August 2014 01:12, Jeff King <peff@peff.net> wrote:
> This is because v2.1.0 started using "make perf" to feed the profile
> builds, but it doesn't work on tarballs.

Thanks for the explanation.

--=20
Andr=C3=A9s
