From: Bo Yang <struggleyb.nku@gmail.com>
Subject: Re: Re: git log -M -- filename is not working?
Date: Wed, 12 May 2010 22:49:03 +0800
Message-ID: <AANLkTikhJO7MI9c5KezktpcMoQ86JPzAr4iT6_Yt2Ms3@mail.gmail.com>
References: <z2w76c5b8581005071107w79d30963g725269febe746f0@mail.gmail.com>
	 <20100508044434.GC14998@coredump.intra.peff.net>
	 <19428.62170.654092.308682@winooski.ccs.neu.edu>
	 <20100508053025.GG14998@coredump.intra.peff.net>
	 <7v39y3c5p1.fsf@alter.siamese.dyndns.org>
	 <19429.3589.823244.270582@winooski.ccs.neu.edu>
	 <20100512113855.GB23847@coredump.intra.peff.net>
	 <19434.39095.448649.313537@winooski.ccs.neu.edu>
	 <AANLkTin0E9rd7Ld3exCA5NbGnYhlspUZ93KT1O6Zvzrq@mail.gmail.com>
	 <19434.48712.225245.305483@winooski.ccs.neu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Eugene Sajine <euguess@gmail.com>,
	Jacob Helwig <jacob.helwig@gmail.com>, git@vger.kernel.org
To: Eli Barzilay <eli@barzilay.org>
X-From: git-owner@vger.kernel.org Wed May 12 16:49:14 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OCDFJ-0005L4-Gk
	for gcvg-git-2@lo.gmane.org; Wed, 12 May 2010 16:49:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755709Ab0ELOtG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 May 2010 10:49:06 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:54728 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755989Ab0ELOtE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 May 2010 10:49:04 -0400
Received: by gwj19 with SMTP id 19so40402gwj.19
        for <git@vger.kernel.org>; Wed, 12 May 2010 07:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=J0X3RdTxtvuYrp371Kfb3OUz6pn2ljNkTS55V0UMwic=;
        b=dwXsaRCGvgJN0fThH0l3ndZSsV7CjYUBJxhQYeBLo9l76uIsaqr6Ol6VgsOtDo83xz
         sMzIGcb3xWPWQPCBL6K97a3NcGtyjVw0ZQr0C/DmsSd2+3izq9xTWLm0ZEbpHaIbH8Oz
         LLS6UVa5C3SVHOjYsxh/lBKAv8v1Kx/A6a2No=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=BIcwWxtcjE1qFtMbQUut41HQAmSBQvjRc5vD8Aan+slXva0+tobSV4Ef7aMiOhJJC4
         VjyqFZcL6vv6zb4/6/WSaa9Yq/QcMUM1CjvsoZXddN80KE6tmV73T93nQwTus62ebFQw
         Nvc6DhwQtDXsJgilrVBq4Had4EDbagfbVuOEA=
Received: by 10.229.190.83 with SMTP id dh19mr664372qcb.155.1273675743626; 
	Wed, 12 May 2010 07:49:03 -0700 (PDT)
Received: by 10.229.97.80 with HTTP; Wed, 12 May 2010 07:49:03 -0700 (PDT)
In-Reply-To: <19434.48712.225245.305483@winooski.ccs.neu.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146952>

Hi,
On Wed, May 12, 2010 at 10:42 PM, Eli Barzilay <eli@barzilay.org> wrote:
> (Looking at the description (in the SoC2010Ideas page) it wasn't clear
> to me whether this will be simple to use as log -- that is, just run
> some `git foo dir/{x,y,z}' or `git foo dir'.)

The idea here is that line level history will trace rename/copies of
multiple files and trace rename/copies of multiple files is obviously
a subset of tracing of it. So, what I mean is along implement such a
line level browser, I can do the --follow files case very well. :)

And as Jeff said in his mail, his implementation is necessary in speed
and please still use 'git log --follow -- pathspec' for whole file
history traversing.

Regards!
Bo

-- 
My blog: http://blog.morebits.org
