From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 3/3] imap-send.c: Clean up coding style to better match the rest of the git codebase.
Date: Mon, 07 Jul 2008 05:40:16 -0700 (PDT)
Message-ID: <m3zloteukz.fsf@localhost.localdomain>
References: <1096648c0807070105s2b4ea1d9t2ab1eb17e891e3e8@mail.gmail.com>
	<7vfxqm5ba2.fsf@gitster.siamese.dyndns.org>
	<1096648c0807070517o8f22f0cs4d25103675bd635d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Rob Shearman" <robertshearman@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 07 14:41:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KFq1v-0007sp-LZ
	for gcvg-git-2@gmane.org; Mon, 07 Jul 2008 14:41:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752880AbYGGMkW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jul 2008 08:40:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752878AbYGGMkW
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Jul 2008 08:40:22 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:48829 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752383AbYGGMkV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jul 2008 08:40:21 -0400
Received: by nf-out-0910.google.com with SMTP id d3so645375nfc.21
        for <git@vger.kernel.org>; Mon, 07 Jul 2008 05:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=9QMHX0Z8/8jER7trlFYdir9jJom9MFrN1hH/av7Bi1A=;
        b=Z7ie9Y1RHu3AE2uWPYXKCXT+zil5xug/Y5d6zjS6R6/dkALcw0vu+yJijBXPPZ7foA
         VQ07ux3HyoD+p398MkYFdTo9HyOPngSJLnSV7lqvKtm6RSP6a5Shk3uZMViiUkRcYnlP
         0Z8VvT6uE7QFZ7VgDUCczjT3+60vPGhueygXs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=nIhv1ty4c+xqu8uCloLdLkYh0lxp0HMkDSdEo+ydNwx5SUrbDFcZkD+9At8IR2jSrb
         TFQ2IYyvpLvqQrcHjtADnPNk6wA+CumH0oyL0UFsveZLjeLshf4+fCzfV+wDNDeG8akP
         ZGkV3Fv0knlkwGzTpZbVdpOmP0YbHVINtCoGo=
Received: by 10.210.52.15 with SMTP id z15mr3097026ebz.103.1215434417920;
        Mon, 07 Jul 2008 05:40:17 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.206.62])
        by mx.google.com with ESMTPS id c24sm6613373ika.4.2008.07.07.05.40.15
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 07 Jul 2008 05:40:16 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m67CeDX2004740;
	Mon, 7 Jul 2008 14:40:14 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m67CeC6K004737;
	Mon, 7 Jul 2008 14:40:12 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1096648c0807070517o8f22f0cs4d25103675bd635d@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87601>

"Rob Shearman" <robertshearman@gmail.com> writes:

> 2008/7/7 Junio C Hamano <gitster@pobox.com>:
> > These patches seem to have been linewrapped severely.  I _could_ fix them
> > up and apply, but the last one being about whitespace and style fixes, I'd
> > rather not.
> 
> 2008/6/22 Junio C Hamano <gitster@pobox.com>:
> > Next time please do _not_ attach *.diff but follow the style of patch
> > submission other people do (see recent patch from Linus for example).
> 
> How do you propose I fix this? I attached the patch last time to avoid
> the problem of line wrapping.

If possible to turn of linewrapping, or use either git-send-email
(I think you can send patches also via Gmail) or git-imap-send,
then preferred solution is to have patch inline.

If it is not possible, then attach the patch, but preferrably
 1) with text/plain mimetype (.txt extension instead of .patch or
    .diff could be required for that)

 2) 8bit (preferred) or quoted-printable (if 8bit is not possible)
    transfer encoding (base64 is terrible waste of space); text/plain
    should chose quoted-printable at worst

 3) use "inline" attachement (select 'suggest to display attachement'
    or something like that), so it is possible to select attachement
    and hit reply.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
