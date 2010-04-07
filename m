From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v9] Documentation/remote-helpers: Add invocation section
Date: Wed, 7 Apr 2010 17:49:43 -0500
Message-ID: <20100407224942.GA20239@progeny.tock>
References: <g2vf3271551004062257ycbda64d3z3d3004d802a03fc3@mail.gmail.com>
 <7vsk77e20r.fsf@alter.siamese.dyndns.org>
 <n2nf3271551004070950ucf314b40g56087d49dfbd29f1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Gabriel Filion <lelutin@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Git Mailing List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 08 00:50:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nze4Z-0002oH-6Q
	for gcvg-git-2@lo.gmane.org; Thu, 08 Apr 2010 00:50:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754339Ab0DGWtq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 7 Apr 2010 18:49:46 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:55203 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753619Ab0DGWto (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Apr 2010 18:49:44 -0400
Received: by gwb19 with SMTP id 19so803278gwb.19
        for <git@vger.kernel.org>; Wed, 07 Apr 2010 15:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=2Z40qG2+iIuBMVf4WHPq58HQKvSyQa7iZ6go8a3amcM=;
        b=M4RikOFQv72auDbHgOsx/VbZTIeG6tmCbZAmyNd6uWnxUYXE5DnpS70y2cZ7SAhszH
         XGWyotZYWHrJHLezFhWWB7igVlL0B/83LmhVjCWyVHiPCBQ/LYx25UpHCR55Cp5gJFLd
         MKsaQhI1T/bad4IQy3fdYfnRMXX8W6VWS2Zho=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=EhP14RbWCNuQSgPXm/2v7534fTRHcyGWte/P9M8dV9TEXntmzW366Y+d7d6k38elMN
         8wYgrZ0qawIatgpbfav+2x11h3b/yRKsJ7uSDNoZ/+TkNLt1rRq1DULimDFlqZopvM1b
         OHmbFH/v+HDQ8/trKJMNGFHiz7RX/bUOJ0x7o=
Received: by 10.101.106.1 with SMTP id i1mr19494377anm.24.1270680580030;
        Wed, 07 Apr 2010 15:49:40 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 7sm4100171ywc.34.2010.04.07.15.49.38
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 07 Apr 2010 15:49:39 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <n2nf3271551004070950ucf314b40g56087d49dfbd29f1@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144294>

Ramkumar Ramachandra wrote:

> Right, so you can just squash them. Also, I think I'm sending in
> patches too fast so I'll slow down and rebase them on top of `pu`
> every time.

Thank you for this.  FWIW I find it useful when discussing a piece of
code or documentation to bounce back and forth multiple versions of
small fragments.  Then once the discussion has settled down, it can be
useful to see the big picture again, with the new changes
incorporated.

If you want to make sure the latest version of a patch is always
available, that is a noble goal, too, but I think a frequently-
rebased public branch for your patch series is a better way to achieve
that.

Unrelated: in case you are interested, the git-resurrect.sh script
from contrib can extract topic branches from pu, if you want to see
Junio=E2=80=99s topic branch for your patch.

Cheers,
Jonathan
