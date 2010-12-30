From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: Re: git rebase -i doesn't respect rebase.autosquash
Date: Thu, 30 Dec 2010 19:46:05 +0100 (CET)
Message-ID: <alpine.DEB.1.10.1012301944520.7175@debian>
References: <4D1D1A38.9090305@cs.dal.ca> <alpine.DEB.1.10.1012301929221.7175@debian> <4D1D263E.4080600@cs.dal.ca>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	git <git@vger.kernel.org>
To: Mike Doherty <doherty@cs.dal.ca>
X-From: git-owner@vger.kernel.org Fri Dec 31 01:45:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PYT7Q-0006UC-S9
	for gcvg-git-2@lo.gmane.org; Fri, 31 Dec 2010 01:45:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751392Ab0LaApO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Dec 2010 19:45:14 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:58803 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750875Ab0LaApN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Dec 2010 19:45:13 -0500
Received: by qwa26 with SMTP id 26so11561347qwa.19
        for <git@vger.kernel.org>; Thu, 30 Dec 2010 16:45:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:x-x-sender:to:cc
         :subject:in-reply-to:message-id:references:user-agent:mime-version
         :content-type;
        bh=gtUQ2/81Cjew86ofS7JE9zrPDON4RsmHuj7Vh9phg8Q=;
        b=li6ItrrtDFBgLdrT13tsPLNE2jTfq1hjlGlseB4W539cM4Ydy/9P9JcemRsZcdH93s
         nZuvSexiWNl87ZqwqMCn/x7QTjFSPvaN4kSrcTawgZu+hd89NxKUjD0/7nAAXY3nbcXe
         ORenn2/OvknggECSSmRH+ET7zP8shF2K6clH0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:x-x-sender:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version:content-type;
        b=mpnF246JzwEugOdVafbrzaJIfjJ+71kKE8Ycgbln1q7jQFp4xAh46ExNFOLc/TFVYC
         iegN44HsdyV9wah/jeWkAwgjQFS166mFdaR1q3Wu3kUqv4+Fa0lKXHetgvY3OzL1C8C3
         nQW6m9zbj5LSPrFAjWUtUvoGTw+JBjOW0Vh5w=
Received: by 10.224.176.67 with SMTP id bd3mr12709761qab.110.1293756312558;
        Thu, 30 Dec 2010 16:45:12 -0800 (PST)
Received: from [192.168.1.103] (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id e29sm9613649qck.39.2010.12.30.16.45.08
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 30 Dec 2010 16:45:09 -0800 (PST)
X-X-Sender: martin@debian
In-Reply-To: <4D1D263E.4080600@cs.dal.ca>
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164377>

On Thu, 30 Dec 2010, Mike Doherty wrote:

> On 10-12-30 01:37 PM, Martin von Zweigbergk wrote:
> > I also have rebase.autosquash enabled and it works for me. Does it 
> > autosquash as you expect if you pass '--autosquash' on the command 
> > line? Which version of Git are you running?
> 
> Yes, it does. I'm using 1.7.0.4

Ok, that explains it. The configuration was introduced in 1.7.3.


Regards,
Martin
