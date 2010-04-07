From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH v9] Documentation/remote-helpers: Add invocation section
Date: Wed, 7 Apr 2010 22:20:52 +0530
Message-ID: <n2nf3271551004070950ucf314b40g56087d49dfbd29f1@mail.gmail.com>
References: <g2vf3271551004062257ycbda64d3z3d3004d802a03fc3@mail.gmail.com> 
	<7vsk77e20r.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Gabriel Filion <lelutin@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 07 18:51:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NzYTI-0007sN-H3
	for gcvg-git-2@lo.gmane.org; Wed, 07 Apr 2010 18:51:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758081Ab0DGQvP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 7 Apr 2010 12:51:15 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:51238 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758049Ab0DGQvO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 Apr 2010 12:51:14 -0400
Received: by gwb19 with SMTP id 19so644034gwb.19
        for <git@vger.kernel.org>; Wed, 07 Apr 2010 09:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:received:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=C6pKCMYnm60JZucGCf0Dn6XvWGovYyzq20ia6dstCxU=;
        b=iQ3+S2G3xOT4R1H35S09CfaFoBjeXlr/7aL20QDVke/txAUqAXqVwVoA8+kuZ5B6xz
         Mz+7Kwnn0917GsOHM0mxIad+6+yV3erplm3WdZQ1+0WLkh4WFgCg2CiFve2hM5mvU/7/
         zpeSKAQmJfNaP+sn3Jch+fHFgBgOX/PNetZw0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=JUk99LQCPbpgr6VChASl1hMBEKeLmmSqvgSQeLbSTwMEL6ZYTJdtTCFkdvSRuPAR8c
         rYhXNrOpG87h0dsTf84fsmEqeNoDnVYENobiIq3f4x2Fr+bcWNiiQjjwnV5WktIad0kY
         /tO364brrlQlpPi6i24wvU3ca59b7F0Z283iE=
Received: by 10.90.69.14 with HTTP; Wed, 7 Apr 2010 09:50:52 -0700 (PDT)
In-Reply-To: <7vsk77e20r.fsf@alter.siamese.dyndns.org>
Received: by 10.90.46.11 with SMTP id t11mr3052101agt.105.1270659072174; Wed, 
	07 Apr 2010 09:51:12 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144249>

> You keep sending a broken patch. =A0I've queued v7 and replaced with =
v8 and
> both times I had to fix them in my editor.

Oh, thanks for telling me- I should make sure that my future patches
aren't broken.
Can someone tell me what I'm doing wrong? Earlier, Junio also had a
problem with one of my patches being corrupt. I used git-imap-send and
the GMail web interface to fill out the "to", "cc" and some comments.

> I'm not replacing v8 with this tonight, as my pre-push test cycles ar=
e
> already running (finished in one vm and continuing in another).

Okay, no issues.

> Please
> check what I queued and make sure your future patches applies on top =
of
> what I have.

Right, so you can just squash them. Also, I think I'm sending in
patches too fast so I'll slow down and rebase them on top of `pu`
every time.
Do tell me anything else that I can do to make my patches easier to
review and apply in future.

-- Ram
