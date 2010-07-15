From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 3/4] revert: don't print "Finished one cherry-pick." if
 commit failed
Date: Thu, 15 Jul 2010 17:42:51 -0500
Message-ID: <20100715224251.GA7253@burratino>
References: <20100713232816.7738.202.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jeff King <peff@peff.net>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Fri Jul 16 00:44:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OZX9q-0006Vt-4V
	for gcvg-git-2@lo.gmane.org; Fri, 16 Jul 2010 00:43:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934914Ab0GOWnp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 15 Jul 2010 18:43:45 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:44617 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934838Ab0GOWno (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jul 2010 18:43:44 -0400
Received: by vws5 with SMTP id 5so1743853vws.19
        for <git@vger.kernel.org>; Thu, 15 Jul 2010 15:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=G6YLeOwYfiKDLUZ3s3A77F8ZBQ02UnNqIDwlk4cm7w8=;
        b=o14neAqvSsnd6hb+Id38dTvc5oFngd/m+35+pm2vFGFHqGi6t3oPc6Qg7ucKdEoz/T
         4/n8YEvTtbg+dRghlpvCPS9f7XhFy7THjy+BQaEGiOUF3uMpBwAeNjiQC+fX61suOZVO
         ODoivewkPHRB4w3lispKyxFxBFQx/In+0MZec=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=DghEHzPbpbvE7ypdEjaZVFkf8Dhror3w+kJc35MsniO18SJMYnEQJoe2+P/uXh7DIJ
         iGbc1r9Iw1dcKaLeWJc4RRh/ox2pLVbpEpIg1IF6TPJSiFvQ9p1p8JKakZpeVwTajf4K
         EW8NrACpAqC469IDmP+Ye1tQ7zVKsvbu5BkyM=
Received: by 10.224.72.87 with SMTP id l23mr111837qaj.328.1279233823300;
        Thu, 15 Jul 2010 15:43:43 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id i26sm6811853qcm.43.2010.07.15.15.43.41
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 15 Jul 2010 15:43:42 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100713232816.7738.202.chriscool@tuxfamily.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151125>

Christian Couder wrote:

> Subject: revert: don't print "Finished one cherry-pick." if commit fa=
iled

This and the previous one make the code much easier to read.
So for what it=E2=80=99s worth I like them.
