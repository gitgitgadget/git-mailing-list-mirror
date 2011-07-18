From: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
Subject: Re: [PATCH] Documentation/Notes: Remove 'footnote:' warning
Date: Mon, 18 Jul 2011 11:37:22 +0530
Message-ID: <CAK9CXBV=OMRVzEjUmb6JP8nM9bQ4DqM0D7xCywxs0TUD5+scrw@mail.gmail.com>
References: <1310855420-21183-1-git-send-email-pavan.sss1991@gmail.com>
 <1310908271.21563.17.camel@drew-northup.unet.maine.edu> <20110717215858.GA9906@elie>
 <CAK9CXBVSq_j7naHzVLMj=bW8WMKq_WfkDQP4zspkK_QizC26=g@mail.gmail.com> <20110718055108.GA4254@elie.gateway.2wire.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Drew Northup <drew.northup@maine.edu>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 18 08:08:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qigzv-0006kx-S1
	for gcvg-git-2@lo.gmane.org; Mon, 18 Jul 2011 08:08:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751307Ab1GRGHp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 18 Jul 2011 02:07:45 -0400
Received: from mail-ey0-f171.google.com ([209.85.215.171]:47665 "EHLO
	mail-ey0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751180Ab1GRGHo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 18 Jul 2011 02:07:44 -0400
Received: by eye22 with SMTP id 22so1088972eye.2
        for <git@vger.kernel.org>; Sun, 17 Jul 2011 23:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=wNLds9pGanhkzYYvTsvIqPviBZ+PsE5vuEb0yd/1ejo=;
        b=Oz2A2z8OkuMFOReROXdqmFKWBpu1WhS0zBESzi+uVeWTK0u76G1eraRNwZKuPBoat2
         2qId3w1BBjqppU+KuI4dzqDh3YaWmg9nwOF8k/+BBn4Tio8oBVji2dKchk1mWe3u/75r
         EvZquWzQXyWV2RIrwAMzBg0J0l//hOPRCZqPY=
Received: by 10.14.98.69 with SMTP id u45mr2051292eef.231.1310969263150; Sun,
 17 Jul 2011 23:07:43 -0700 (PDT)
Received: by 10.14.53.70 with HTTP; Sun, 17 Jul 2011 23:07:22 -0700 (PDT)
In-Reply-To: <20110718055108.GA4254@elie.gateway.2wire.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177340>

>> So, using newest version will not give us a warning?
>
> Yes, when I run "make -C Documentation git-notes.1" I don't get the
> warning or spurious blank line. =A0Sorry for the lack of clarity.
> (That's no reason to not to adopt a workaround if it is pleasant, of
> course.)
>

Currently the documentation at
http://www.kernel.org/pub/software/scm/git/docs/git-notes.html is
showing the footnote wrongly. This workaround will solve that.
Jonathan, ack the patch if you want to have a workaround.

Thanks
--=20
- Pavan Kumar Sunkara
