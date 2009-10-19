From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: What's cooking in git.git (Oct 2009, #03; Mon, 19)
Date: Mon, 19 Oct 2009 22:05:22 +0200
Message-ID: <40aa078e0910191305r288c950ej3d76939282385c5e@mail.gmail.com>
References: <7vhbtv6c76.fsf@alter.siamese.dyndns.org>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 19 22:05:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MzyTy-0001dt-9f
	for gcvg-git-2@lo.gmane.org; Mon, 19 Oct 2009 22:05:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757429AbZJSUFT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 19 Oct 2009 16:05:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757423AbZJSUFT
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Oct 2009 16:05:19 -0400
Received: from mail-fx0-f218.google.com ([209.85.220.218]:51752 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753486AbZJSUFS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Oct 2009 16:05:18 -0400
Received: by fxm18 with SMTP id 18so5516394fxm.37
        for <git@vger.kernel.org>; Mon, 19 Oct 2009 13:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:reply-to:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=TV0k9OUEYeHhgr8vZDr1gavdLpYblCmyi7h0p7oxjJE=;
        b=RCVITMRPHZsu5dp+Ib8iETLUJiKQ1v03nCOPhxdbGcRZ8p1WY+pgvTtx+V9Xiqi2yU
         tJZYGcYvWE3Zgp4R2V/qdBREl7txmiO/DudK2b+cQIHQCCEA7Zvms/WObFe/S995vu7R
         STa1cUImW5Z5qj76PpQpkeUPMtx3Ato7aWP8I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        b=eJQYvBaunGXa4KS2G9H44V5+rrQ5k+yekCbgWJ028D8zsEttsuFHdS0wlXpWzp+pV+
         htJ3jiF4QnlqGRqhGxweChNTGZCTRr7fN9PbTrWAId8pZmUeRl2o2nLogVEfZ/pe7GMB
         2gWgslykE8imIpAlQa20yGXv0IlCfFRWP8NMU=
Received: by 10.204.3.219 with SMTP id 27mr5269766bko.127.1255982722159; Mon, 
	19 Oct 2009 13:05:22 -0700 (PDT)
In-Reply-To: <7vhbtv6c76.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130733>

On Mon, Oct 19, 2009 at 10:05 AM, Junio C Hamano <gitster@pobox.com> wr=
ote:
> * ef/msys-imap (2009-10-13) 8 commits.
> =A0- MSVC: Enable OpenSSL, and translate -lcrypto
> =A0- mingw: enable OpenSSL
> =A0- mingw: wrap SSL_set_(w|r)fd to call _get_osfhandle
> =A0- imap-send: build imap-send on Windows
> =A0- imap-send: fix compilation-error on Windows
> =A0- imap-send: use run-command API for tunneling
> =A0- imap-send: use separate read and write fds
> =A0- imap-send: remove useless uid code
>
> Is this good to go yet?

As far as I know, yes. I sent out a new iteration a couple of hours
ago (after you sent this mail). This version addresses all issues that
has been raised AFAIK. But let's give people some more time to shoot
holes in it, OK?

--=20
Erik "kusma" Faye-Lund
