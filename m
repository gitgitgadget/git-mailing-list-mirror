From: "Andy Shevchenko" <andy.shevchenko@gmail.com>
Subject: Re: [PATCH] git-send-email: provide hook to send lines more than 998 symbols
Date: Fri, 21 Nov 2008 12:55:31 +0200
Message-ID: <5ec8ebd50811210255o10ebd19eu828965952353f076@mail.gmail.com>
References: <1227261564-13268-1-git-send-email-andy.shevchenko@gmail.com>
	 <1227263693.3311.0.camel@therock.nsw.bigpond.net.au>
	 <5ec8ebd50811210237kd6f9341q23bc69b6ffcc2a87@mail.gmail.com>
	 <87wsex4aha.fsf@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Arafangion <thestar@fussycoder.id.au>, git@vger.kernel.org
To: "Teemu Likonen" <tlikonen@iki.fi>
X-From: git-owner@vger.kernel.org Fri Nov 21 11:57:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L3Tgv-0008TB-8n
	for gcvg-git-2@gmane.org; Fri, 21 Nov 2008 11:56:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753182AbYKUKze (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Nov 2008 05:55:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753134AbYKUKze
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Nov 2008 05:55:34 -0500
Received: from ey-out-2122.google.com ([74.125.78.24]:61218 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752848AbYKUKzd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Nov 2008 05:55:33 -0500
Received: by ey-out-2122.google.com with SMTP id 6so358710eyi.37
        for <git@vger.kernel.org>; Fri, 21 Nov 2008 02:55:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=CDygy5YixWFCab3VNOk9C6OklozCjCvdbxd06JYhMwY=;
        b=asmnchuY2oAGUb8N2VPbV9OpgRicscS8j5yNAC6zyGAuScrV6cLaOQwhAdDOKfJo4k
         9uvAhr8KP4daM2QnhNat4JuHDvRz5s4A2pMeI9uwCTzyLbTOiKJ1XhMkKTwI1dE4TO1Z
         oojeqhQRY+fqio8GOveStCE7m5h3jwVd6epnc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=FTAXWyKiiGR+bMioxhngABCmR76jLV1UdUKkIUCZZxrvGLSAb6YgKpmlTmFjhQr0du
         lUbY4cF/dkFADTnw8e6ox3ud/75gDeVd7x0ys/1++CGywi/kVMe/QDAkolD+/IL+4vsi
         Gg7lnbgFmwW10RiZwZ1YWy8qUPoVsYwpd+2wg=
Received: by 10.210.45.17 with SMTP id s17mr383000ebs.65.1227264931868;
        Fri, 21 Nov 2008 02:55:31 -0800 (PST)
Received: by 10.210.54.12 with HTTP; Fri, 21 Nov 2008 02:55:31 -0800 (PST)
In-Reply-To: <87wsex4aha.fsf@iki.fi>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101510>

On Fri, Nov 21, 2008 at 12:52 PM, Teemu Likonen <tlikonen@iki.fi> wrote:

Actually, the --no-validate is the true option for that.

-- 
With Best Regards,
Andy Shevchenko
