From: Frank Li <lznuaa@gmail.com>
Subject: Re: [PATCH v2 2/3] git-core: Support retrieving passwords with 
	GIT_ASKPASS
Date: Fri, 26 Feb 2010 18:01:10 +0800
Message-ID: <1976ea661002260201s75ef6185x3f89742d58f12222@mail.gmail.com>
References: <1267143154-5020-1-git-send-email-lznuaa@gmail.com>
	 <4B87797D.7030905@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, gitster@pobox.com
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Feb 26 11:01:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nkx0X-0006Vi-No
	for gcvg-git-2@lo.gmane.org; Fri, 26 Feb 2010 11:01:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932978Ab0BZKBM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Feb 2010 05:01:12 -0500
Received: from mail-yw0-f197.google.com ([209.85.211.197]:47495 "EHLO
	mail-yw0-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932641Ab0BZKBL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Feb 2010 05:01:11 -0500
Received: by ywh35 with SMTP id 35so3829545ywh.4
        for <git@vger.kernel.org>; Fri, 26 Feb 2010 02:01:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=HwKcZP3/L9EhdairvbjXyDWm+IZnTD1z/yPv93ce3Dg=;
        b=gUD2yJv7Dl/Mx0BJ+n9Ns8RDfGV1qziLBptGJpaMFjZ+Ata0wL+HHrZyxCyQEhhYYN
         mNziRTp2OVfoSvmBWAbKamjNpDEw62lFqXwOrsKYIpyzwgbsi0zglMQZicmbRk95Dz/r
         R8rXs43RS2N0ZlwveFM/z4GJS7Sa+NlyAtJM8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=S0W+klyhgWIov76nLczjcp1ZTrpc7MevtOZwwGtgCv3UKqEfPSN5K0yQ3bjsUWNO2P
         +uNcs4QsGP311HjSoiizlPoTdiPxERyHMMmZUl+z4T9vvhgXIEP5iGaMGxExZufZ/wjU
         bg7Ek+t/nN0fyyR8GXe1nYkU31Iwz0fEwnhME=
Received: by 10.150.127.40 with SMTP id z40mr273186ybc.308.1267178470381; Fri, 
	26 Feb 2010 02:01:10 -0800 (PST)
In-Reply-To: <4B87797D.7030905@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141120>

>
> You handle the return value in different ways. getpass() returns a pointer
> to a static buffer, but in the 'then' branch you return an allocated
> buffer. Not that it matters a lot, though. You could add a comment that
> you are aware that the memory is leaked.
>

How about my branch also use static buffer, so there are not memory leak.

best regards
Frank Li
