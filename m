From: "Sverre Rabbelier" <alturin@gmail.com>
Subject: Re: theirs/ours was Re: [PATCH 6/6] Add a new test for using a custom merge strategy
Date: Tue, 29 Jul 2008 14:42:09 +0200
Message-ID: <bd6139dc0807290542q24312e9k1f36e8c65df6c4aa@mail.gmail.com>
References: <bd6139dc0807280754x76b6ffedg6bf756dfce23f1e3@mail.gmail.com>
	 <20080728185604.GA26322@sigill.intra.peff.net>
	 <alpine.DEB.1.00.0807282008470.8986@racer>
	 <20080728192651.GA26677@sigill.intra.peff.net>
	 <alpine.DEB.1.00.0807290123300.2725@eeepc-johanness>
	 <20080729043839.GC26997@sigill.intra.peff.net>
	 <alpine.DEB.1.00.0807291301060.4631@eeepc-johanness>
	 <20080729123629.GA12069@sigill.intra.peff.net>
Reply-To: sverre@rabbelier.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Git Mailinglist" <git@vger.kernel.org>,
	"Miklos Vajna" <vmiklos@frugalware.org>
To: "Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jul 29 14:43:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNoXo-0003am-10
	for gcvg-git-2@gmane.org; Tue, 29 Jul 2008 14:43:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751567AbYG2MmM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jul 2008 08:42:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752083AbYG2MmK
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jul 2008 08:42:10 -0400
Received: from wf-out-1314.google.com ([209.85.200.169]:44485 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751529AbYG2MmJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jul 2008 08:42:09 -0400
Received: by wf-out-1314.google.com with SMTP id 27so6395481wfd.4
        for <git@vger.kernel.org>; Tue, 29 Jul 2008 05:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=yCLDkk8hE8sug/pzNVbAbVE3pz/EM14RzdHGhqtq9eA=;
        b=YNwy8oLmCRj9jM3PEfmkHPab90RQTOU/RixGrZVPMwemo1WGvHvFNH00BnYEcdSrN3
         yK0ctUb/Qz8B60FAOCuzxtuesVRhSmB8AWdowbP9Apc1lMGTm45RRnb09YEzlYZ3UhR8
         aCcuL7fJaV78UNwlBuEvospj9BPR2edk3nr5c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:cc:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:references;
        b=S/qRRDy8SKihwLZBUT5VCpIfq83j3DdW3YVRNoXIj7OJ2EiYHmi0arUkNF15wK2zyZ
         899q51MXyjQB/5Pugd+13w2MAOkV6QvVifyXDxCx/jtHZVv2Gf5QAQnA70t9kCACpb4R
         4BljbClhGlWD0lovXOSAmINKL1PiAu0sHPwIc=
Received: by 10.142.81.6 with SMTP id e6mr2037068wfb.205.1217335329483;
        Tue, 29 Jul 2008 05:42:09 -0700 (PDT)
Received: by 10.142.104.10 with HTTP; Tue, 29 Jul 2008 05:42:09 -0700 (PDT)
In-Reply-To: <20080729123629.GA12069@sigill.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90628>

On Tue, Jul 29, 2008 at 14:36, Jeff King <peff@peff.net> wrote:
<good explanation of what I meant snipped>

> If you are using "-s theirs" frequently, you are probably doing
> something wrong. But that doesn't mean it is wrong for it to exist.

Exactly, thank you for that :). I hope it is clear to everybody what I
meant now, although it seems that especially Junio and Dscho feel
'git-merge-theirs' should not be part of git in the suggested form.

-- 
Cheers,

Sverre Rabbelier
