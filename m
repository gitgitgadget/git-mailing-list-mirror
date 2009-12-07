From: Stephen Boyd <bebarino@gmail.com>
Subject: Re: [PATCH] gitweb.js: Harden setting blamed commit info in
 incremental blame
Date: Sun, 06 Dec 2009 17:19:01 -0800
Message-ID: <1260148741.1579.50.camel@swboyd-laptop>
References: <1258659887-5244-1-git-send-email-bebarino@gmail.com>
	 <200911250145.16472.jnareb@gmail.com> <4B0CAC2E.1060105@gmail.com>
	 <200911251536.08993.jnareb@gmail.com>
	 <1260147860.1579.47.camel@swboyd-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 07 02:19:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NHSFp-0005Wm-Jy
	for gcvg-git-2@lo.gmane.org; Mon, 07 Dec 2009 02:19:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932780AbZLGBS6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Dec 2009 20:18:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758282AbZLGBS5
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Dec 2009 20:18:57 -0500
Received: from mail-pw0-f42.google.com ([209.85.160.42]:60674 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758046AbZLGBS4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Dec 2009 20:18:56 -0500
Received: by pwj9 with SMTP id 9so610246pwj.21
        for <git@vger.kernel.org>; Sun, 06 Dec 2009 17:19:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:to:cc
         :in-reply-to:references:content-type:date:message-id:mime-version
         :x-mailer:content-transfer-encoding;
        bh=mxtLn3zUXyHOQWHdXo4IY06NtA2WPjs/7QzzNDMuAUM=;
        b=XQDxYZhc9VvFBdofwBN+hEsKokU9InKuJb9YIQ55uUyVYAxHMd2X9PLoyWcuA//pGW
         JjLAYud9wDe/jS3JSXYRWmM7EZyfW7BTM+fAlEtDXOfYpvAXPIhWcJBcksO2pkqsfgDt
         WlCbrFhiA+NWdUjB+L1ebovU2vcgDDlLCDWDg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:to:cc:in-reply-to:references:content-type:date
         :message-id:mime-version:x-mailer:content-transfer-encoding;
        b=srXG8M4ZopPkA9D5gnOoYnGYQvZORkfFqkeVorGarS4gKe5lVBTtdtLzMPxdoRuEoi
         p/XnQWpUwurOzu0YuQ/XunA+8RoF0VfRzSDRpnQt8uWORDNaZwftjJbZcyeT3yayg74m
         A6QU3KpoyiCb8qtPSzhUA3GMGk8umjTep1eSs=
Received: by 10.115.27.14 with SMTP id e14mr6058453waj.116.1260148743418;
        Sun, 06 Dec 2009 17:19:03 -0800 (PST)
Received: from ?192.168.1.5? (user-0c9haca.cable.mindspring.com [24.152.169.138])
        by mx.google.com with ESMTPS id 21sm4755139pzk.7.2009.12.06.17.19.02
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 06 Dec 2009 17:19:02 -0800 (PST)
In-Reply-To: <1260147860.1579.47.camel@swboyd-laptop>
X-Mailer: Evolution 2.28.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134706>

On Sun, 2009-12-06 at 17:04 -0800, Stephen Boyd wrote:
> 
> Ok. It's December and I've had some more time to look into this.
> Initializing 'xhr' to null seems to get rid of the "Unknown error"
> problem (see patch below).
> 

Ah sorry. Seems this doesn't work and I was just getting lucky.
