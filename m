From: Tor Arntsen <tor@spacetec.no>
Subject: Re: [PATCHv2] add Android support
Date: Mon, 23 May 2011 10:01:51 +0200
Message-ID: <BANLkTikAzS-2iNS5WunL18CbzMhwsa35wA@mail.gmail.com>
References: <B22B44EF-0AFB-44E3-93E3-61FA730431B9@gieschke.de>
	<7vaaej9pt3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Rafael Gieschke <rafael@gieschke.de>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 23 10:02:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QOQ5O-0001Gp-Ua
	for gcvg-git-2@lo.gmane.org; Mon, 23 May 2011 10:01:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752708Ab1EWIBx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 May 2011 04:01:53 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:57093 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751767Ab1EWIBw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 May 2011 04:01:52 -0400
Received: by bwz15 with SMTP id 15so4488799bwz.19
        for <git@vger.kernel.org>; Mon, 23 May 2011 01:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=QjyBocglGLca6NhrhtkvgLRU7KFAuYOs7o4dP9yQdAs=;
        b=olMXFvLV/mD8h72g/rFRa+MY1qQEA/Yq/dtO62Rq5Gg9nC0za2EVoNRsf9WftRZYAd
         LybWIrEjzrSCxqTqxwgayHBznoenriyHNc++CI250TqLkcNmcF+ZWfI3kg+h52ffp/3G
         S+ZYkvgHBQ1bd9strYsc7BxoujpGILfbkYrf8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        b=uxd+lIjQflJH1V5kDXvzy0VDIXHhMwx+3GsfJfdPWaG8Z6yabNHryPCO6aVywjtukN
         SIqMS50jZ+cGLnLV07SmWhgfclQSc54s5LmYgwVOXPkxCWJFGPF567cKHjqI1xNkynSx
         fw2CcNsZBNggplX7itLuB/MelNBLNT8K34Brs=
Received: by 10.204.228.130 with SMTP id je2mr1767792bkb.166.1306137711617;
 Mon, 23 May 2011 01:01:51 -0700 (PDT)
Received: by 10.204.83.196 with HTTP; Mon, 23 May 2011 01:01:51 -0700 (PDT)
In-Reply-To: <7vaaej9pt3.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: bVY96XFLvoV80MKKVCc6GMBEpdU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174229>

On Thu, May 19, 2011 at 08:18, Junio C Hamano <gitster@pobox.com> wrote:
> Rafael Gieschke <rafael@gieschke.de> writes:
>
>> Currently, it is not possible to compile git for Android as the C library (Bionic)
>> is neither providing getpass nor pw_gecos in struct passwd. Therefore,
>
> Whoa, whoa, wait. That's doing too many things in one patch.
>
> I am still debating myself if this rather huge patch is justifiable, or an
> elaborate joke/hoax. Does anybody seriously want to run git on his phone,
> tablet or set-top box?

[Just replying to that last general question].

Yes, absolutely. My Nokia N900 is just another Linux box, plugged into
a network it's indistinguishable from the other boxes (laptop, desktop
etc.) on that same network. On the other hand this particular phone
needs no effort to get Git running as it's basically a standard Debian
box with glibc. (And I do build some of the same apps on the phone as
on the desktop or laptop.) For Android it seems to need more work, but
I can easily imagine how Android developers would like to have Git on
their devices.  Sometimes when I'm on mission I don't have room for
the laptop, I only use my phone as the only computer. I'm sure others
do too.

-Tor
