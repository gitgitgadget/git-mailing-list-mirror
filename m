From: "Sverre Rabbelier" <srabbelier@gmail.com>
Subject: Re: [PATCH] A simple script to parse the results from the testcases
Date: Sun, 8 Jun 2008 20:09:22 +0200
Message-ID: <bd6139dc0806081109y69cfc09agb699b29817b4f513@mail.gmail.com>
References: <1210584832-16402-3-git-send-email-srabbelier@gmail.com>
	 <1212884291-13847-1-git-send-email-vmiklos@frugalware.org>
	 <bd6139dc0806071734h16aa4218md051fbbe9f025f43@mail.gmail.com>
	 <20080608004928.GG29404@genesis.frugalware.org>
	 <bd6139dc0806071756k331c9b29obc5f1cb525ef47d8@mail.gmail.com>
	 <20080608022656.GH29404@genesis.frugalware.org>
	 <bd6139dc0806080443g64403fa4o855809b70e367f0@mail.gmail.com>
	 <alpine.DEB.1.00.0806081826570.1783@racer>
	 <bd6139dc0806081030i32266a2n633f7679f4a02bb@mail.gmail.com>
	 <237967ef0806081106i77bec10u3d42170eeaf474e9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Miklos Vajna" <vmiklos@frugalware.org>, git@vger.kernel.org,
	dsymonds@gmail.com
To: "Mikael Magnusson" <mikachu@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 08 20:10:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K5PLN-0005nL-2b
	for gcvg-git-2@gmane.org; Sun, 08 Jun 2008 20:10:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753671AbYFHSJY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Jun 2008 14:09:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753705AbYFHSJX
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Jun 2008 14:09:23 -0400
Received: from wf-out-1314.google.com ([209.85.200.175]:9445 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753646AbYFHSJX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jun 2008 14:09:23 -0400
Received: by wf-out-1314.google.com with SMTP id 27so1762357wfd.4
        for <git@vger.kernel.org>; Sun, 08 Jun 2008 11:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references
         :x-google-sender-auth;
        bh=MrmtWXaoUlWrH0+dNXE2tOSW17sjQaRPAV/XIgbJvGs=;
        b=LcdwsgaHaJTGkyPS+/gqLtOiLR5AQpHjNb/qjEOcxY12ZB4atrtJA+A0/VHPTJz8GU
         Ft+ob3mSLUVz7mFYGSM69Tpb/8nYNjKpx5O4oDaW7DCZBd1OjqK7ICnVZSHJV0nNgW99
         wcA0QKvI4TbZR2g6aUcNt4Xm3WH23qYUv5JwA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references:x-google-sender-auth;
        b=T3J5imbF17BxGM1J8NSlhjzmdY/2OVDpnTKayi2mQTSFiAmPRxJvqijEaM15AZqneo
         jyu6m6rLDSGtzG8jgebfaW3Xj0p4JZ4NUm2S5NunyG57gekXDoFHK8aiEGXll75G9Zkb
         CsOGC2xTVdk+cvaaytoOKNNffwZcbnK8sFwZ8=
Received: by 10.142.87.7 with SMTP id k7mr1043156wfb.167.1212948562743;
        Sun, 08 Jun 2008 11:09:22 -0700 (PDT)
Received: by 10.143.41.7 with HTTP; Sun, 8 Jun 2008 11:09:22 -0700 (PDT)
In-Reply-To: <237967ef0806081106i77bec10u3d42170eeaf474e9@mail.gmail.com>
Content-Disposition: inline
X-Google-Sender-Auth: adbe41b1a41fe41f
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84304>

On Sun, Jun 8, 2008 at 8:06 PM, Mikael Magnusson <mikachu@gmail.com> wrote:
> git mv oldname newname
> git commit --amend ;: not --ammend

Details, details.
Ah well, the way I did it seemed the most easy at the time, maybe next
time I'll use amend (my favorite feature in git that I usually spell
incorrectly at least twice).


-- 
Cheers,

Sverre Rabbelier
