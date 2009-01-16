From: "Sverre Rabbelier" <srabbelier@gmail.com>
Subject: Re: [RFC PATCH] Make the rebase edit mode really end up in an edit state
Date: Fri, 16 Jan 2009 14:12:07 +0100
Message-ID: <bd6139dc0901160512x284bcd00x5d4c088e1771d86e@mail.gmail.com>
References: <87ab9th0rh.fsf@cup.kalibalik.dk>
	 <8035E52E-D202-4C42-BDFD-DC7A925580A3@wincent.com>
	 <76718490901151226l704d119bh297db4e91a4da05b@mail.gmail.com>
	 <200901161050.13971.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Jay Soffian" <jaysoffian@gmail.com>,
	"Wincent Colaiuta" <win@wincent.com>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Johannes Sixt" <j.sixt@viscovery.net>,
	"Anders Melchiorsen" <mail@cup.kalibalik.dk>
To: "Johan Herland" <johan@herland.net>,
	"Stephan Beyer" <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Fri Jan 16 14:13:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNoVx-0006PD-Nf
	for gcvg-git-2@gmane.org; Fri, 16 Jan 2009 14:13:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760669AbZAPNMM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Jan 2009 08:12:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752931AbZAPNMK
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Jan 2009 08:12:10 -0500
Received: from yx-out-2324.google.com ([74.125.44.29]:5204 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758439AbZAPNMI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Jan 2009 08:12:08 -0500
Received: by yx-out-2324.google.com with SMTP id 8so677590yxm.1
        for <git@vger.kernel.org>; Fri, 16 Jan 2009 05:12:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references
         :x-google-sender-auth;
        bh=6sUKFY94IoSKAP5JIrtWilpgS9KpOcdSlWR+KFkpzSg=;
        b=tSCpeOQbG7ubsgjOPJ0KeckuBc9PyNkMU5pbKPDgQ8y7iwuxxNjaHaxnicYfPIVtIN
         2QyrkBKbaT5ptGb83ebWWJRwdjV6/z0ixFgQ+RcgicM0lz4fmxfKTSoLYflAYB+ZfDVT
         /NzfEEldas/ZD7PHQVkG2FujzVsPTcOZABvHk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references:x-google-sender-auth;
        b=FFb2lKp1LoCDkIt5aLjDrcM7mH3toDB1nED/ovF+r0eo78LBWty1FItpzRtG2V0RDd
         oVu3B8zg4D6Wvwml123MF2l1eU+ySgyyQsONp+5zfjvNCy/BMugRT5v2T8mpToiw4VId
         DkekK2rM2FI2lXItanS/uU+ahKtUnzD+9CH9s=
Received: by 10.150.92.10 with SMTP id p10mr177996ybb.109.1232111527255;
        Fri, 16 Jan 2009 05:12:07 -0800 (PST)
Received: by 10.150.121.4 with HTTP; Fri, 16 Jan 2009 05:12:07 -0800 (PST)
In-Reply-To: <200901161050.13971.johan@herland.net>
Content-Disposition: inline
X-Google-Sender-Auth: 01340954580c8d95
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105952>

On Fri, Jan 16, 2009 at 10:50, Johan Herland <johan@herland.net> wrote:
> we should consider something like
>        pick e8902c1 Foo
>        halt

I very much like this suggestion, Stephan, is this somewhat similar to
how git sequencer will do things?

-- 
Cheers,

Sverre Rabbelier
