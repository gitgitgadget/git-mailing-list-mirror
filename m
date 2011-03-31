From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 5/5] t9012-svn-fi: Add tests for svn-fi
Date: Thu, 31 Mar 2011 18:23:07 -0500
Message-ID: <20110331232307.GA21608@elie>
References: <1301422392-21177-1-git-send-email-artagnon@gmail.com>
 <1301422392-21177-6-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	Peter Baumann <waste.manager@gmx.de>,
	David Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 01 01:23:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q5RCz-0000lU-3M
	for gcvg-git-2@lo.gmane.org; Fri, 01 Apr 2011 01:23:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753981Ab1CaXXQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Mar 2011 19:23:16 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:50478 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753507Ab1CaXXP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Mar 2011 19:23:15 -0400
Received: by gyd10 with SMTP id 10so1185528gyd.19
        for <git@vger.kernel.org>; Thu, 31 Mar 2011 16:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=N/uz17ztbbj8WGkh9wJxfAp6sxsEl3ayn2j51LrsPJk=;
        b=JQCZmfvQ5T2fNGz+nHCtwI7gt4iSnVMKPmqvVNe3EgVZNbi0qEprIYr/PoVWaOZBGf
         JL0ItTZsBIPAc3ufPL4QIbf83ALMhqX+wWBD5JlpNFSIuJk//8d/HS5At4B/2FCW31P+
         gSIk3SIAyxo8d6IMSAaarr9aGGJESrSGNPSI0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=wbCB5zegsGqCMukUIJrgSxnDbn/f0REhbypBMxlZzx5DGRp4SEdx9eDoJ4+QBVQRpn
         mIlDamXvcpulnEygVCCI9XOkwDxnOirfj6fEfNrXN67/Oy/Vx1Xd0AZfftDnamVxgGL8
         HvUrllBXOuFZCh3R0gU4Ey19B/WpmNgRYPxP0=
Received: by 10.151.62.38 with SMTP id p38mr3287658ybk.12.1301613794505;
        Thu, 31 Mar 2011 16:23:14 -0700 (PDT)
Received: from elie (adsl-68-255-107-98.dsl.chcgil.sbcglobal.net [68.255.107.98])
        by mx.google.com with ESMTPS id u24sm821871yhn.43.2011.03.31.16.23.12
        (version=SSLv3 cipher=OTHER);
        Thu, 31 Mar 2011 16:23:13 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1301422392-21177-6-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170542>

Ramkumar Ramachandra wrote:

> Verifying svn:date is very non-trivial, because of timezone conversion
> issues.

Maybe the TZ variable can help.
