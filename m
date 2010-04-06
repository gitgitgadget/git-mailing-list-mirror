From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH/RFC] Documentation: reorganize documentation of URLs 
	understood by git
Date: Tue, 6 Apr 2010 13:10:44 +0530
Message-ID: <l2hf3271551004060040v4eca088ck8f1ab3376c0f889c@mail.gmail.com>
References: <f3271551003290759g154b149fl7877d9b83e1313e6@mail.gmail.com> 
	<20100329191832.GA26842@progeny.tock> <f3271551003291224s7fb0d8d3sce75b7c893fabfa8@mail.gmail.com> 
	<20100406060606.GA26629@progeny.tock> <7v6345jcfq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Gabriel Filion <lelutin@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 06 09:41:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nz3PR-0005EL-Aj
	for gcvg-git-2@lo.gmane.org; Tue, 06 Apr 2010 09:41:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757377Ab0DFHlM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 6 Apr 2010 03:41:12 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:61896 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757342Ab0DFHlK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 Apr 2010 03:41:10 -0400
Received: by gwb19 with SMTP id 19so1654633gwb.19
        for <git@vger.kernel.org>; Tue, 06 Apr 2010 00:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:received:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=CP0HG5NMxQQ2yJYuMrmrA2I7tR6Gm8Qht0U0PVAb5sE=;
        b=Ex0nM+Cn4X1HAosZZZxccZInvuXGz3kfkIA6KNrI6zABWOs0kpoKlbHlXjZVdLk2Jh
         Hiey/9/TCIN8W6mL6ep08RkqPQ7JXhPb8mBLm/NExH5/4oQHuefjS+iHshM0l79r62VR
         1APAR9Q/vZIvTXgR19mtZJy6pqqK5kN84xl1k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=xVrJ3/ckdACIXzwklkWnuNMXOFhwoFEp0l1WUEb5nTGcgXzBAxEBEDVTUW8VFb3fYb
         yMVCOMiSpaecOVzRCZyQFMI8H8jLRx0MPjLyPdQWpQEuCl+AxApWQpqEEG4vL0XFAc+p
         9+eCuSIInkTj2dIZsIYEdiUxFmw7yElZiDX7w=
Received: by 10.90.69.14 with HTTP; Tue, 6 Apr 2010 00:40:44 -0700 (PDT)
In-Reply-To: <7v6345jcfq.fsf@alter.siamese.dyndns.org>
Received: by 10.90.62.22 with SMTP id k22mr1909572aga.72.1270539666660; Tue, 
	06 Apr 2010 00:41:06 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144111>

Hi,

> While I fully share your
> "cover-to-cover" concern, the current organization was chosen to mini=
mize
> such indirection. =A0It is optimized for different audiences than we =
are (I
> am also from "cover-to-cover" school) who want to pick only the pages
> relevant to the task at hand.

I am of the opinion that we can have both. Jonathan's document can be
a more elaborate version of the standard urls.txt included in all
these documents. I can see several usecases- for example, in documents
like remote-helpers.txt, including a full section from urls.txt would
be a bit of an overkill; we could include a reference to this document
instead. Is redundancy an issue? We'd have to update both urls.txt and
this document everytime we change something.

-- Ram
