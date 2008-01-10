From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: Decompression speed: zip vs lzo
Date: Thu, 10 Jan 2008 13:18:44 +0100
Message-ID: <e5bfff550801100418p542ae424l5fc049e0b56ef293@mail.gmail.com>
References: <e5bfff550801091401y753ea883p8d08b01f2b391147@mail.gmail.com>
	 <7v4pdmfw27.fsf@gitster.siamese.dyndns.org>
	 <47855765.9090001@vilain.net>
	 <alpine.LSU.1.00.0801092328580.31053@racer.site>
	 <alpine.LFD.1.00.0801092234130.3054@xanadu.home>
	 <e5bfff550801092255wc852252m9086567a88b1ae99@mail.gmail.com>
	 <e5bfff550801100345i20cb3030mf04a11d610fda6f7@mail.gmail.com>
	 <alpine.LSU.1.00.0801101210031.31053@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Nicolas Pitre" <nico@cam.org>, "Sam Vilain" <sam@vilain.net>,
	"Git Mailing List" <git@vger.kernel.org>,
	"Junio C Hamano" <gitster@pobox.com>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jan 10 13:19:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JCwNP-0004Fd-5Z
	for gcvg-git-2@gmane.org; Thu, 10 Jan 2008 13:19:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753489AbYAJMSr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jan 2008 07:18:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753408AbYAJMSr
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Jan 2008 07:18:47 -0500
Received: from py-out-1112.google.com ([64.233.166.179]:64092 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753362AbYAJMSq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jan 2008 07:18:46 -0500
Received: by py-out-1112.google.com with SMTP id u52so990034pyb.10
        for <git@vger.kernel.org>; Thu, 10 Jan 2008 04:18:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=mE14jeCa7QADFkz8LW9bOWhumaqhCWm47P3x+DKceqw=;
        b=JjT89Mi4TxRi7/QV9kl8Ox32kOR4Kl9Nk9Z4ofZXAgw0ND4f+yWlSGgsfokEgXHkUGkEj9gf+2TxfYSIyTH7XEXJnV7fqCBg8j4FVJr13feAWe2ZaqqV8PRxXa2EXzwxtq6KpRHvj23ftwYHxFedeRvtYlA70Ts1D6Qsn4fF208=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=WeYVPmAev8iP/6IulrcW1kByzhV97c7bOTJap5R/FW51w7JMrYdBlAMhw73qaZfQjtk3JKHRxFjk9dxgdmlKVye28UIKjnZGiYpginH62zDPLiBwznLlFAU1zeIsBOOql4lrb/kMTdek9gfJdEYEdymsWUhDUkXN5e5O34ojB58=
Received: by 10.140.251.1 with SMTP id y1mr1139496rvh.102.1199967524979;
        Thu, 10 Jan 2008 04:18:44 -0800 (PST)
Received: by 10.141.76.1 with HTTP; Thu, 10 Jan 2008 04:18:44 -0800 (PST)
In-Reply-To: <alpine.LSU.1.00.0801101210031.31053@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70064>

On Jan 10, 2008 1:12 PM, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Thu, 10 Jan 2008, Marco Costalba wrote:
>
> > - Remove #include <zlib.h> from cache.h and substitute with #include
> > "compress.h"
>
> No.  We will always need zlib for compatibility.  You cannot just replace
> zlib usage in git.
>

Ok. This was just to check what is broken by removing zlib.h so that
I'm sure to renaming all the zlib related stuff.

But I agree this is most a development detail and I can do this just
in my private tree to help me hacking the patches.

Thanks
Marco
