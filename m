From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: git clone: very long "resolving deltas" phase
Date: Wed, 7 Apr 2010 09:29:31 -0500
Message-ID: <s2kfabb9a1e1004070729j617d1f98r295723a54a30cd6d@mail.gmail.com>
References: <loom.20100406T161552-321@post.gmane.org>
	 <vpqljd062xb.fsf@bauges.imag.fr> <4BBB5346.6070607@gmail.com>
	 <4BBB53F5.9010106@op5.se>
	 <q2mec874dac1004060850r5eaa41fak2ba9889d07794651@mail.gmail.com>
	 <v2qecffb261004060856qcb769a06vf40ad2a75a3aa4fd@mail.gmail.com>
	 <alpine.LFD.2.00.1004061705390.7232@xanadu.home>
	 <4BBC1E15.9040403@gmail.com>
	 <20100407080049.GA14041@LK-Perkele-V2.elisa-laajakaista.fi>
	 <alpine.LFD.2.00.1004070952290.7232@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>, git@vger.kernel.org,
	Shawn Pearce <spearce@spearce.org>,
	Andreas Ericsson <ae@op5.se>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Nicolas Pitre <nico@fluxnic.net>,
	Vitaly Berov <vitaly.berov@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 07 16:29:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NzWGG-0000se-Kv
	for gcvg-git-2@lo.gmane.org; Wed, 07 Apr 2010 16:29:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932657Ab0DGO3e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Apr 2010 10:29:34 -0400
Received: from qw-out-2122.google.com ([74.125.92.27]:54124 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932574Ab0DGO3c (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Apr 2010 10:29:32 -0400
Received: by qw-out-2122.google.com with SMTP id 8so388219qwh.37
        for <git@vger.kernel.org>; Wed, 07 Apr 2010 07:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:received:message-id:subject:from:to:cc:content-type;
        bh=IhSQM0LQt5N8EZsR+KYJ5smJRes8Uwh2jlWPVoIvpjU=;
        b=Mm2gAUsjHEEFnhKv4F5i7id5+HJZUXq36mMKv+lpJnN7R+6knovo6zbum7SL7B1Csx
         YZ9M5zEb/9dCUitrgrt1uAP4wuY1kwAUfNwdDRz9cNhnNnPFIbpaDs1HVqgf4MMKHTC/
         iP/5TbLjZvT5k4pQCeRgczBZ5yTFXO7vS7i7M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=xb6eu+nuNjwzGSIgiRfCsEnaIl0QnWqCAftnrCg6wwiqfCblZvHI7ggOauGzhMWglJ
         QC+5L4MTKVExt0D4Tj50lkqUyZ+zQUYLd6DcwkCjOF85s35QWqhk2zXdfBKnILnJQFYz
         nlADSqEjdhVDBBj0158SPL78Jn2c1r0I9UkoU=
Received: by 10.224.74.3 with HTTP; Wed, 7 Apr 2010 07:29:31 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.00.1004070952290.7232@xanadu.home>
Received: by 10.224.59.223 with SMTP id m31mr2786016qah.63.1270650571829; Wed, 
	07 Apr 2010 07:29:31 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144222>

Heya,

On Wed, Apr 7, 2010 at 09:08, Nicolas Pitre <nico@fluxnic.net> wrote:
> This shouldn't happen since commit 92392b4a which provide a cap on
> memory usage during the delta resolution process.

Which made me think of asking:

Vitaly, what version of git are you running? Both client and server side please.

-- 
Cheers,

Sverre Rabbelier
