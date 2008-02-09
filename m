From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: [RFC] New commit object headers: generation and note headers
Date: Sun, 10 Feb 2008 00:50:12 +0700
Message-ID: <fcaeb9bf0802090950l27aa247ei5d067e0f24fcade0@mail.gmail.com>
References: <200802091746.09102.jnareb@gmail.com>
	 <alpine.LNX.1.00.0802091220030.13593@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Jakub Narebski" <jnareb@gmail.com>, git@vger.kernel.org
To: "Daniel Barkalow" <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Sat Feb 09 18:50:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNtqk-0000Sb-IA
	for gcvg-git-2@gmane.org; Sat, 09 Feb 2008 18:50:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750845AbYBIRuQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Feb 2008 12:50:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750769AbYBIRuQ
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Feb 2008 12:50:16 -0500
Received: from fg-out-1718.google.com ([72.14.220.157]:5247 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750804AbYBIRuO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Feb 2008 12:50:14 -0500
Received: by fg-out-1718.google.com with SMTP id e21so3241089fga.17
        for <git@vger.kernel.org>; Sat, 09 Feb 2008 09:50:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=A0XhJkv9uzVTPgovT5AKeVbuXsFl566t9jxNzvOXZOU=;
        b=lgC2mwyMkmulcKHV0hss52aoWRLBm/WCbtRG/1zJVnun2kSRoOr9SRqJ5RBgTkAEPd6VE5T++HrUMyr+VI/RxYpYc5E+mVpSEjiEbdGfcdzUPgYTWCeiYNL6SknAgdrDcc7AgCXH0iotsfBpwy7o10u9gBmv/2FJcCHMov5UV5o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ID92DHMPdKEXAf2x0WKYokivYi8iZwuB230+dWzzMEp1eFryk4r3KDS0EtCmec/ATfh/sDnEnFoaF1M70rEJDKXml6nETnSSp/T7uNn+aqHro06WvaLD2gvVjAP1j47SanYGHydTXPonKmWSO/b2z9UwJY+1UMpnIr+i5vY6LxA=
Received: by 10.86.95.20 with SMTP id s20mr9469802fgb.6.1202579412464;
        Sat, 09 Feb 2008 09:50:12 -0800 (PST)
Received: by 10.86.83.3 with HTTP; Sat, 9 Feb 2008 09:50:12 -0800 (PST)
In-Reply-To: <alpine.LNX.1.00.0802091220030.13593@iabervon.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73249>

On Sun, Feb 10, 2008 at 12:35 AM, Daniel Barkalow <barkalow@iabervon.org> wrote:
>
> On Sat, 9 Feb 2008, Jakub Narebski wrote:
>  > 2. 'note' header (no semantical meaning)
>  >
>  > There was some time ago discussion about adding 'note' header, initially
>  > to save original sha-1 of a commit for cherry-picking and rebase; then
>  > for saving explicit rename or corrected rename info, for saving chosen
>  > merge strategy, and for saving original ID of SCM import.
>
>  Probably want to have a prescribed syntax for specifying what note this
>  is, so that different programs using notes don't confuse each other.

How about git ignoring all X- headers and let programs freely add
them? For example, X-SVN may be used for git-svn.

-- 
Duy
