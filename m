From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH] Allow cloning an empty repository
Date: Fri, 23 Jan 2009 23:34:04 +0100
Message-ID: <bd6139dc0901231434n6d6af5a6ma8bb12a634d5b3ba@mail.gmail.com>
References: <1232669252-21881-1-git-send-email-srabbelier@gmail.com>
	 <7vwscm4xx0.fsf@gitster.siamese.dyndns.org>
	 <bd6139dc0901221746h258f548etf857ab37399133da@mail.gmail.com>
	 <alpine.DEB.1.00.0901230333060.3586@pacific.mpi-cbg.de>
	 <bd6139dc0901221847u6b8aeadcl580a091751de3d26@mail.gmail.com>
	 <alpine.DEB.1.00.0901230419080.3586@pacific.mpi-cbg.de>
	 <20090123223205.GA11491@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jan 23 23:35:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQUcg-0006WX-ID
	for gcvg-git-2@gmane.org; Fri, 23 Jan 2009 23:35:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757394AbZAWWeL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jan 2009 17:34:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757328AbZAWWeJ
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Jan 2009 17:34:09 -0500
Received: from yw-out-2324.google.com ([74.125.46.28]:36574 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756622AbZAWWeG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jan 2009 17:34:06 -0500
Received: by yw-out-2324.google.com with SMTP id 9so2257326ywe.1
        for <git@vger.kernel.org>; Fri, 23 Jan 2009 14:34:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=n55WdBCAUIpOz9LOc4d2vMldLrcAAiN18hjV2J5kbHc=;
        b=RqohiMOWs8AMVdWgI4i5D9//9ietIcdkNA8lnteOGWm8NRoFgCYSe3p/6pxhd3MLG6
         IpxO6YQbuPHJrtkeWWi+6yhOBXRpd0L4pzLu1dfQbmrEyHhNEl3RQm1CKND5k6KTfMxy
         4zvthCjfJi2gf7MFJMRyL4A0mwOLPCieE9ELs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=xoTRifDuGp1Iuop1/vRbBq0WqqwDhVY0RLNPy+oyCgk0cM9+ojs3WJaWjI1sbRI8KV
         FlrREImSwJEzQvlctLxfl6SZPyL6vq1X/U83xOIReoX9VLmpz0XX1loiYyws6zXKhLbE
         xY9KvPTrkrnjUUeanCUyF9c2GJWYsF6LQ5Og4=
Received: by 10.151.102.16 with SMTP id e16mr4067586ybm.237.1232750044877; 
	Fri, 23 Jan 2009 14:34:04 -0800 (PST)
In-Reply-To: <20090123223205.GA11491@coredump.intra.peff.net>
X-Google-Sender-Auth: 2494052452702992
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106925>

On Fri, Jan 23, 2009 at 23:32, Jeff King <peff@peff.net> wrote:
> Really? I have scripts that call clone (usually followed by building the
> result). Are you proposing that all scripts should "git init && git
> remote add && git fetch"?
>
> So I am strongly in favor of telling the difference between failure and
> emptiness.

A switch then, '--allow-empty'?

-- 
Cheers,

Sverre Rabbelier
