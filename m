From: "David Symonds" <dsymonds@gmail.com>
Subject: Re: Cannot git pull using http from my git.mycompany.com
Date: Fri, 21 Nov 2008 19:43:52 +1100
Message-ID: <ee77f5c20811210043v1f3af6c5l6f5a25c12d697d2d@mail.gmail.com>
References: <562019.27220.qm@web37908.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: garyyang6@yahoo.com
X-From: git-owner@vger.kernel.org Fri Nov 21 09:45:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L3RdY-0001Tk-66
	for gcvg-git-2@gmane.org; Fri, 21 Nov 2008 09:45:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752621AbYKUIn4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Nov 2008 03:43:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752482AbYKUIn4
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Nov 2008 03:43:56 -0500
Received: from nf-out-0910.google.com ([64.233.182.185]:20049 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751769AbYKUInz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Nov 2008 03:43:55 -0500
Received: by nf-out-0910.google.com with SMTP id d3so409847nfc.21
        for <git@vger.kernel.org>; Fri, 21 Nov 2008 00:43:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=qiEpv/BrUrAxCpjPmj+DKyRhZhGVf58ozQ8qyYaj5Go=;
        b=MQRaoxdVT/eiuqPOZsSg1DO7GI8edE5mwul+RXMFCzE6U+vhfUSZ+zXPL4YZsc8/IK
         nRXycn5CrlwBcTsEpendYQ+uKOrdSzSNha9sqRECgbwvmBJh1AYR+DvgqXZd0S6PhaH8
         OW6NrhCH+9niV7ZxZMD0od0w7VOj7i3inSP50=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=ii//JjLpdj0ApsyC3fBzUnaLve/9FPnuBZu/GN9k4gM4rxAOii8a0MgQy85WEiW9vS
         O8szybq7FW6W3AQeX4NJ8X6qJTsKF0Kwjq//q/Hhx+g9ETPX2erQyiRZCcyxYQ0QDoqv
         Mbu+XgdOPG+mWujrHVlnq05Jcwml6NhE5mFF0=
Received: by 10.210.121.8 with SMTP id t8mr246936ebc.180.1227257033204;
        Fri, 21 Nov 2008 00:43:53 -0800 (PST)
Received: by 10.210.10.2 with HTTP; Fri, 21 Nov 2008 00:43:52 -0800 (PST)
In-Reply-To: <562019.27220.qm@web37908.mail.mud.yahoo.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101501>

On Fri, Nov 21, 2008 at 12:13 PM, Gary Yang <garyyang6@yahoo.com> wrote:

> git pull http://git.mycompany.com/pub/git/u-boot.git HEAD
> fatal: http://git.mycompany.com/pub/git/u-boot.git/info/refs not found: did you run git update-server-info on the server?
>
> Below are related gitweb configs. What did I do wrong?

As the error message asks, did you run git update-server-info on the server?


Dave.
