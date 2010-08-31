From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] Technical details about the index file format.
Date: Tue, 31 Aug 2010 12:38:53 +0530
Message-ID: <20100831070851.GA7543@kytes>
References: <1202711335-12026-1-git-send-email-robin.rosenberg@dewire.com>
 <loom.20100831T025714-111@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 31 09:11:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OqKzt-0006ut-G7
	for gcvg-git-2@lo.gmane.org; Tue, 31 Aug 2010 09:11:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756831Ab0HaHLD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Aug 2010 03:11:03 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:36914 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756582Ab0HaHLB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Aug 2010 03:11:01 -0400
Received: by pxi10 with SMTP id 10so2344916pxi.19
        for <git@vger.kernel.org>; Tue, 31 Aug 2010 00:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=DOYtUtyy4Rkxmr33wvEuuFlz7P0g/0UHDuZ07+UwrrY=;
        b=Y8fkoHEFEMBZUFbu1UwiJMkTB6vFJhKISPMOwsA72x5Mr6Pn/cmws+tI8APd4KxPdP
         sz/tUPlwg9snOOOzBXY67lTBiXcEeqJV1CrendflX5Y8VGL5//etAToh8DcV9HVQNuib
         R4lH/bL9MfMzHk1u4HciE1jvxh/Teg4NrZMdQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=aPv7SWHIEeHS/iW37IFovdGSX/2flXhKchyjk4l10vFLLlIpR1eLjHU6Pew64XjPxy
         7gQsw1vhUHOa4+7rqGxyE3uklgUcx7ped8mHsO82Lp/GllfRZg9Z5KYhYiDSxEVbfqCx
         1F3cVzMpfBEuPzeHfF5xjEPZn9dt/Uf+rNbJ8=
Received: by 10.114.36.4 with SMTP id j4mr6508801waj.176.1283238660247;
        Tue, 31 Aug 2010 00:11:00 -0700 (PDT)
Received: from kytes ([203.110.240.41])
        by mx.google.com with ESMTPS id s5sm15809302wak.12.2010.08.31.00.10.56
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 31 Aug 2010 00:10:58 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <loom.20100831T025714-111@post.gmane.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154881>

Hi Sverre,

Sverre Rabbelier writes:
> Robin Rosenberg <robin.rosenberg <at> dewire.com> writes:
> > 
> > Signed-off-by: Robin Rosenberg <robin.rosenberg <at> dewire.com>
> > ---
> >  Documentation/technical/index-format.txt |   91 ++++++++++++++++++++++++++++++
> >  1 files changed, 91 insertions(+), 0 deletions(-)
> >  create mode 100644 Documentation/technical/index-format.txt
> 
> This pretty much got a LGTM from Junio back when it was sent [0], Robin, can you 
> be persuaded to resend this? I think it'd be very good if we had some 
> documentation on the index format.

Don't we already have this in Documentation/technical/pack-format.txt?

-- Ram
