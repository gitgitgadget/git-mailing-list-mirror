From: Timo Hirvonen <tihirvon@gmail.com>
Subject: Re: git-format-patch builtin isn't using git-cherry?
Date: Fri, 23 Jun 2006 15:23:21 +0300
Message-ID: <20060623152321.2c20e9f8.tihirvon@gmail.com>
References: <46a038f90606221732k6d93bcceic2761081d7a7c72b@mail.gmail.com>
	<Pine.LNX.4.63.0606231357420.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: martin.langhoff@gmail.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 23 14:23:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ftkh8-0006Ui-2E
	for gcvg-git@gmane.org; Fri, 23 Jun 2006 14:23:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964776AbWFWMX0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Jun 2006 08:23:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933075AbWFWMX0
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Jun 2006 08:23:26 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:52254 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932560AbWFWMX0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jun 2006 08:23:26 -0400
Received: by nf-out-0910.google.com with SMTP id o60so405274nfa
        for <git@vger.kernel.org>; Fri, 23 Jun 2006 05:23:25 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=tH17Cl34ljJrNVyOwIUcFzufKrQ0EKZCC/OMVF1xT+QXyiFU31FGQFQdXJptbXGXkZK2tKH0WT9w5lc3CH160Ssjut1isvofHk6JfSFYqtgB0Sgx9iTzd0PtpBG4qH4FubQCPmInFrZ/t5WsQwpsd2otGQHuXTTpoC0dNaA2Izc=
Received: by 10.49.19.11 with SMTP id w11mr2382809nfi;
        Fri, 23 Jun 2006 05:23:24 -0700 (PDT)
Received: from garlic.home.net ( [82.128.229.197])
        by mx.gmail.com with ESMTP id a23sm2924601nfc.2006.06.23.05.23.23;
        Fri, 23 Jun 2006 05:23:24 -0700 (PDT)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0606231357420.29667@wbgn013.biozentrum.uni-wuerzburg.de>
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.8.18; i686-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22412>

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:

> Basically, it will involve the following recipe:
> 
> 	- add a DIFF_FORMAT_PATCH_ID

Please don't add any DIFF_FORMAT_*.  I'm cleaning the diff output code
and replacing diff_options.output_format with one-bit flags.

-- 
http://onion.dynserv.net/~timo/
