From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 03/10] Change remote tracking to remote-tracking in
 non-trivial places
Date: Thu, 28 Oct 2010 17:13:16 -0500
Message-ID: <20101028221316.GD16125@burratino>
References: <1287851481-27952-1-git-send-email-Matthieu.Moy@imag.fr>
 <1288290117-6734-4-git-send-email-Matthieu.Moy@imag.fr>
 <20101028183919.GD14212@burratino>
 <vpq4oc6f0ms.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com,
	Thore Husfeldt <thore.husfeldt@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Oct 29 00:13:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBait-0003yQ-Th
	for gcvg-git-2@lo.gmane.org; Fri, 29 Oct 2010 00:13:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759050Ab0J1WNY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Oct 2010 18:13:24 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:45036 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757796Ab0J1WNW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Oct 2010 18:13:22 -0400
Received: by qyk10 with SMTP id 10so2642572qyk.19
        for <git@vger.kernel.org>; Thu, 28 Oct 2010 15:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=Hpc1Jo3ghs+LysWY1aBYNXOTwObwSlfXxbSO25S5Ems=;
        b=iLS/TUTdgh8HeRKOEhtDqpLaejVXZ2PUfb18VtN2Aj7lW1yMBmelXSvsqzdD9mvkAv
         32El5GyuSGXVbvcYLCwmN+od6RChplEGLqvOSHmuVNbhDTCtfgNBBpYOmLz3IJHOQk2K
         byEJr90Jgi0YOlpJLHbxlTvdYhdTc7U2QzwZc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=WqAt937gJwgycLt2zSvcR5u3EF5FPrFCWLXPVDDbR/mTTqFcMwgS7pA7Gzc1xH16sc
         KABDfz3UPbp+fIlrNnavwHCpUVPHq3L+xx3EzGjX4U8cR62h+99a89HZ3yoOeIpP6iI0
         BUm+5gpWh4wG4Hx7FmEW6fckNg80bvv9T4Weo=
Received: by 10.224.69.218 with SMTP id a26mr3995032qaj.396.1288304001687;
        Thu, 28 Oct 2010 15:13:21 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id m7sm1518057qck.25.2010.10.28.15.13.20
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 28 Oct 2010 15:13:20 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <vpq4oc6f0ms.fsf@bauges.imag.fr>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160241>

Matthieu Moy wrote:

> What I'm trying to do here is really to achieve consistancy. If
> something has a name, let's use the same name everywhere.

Okay, but can it at least not be part of a patch that does something
simpler (only adding dashes)?

I'm not sure why you don't like the idea of rewording it, but
that's fine --- I am just trying to make sure that the patches
make sense...
