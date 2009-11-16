From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: [PATCH 3/3] rebase: refuse to rebase with -s ours
Date: Mon, 16 Nov 2009 18:04:05 -0500
Message-ID: <4B01DA65.7050003@gmail.com>
References: <cover.1258309432.git.trast@student.ethz.ch> <efd7770d166a97481e8e31e407b9c2da02a341e5.1258309432.git.trast@student.ethz.ch> <alpine.DEB.1.00.0911161333470.4985@pacific.mpi-cbg.de> <7vpr7ip7ji.fsf@alter.siamese.dyndns.org> <alpine.DEB.1.00.0911162213590.4985@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Nicolas Sebrecht <nicolas.s.dev@gmx.fr>,
	Baz <brian.ewins@gmail.com>,
	Peter Krefting <peter@softwolves.pp.se>,
	=?ISO-8859-1?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 17 00:06:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NAAeN-0000N0-7U
	for gcvg-git-2@lo.gmane.org; Tue, 17 Nov 2009 00:06:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753798AbZKPXEJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Nov 2009 18:04:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754236AbZKPXEI
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Nov 2009 18:04:08 -0500
Received: from mail-yw0-f202.google.com ([209.85.211.202]:43638 "EHLO
	mail-yw0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752277AbZKPXEH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Nov 2009 18:04:07 -0500
Received: by ywh40 with SMTP id 40so3596097ywh.33
        for <git@vger.kernel.org>; Mon, 16 Nov 2009 15:04:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id
         :disposition-notification-to:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=c2nb8qmTXSHAFtDBE8WMEqh96qxpL7o+KUihXPyR8oI=;
        b=YTUdn7J68JPmz0GvD1QxI7o5Q5GI8piBeVQbj9TMW9WSkZ+Jmx3r9ELrk4KxRJFMuG
         3OAvOcEL5EHVPhdj3o4BSIKwoxGucGXHNcFzZ+B6kgQvdGwGvfFGm5PbZpQWM7NwKvWb
         HViCuhFdfsrehJFZQgkjPXgGK9LlUiMQ8awo4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:disposition-notification-to:date:from:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        b=b2dHoyQIDq8emfihIcr3PK81Cz9eHk5cJ3AyPMmN8DFZqIy211UB48mpLgh050VrD/
         7mS1RtpwXWANS6LGi/pmug7vC0KrnbK4v0Epc0Nv4M4bSCrU0kqpa3iyCE/QbS/nNupS
         wMA7QfgNaT6geJcPDsMky2gbJWK8PYveroE6c=
Received: by 10.150.5.42 with SMTP id 42mr2653616ybe.310.1258412651561;
        Mon, 16 Nov 2009 15:04:11 -0800 (PST)
Received: from ?10.0.0.6? (c-71-199-240-201.hsd1.fl.comcast.net [71.199.240.201])
        by mx.google.com with ESMTPS id 4sm300837ywi.27.2009.11.16.15.04.10
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 16 Nov 2009 15:04:10 -0800 (PST)
User-Agent: Thunderbird 1.5.0.10 (X11/20060911)
In-Reply-To: <alpine.DEB.1.00.0911162213590.4985@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133034>

Johannes Schindelin wrote:
[...]
> As gitzilla once said "I cannot provide alternative patches, so that's 
> that".

I'm not sure I actually said that [*1*] but I did point out that when 
there is an active discussion about which of multiple ways a feature can 
be implemented, the party that produces code usually gets their way.

[*1*] There was beer involved and I was jet-lagged so maybe I did say 
that when I meant what I wrote above.
