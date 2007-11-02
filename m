From: "David Symonds" <dsymonds@gmail.com>
Subject: Re: [PATCH] Mac OS X 10.5 does not require the OLD_ICONV flag set
Date: Fri, 2 Nov 2007 22:23:51 +1100
Message-ID: <ee77f5c20711020423t6ce58818gcc5220b6427ded1@mail.gmail.com>
References: <1193971102-61907-1-git-send-email-blaker@gmail.com>
	 <7v4pg55893.fsf@gitster.siamese.dyndns.org>
	 <ee77f5c20711020319l26b4a8c1r99576dc29ea504d8@mail.gmail.com>
	 <7vbqad3pjw.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Blake Ramsdell" <blaker@gmail.com>, git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 02 12:24:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1InudD-0001ZM-V9
	for gcvg-git-2@gmane.org; Fri, 02 Nov 2007 12:24:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753325AbXKBLXx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Nov 2007 07:23:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753290AbXKBLXx
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Nov 2007 07:23:53 -0400
Received: from rv-out-0910.google.com ([209.85.198.190]:47201 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753270AbXKBLXw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Nov 2007 07:23:52 -0400
Received: by rv-out-0910.google.com with SMTP id k20so776956rvb
        for <git@vger.kernel.org>; Fri, 02 Nov 2007 04:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=VXc2NJi7D8NlQBe4Wqrp6lfYEFs/+WXBcf6Gh+0r2Sw=;
        b=YSvS48a9uJunv1M/W5ZJfcZm1icXtg901rbTjwm+ACcm+/VYc55emisuBVTqzfl7Ru+JmV8sZI7XgmLfk+NUaL2jqKA+CzGMx0smEE06Xx/DyI/y6lW+xDWzpAFGbpgf3bj+PVQBt2X5U6I2/e101G9oJ+p05ONXCa3yhFNnSmw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=L6cLVDFeI1pPhPK06qcff3lwBO3TxB5twKBVVRU/F0Gq9slVC7eaq95irdJ1sUVbFkHlIB5rse8gqe8CgCmXcX9aFIXn1QgS2hMay5fD7HsuWCAjrubGR9gnIRg2kK3dRstGdPrvXXMyZ+E6cA6e7Nf1n+1PEAozRJ/E6z5LqmY=
Received: by 10.141.90.17 with SMTP id s17mr801138rvl.1194002631586;
        Fri, 02 Nov 2007 04:23:51 -0700 (PDT)
Received: by 10.141.115.4 with HTTP; Fri, 2 Nov 2007 04:23:51 -0700 (PDT)
In-Reply-To: <7vbqad3pjw.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63104>

On 11/2/07, Junio C Hamano <gitster@pobox.com> wrote:
> "David Symonds" <dsymonds@gmail.com> writes:
>
> > Further, that comparison is going to fail as soon as the next revision
> > of Darwin (9.0.1, etc.) is released.
>
> Can we do something intelligent with $(shell iconv --version)
> there instead, I wonder, then?

It would probably be most appropriate for the autoconf script. Now
that I look at configure.ac, there's already a test for iconv in
there; is it not used?


Dave.
