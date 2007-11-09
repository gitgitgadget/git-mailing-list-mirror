From: "David Symonds" <dsymonds@gmail.com>
Subject: Re: [PATCH] git-checkout: Test for relative path use.
Date: Fri, 9 Nov 2007 12:57:08 +1100
Message-ID: <ee77f5c20711081757l46527904x2c962f77fa539bc@mail.gmail.com>
References: <11945685673280-git-send-email-dsymonds@gmail.com>
	 <11945685732608-git-send-email-dsymonds@gmail.com>
	 <7vtznwxl59.fsf@gitster.siamese.dyndns.org>
	 <ee77f5c20711081744p5d7b46fo88a582b9f5dbdab8@mail.gmail.com>
	 <7vd4ukxjxn.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Andreas Ericsson" <ae@op5.se>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 09 02:57:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqJ7e-0008LE-Pp
	for gcvg-git-2@gmane.org; Fri, 09 Nov 2007 02:57:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753098AbXKIB5L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Nov 2007 20:57:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752810AbXKIB5K
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Nov 2007 20:57:10 -0500
Received: from rv-out-0910.google.com ([209.85.198.191]:42114 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752768AbXKIB5J (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Nov 2007 20:57:09 -0500
Received: by rv-out-0910.google.com with SMTP id k20so335210rvb
        for <git@vger.kernel.org>; Thu, 08 Nov 2007 17:57:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=Cte8ePvJ0VGph2d0vd9SSASrInnptFwR4L477bdYpQc=;
        b=AF0SspKr26QPNTgH8apWeWOs2NM1NFWk61nzBwLDG+AswoQbokMyFRvcvsgTbwZb+wPNWViyrL89NGtf1erDFsxiIlbpXUKv/djCshESF42oeSCHzxEf6N/+xJFzkQoLWrVOWFQpafUVSXC9HDpNVQsKXFw2pAIG+u8AkVIkJhk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=MyAO2cXyPWS56M3W1XEiNagqNhuwXFgMdpRx0GDIHmHbLlPd+IaVMrgwekIQeHqVjC8Kljk8YgVGTUQ3D8dwcP+3RS7qxNlxAY3wMyQOvMDu06Uz+LU8LpAgKpBE+azOVpMtZjpMroN+rEus0jraxr2GgAvK2vvS3TFnzgwdcKc=
Received: by 10.141.113.6 with SMTP id q6mr678463rvm.1194573428999;
        Thu, 08 Nov 2007 17:57:08 -0800 (PST)
Received: by 10.141.20.13 with HTTP; Thu, 8 Nov 2007 17:57:08 -0800 (PST)
In-Reply-To: <7vd4ukxjxn.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64115>

On Nov 9, 2007 12:54 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
> Are you really asking my preference?  A patch to ls-files to
> make the test pass is my preference, of course ;-).
>
> Haven't read your tests, though, but I see capable people
> already commented on the initial round so I do not expect it to
> be problematic.

I'm going after low-hanging fruit whilst I get familiar with Git's
internal structure. I can try to tackle this ls-files problem as a
separate thing.


Dave.
