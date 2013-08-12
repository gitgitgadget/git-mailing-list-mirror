From: Andrew Ardill <andrew.ardill@gmail.com>
Subject: Re: git should not use a default user.email config value
Date: Mon, 12 Aug 2013 21:52:45 +1000
Message-ID: <CAH5451nHfOaBzFzkrGvw+TyRj==cVpKF_QdXsTxnn5tTr1c0dw@mail.gmail.com>
References: <20130809134236.28143.75775.reportbug@tglase.lan.tarent.de>
 <20130809194214.GV14690@google.com> <20130809223758.GB7160@sigill.intra.peff.net>
 <20130809231928.GY14690@google.com> <20130810064717.GB30185@sigill.intra.peff.net>
 <52060EF9.2040504@alum.mit.edu> <7vvc3d1o01.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>, Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Thorsten Glaser <tg@mirbsd.de>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 12 13:53:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V8qgk-0005Dh-Bv
	for gcvg-git-2@plane.gmane.org; Mon, 12 Aug 2013 13:53:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756011Ab3HLLx0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Aug 2013 07:53:26 -0400
Received: from mail-vb0-f44.google.com ([209.85.212.44]:45141 "EHLO
	mail-vb0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755253Ab3HLLxZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Aug 2013 07:53:25 -0400
Received: by mail-vb0-f44.google.com with SMTP id e13so5648428vbg.31
        for <git@vger.kernel.org>; Mon, 12 Aug 2013 04:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=/B7j5j4G+TdRo1gUj+slo/p18Apbnc0FIADKR0JnaxI=;
        b=vL3YczcmRLX5WXpEqb8EFxxTZl9Ys3BVcvQrfnCaOx4wLlsTHtxk7a/sm1optUIMYe
         AHKxeekAdjpiwJCpQCcpkbbN5NiyTzQaplz1JFANRIMXgDoIVdnZZbXATgSGV4fp9BUm
         /Tg2CejuwAr3tZwPJbhdYm1y5EovH0QqrJNg5BEVCigdn7WGuzR32OfUQ8E/Q/0N/MvC
         siXdHUlua6ZvMhl7VxqDFmYhXcFbTJJhAeGOAfOFBBlY2pkNJLlVTM79R4ZsMMbUdPLo
         3JmM2Zp33Si2srQ95uthke8fDGVgbHHXlzi/JJaRn/DNOL4smUqLiiZvfvi2ad5bxVc6
         fmAA==
X-Received: by 10.52.115.102 with SMTP id jn6mr5287920vdb.18.1376308405125;
 Mon, 12 Aug 2013 04:53:25 -0700 (PDT)
Received: by 10.220.195.133 with HTTP; Mon, 12 Aug 2013 04:52:45 -0700 (PDT)
In-Reply-To: <7vvc3d1o01.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232184>

On 11 August 2013 02:58, Junio C Hamano <gitster@pobox.com> wrote:
> Perhaps we need a lighter-weight mechanism
>
>         git init --profile=open
>         git clone --profile=open git://git.kernel.org/git.git

This is something I would definitely use.

All of my work git directories are in a separate folder to my other
git directories, and as such it would be extremely convenient if every
repository under that folder defaulted to the same profile. That may
be asking for too much though!

Regards,

Andrew Ardill
