From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [Patch 001/GSoC] Move static files into subdir
Date: Mon, 10 May 2010 13:53:06 +0200
Message-ID: <AANLkTilUB6bevzYOMoLXgFBkGtwyG-VUIYA1JPhoVYd_@mail.gmail.com>
References: <p2ze72faaa81005090656j593c3464v9ee1bb6432461efc@mail.gmail.com> 
	<m3bpcoenci.fsf@localhost.localdomain> <AANLkTim2rIFDBRChBxTiWZCNmd8ozwKQzM3RZOEr3mgp@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jakub Narebski <jnareb@gmail.com>, Git List <git@vger.kernel.org>,
	Petr Baudis <pasky@ucw.cz>,
	Christian Couder <chriscool@tuxfamily.org>
To: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 10 13:53:34 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OBRYE-0006kM-9Y
	for gcvg-git-2@lo.gmane.org; Mon, 10 May 2010 13:53:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751049Ab0EJLx3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 May 2010 07:53:29 -0400
Received: from mail-qy0-f183.google.com ([209.85.221.183]:55669 "EHLO
	mail-qy0-f183.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750970Ab0EJLx1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 May 2010 07:53:27 -0400
Received: by qyk13 with SMTP id 13so5985397qyk.1
        for <git@vger.kernel.org>; Mon, 10 May 2010 04:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=kELfdlOdwp2W4k9HPCNs13j68E34YNNoD9/cXumhAH8=;
        b=GmG9oWhKAFlwGfc15kfFSYrUr6dR2vlHX6r+i0F1JId3S/sAyUOdQ+kxfyJFyd7MhQ
         pcafqACmD3zMnBekuWxLtWzPskhR7b8db7iZTpACj+SpHQzx3WkORLdzlDRewHI94A2T
         QGz0AEGsOsKh9J0zMc2DR7vii3cJBXSKwpqDI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=eEM1tLFvFPkrE2S6IekflGoVzlNXBt1FixMHEcfokTKKvC+wue5Te9OL8hH4wvAh+8
         XukIW4G9FaLr9PqIb2vyIkyaOC5ERQ8emkssliv1yKJRa1kSDYbMfkopWNTxNGrxiRX8
         xZenTzCmBBZ/GkhjrQH+Uq1K5jTJmpAZqWSUg=
Received: by 10.229.227.5 with SMTP id iy5mr3157250qcb.29.1273492406264; Mon, 
	10 May 2010 04:53:26 -0700 (PDT)
Received: by 10.229.182.85 with HTTP; Mon, 10 May 2010 04:53:06 -0700 (PDT)
In-Reply-To: <AANLkTim2rIFDBRChBxTiWZCNmd8ozwKQzM3RZOEr3mgp@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146804>

Hi,

> Regarding wordwrap, all the mailing ports in my university are closed
> which leaves me only the gmail web cient which don't have any option
> to disable wordwrap. I will try to find a workaround for this. Please
> bear with my wordwrap until then.

I was in a similar situation earlier. My suggestion: find out if your
firewall allows HTTP CONNECT on all the ports; if it does, simply use
something similar to Corkscrew. If it doesn't, I suggest that you buy
a VPS from a cheap provider who'll allow you to listen for SSH
connections on port 443, and use that to send email. I've found that
git-send-email + msmtp is a good combination. If you don't want to
copy files over to the server everytime you want to send email, can
use something similar to proxychains.

Hope this helps.

-- Ram
