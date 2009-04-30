From: Mark Lodato <lodatom@gmail.com>
Subject: Re: Google Code: Support for Mercurial and Analysis of Git and 
	Mercurial
Date: Wed, 29 Apr 2009 20:00:56 -0400
Message-ID: <ca433830904291700q608f6192i66a83bca9b88b739@mail.gmail.com>
References: <200904260703.31243.chriscool@tuxfamily.org>
	 <alpine.DEB.1.00.0904261208000.10279@pacific.mpi-cbg.de>
	 <20090427211502.GI23604@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 30 02:01:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LzJi7-0006RK-AE
	for gcvg-git-2@gmane.org; Thu, 30 Apr 2009 02:01:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753609AbZD3ABA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Apr 2009 20:01:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753246AbZD3AA6
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Apr 2009 20:00:58 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:51703 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753229AbZD3AA6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Apr 2009 20:00:58 -0400
Received: by fxm2 with SMTP id 2so1511001fxm.37
        for <git@vger.kernel.org>; Wed, 29 Apr 2009 17:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=ne3dsjFv367q5/KdmDZguBr2/iYx/zUAI1qCfM7Hayw=;
        b=PWlMeXPfwmWy+dwGx5qK5y5gxiAl0agOKQCKnRwcEhcuFdSz1ua2yuAd020ZYCdeZP
         GGEjT1/SfVnUELYGtM7IaR0q/lWWUxz9XDx46kTgxDlv4vUllntmFwbxBHEGCPBs+i0v
         Kc9LhhqHEV4eXs0/mBAKsy5Hn80rMk3bytFfM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=JB76LgqPqYuf6QiksFTJ9QT6U919OBTLVp5CdLFVMI/WPFMUvolLgvvVvw7TLAcMDZ
         tZESb780NIEEk4QC3YGXrP7Tzqx4d2WsEhgezOAmHIp76xDcWSIJTgZRn9zm1UejUrqj
         +cklL2rsKtjKM4YEb5lK/Ue9QdEIE+NuhBzNc=
Received: by 10.223.117.14 with SMTP id o14mr496696faq.21.1241049657040; Wed, 
	29 Apr 2009 17:00:57 -0700 (PDT)
In-Reply-To: <20090427211502.GI23604@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117982>

On Mon, Apr 27, 2009 at 5:15 PM, Shawn O. Pearce <spearce@spearce.org> wrote:
> IOW, if Git wants to expand into these user communities where the
> individual is stuck behind a corporate proxy that only permits HTTP
> "for security reasons" (but blindly winds up passing through whatever
> it gets), we need to support a more efficient HTTP protocol.

Another advantage of supporting HTTP is allowing HTTPS.  SSL can take
advantage of an existing PKI infrastructure, either the Internet's
existing server-side certificate system, or a corporate server- and
possibly client-side PKI infrastructure.

--
Mark
