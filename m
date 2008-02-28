From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: [PATCH 04/40] Windows: Use the Windows style PATH separator ';'.
Date: Thu, 28 Feb 2008 10:25:46 +0100
Message-ID: <47C67E1A.5030304@gnu.org>
References: <1204138503-6126-1-git-send-email-johannes.sixt@telecom.at> <1204138503-6126-5-git-send-email-johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>, johannes.sixt@telecom.at
X-From: git-owner@vger.kernel.org Thu Feb 28 10:26:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUf28-0003u2-2l
	for gcvg-git-2@gmane.org; Thu, 28 Feb 2008 10:26:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753320AbYB1JZx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Feb 2008 04:25:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757987AbYB1JZx
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Feb 2008 04:25:53 -0500
Received: from nf-out-0910.google.com ([64.233.182.191]:29314 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757746AbYB1JZv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Feb 2008 04:25:51 -0500
Received: by nf-out-0910.google.com with SMTP id g13so1806478nfb.21
        for <git@vger.kernel.org>; Thu, 28 Feb 2008 01:25:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:subject:references:in-reply-to:content-type:content-transfer-encoding:sender;
        bh=Bf9J2m9AJP8gLAcj4QweD2Q8Dc0qV7xfoll3IxP5jzk=;
        b=FRAlRZFh3v5HZDDMXbl+Ku3ebCjDulBN6DlHPo20iAWDxAWK2cdcwjSlddIw+kFXLyZyNjJV87jxVBxlpCux/hItquE40poqfhVpkn/oFGXDHt2RCO73PYe12+SKCkGYeF3siIdlpvslO6F6Qs5uPulmWtIS9ugYtxFHCetM7js=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject:references:in-reply-to:content-type:content-transfer-encoding:sender;
        b=JUf3UAscOVGAkzRyjTR2J7Y+CQgIhIeOG7hiK6bflOxXYeFwsNxMfpeUx0GiGXUhpcHWdJk2GlUOLWEB2e4Xh+Ffud6ourXJOH56WptLYTRXPkgsf5xRRwtNYAekG7gRZNKjTGmI8NrPnbmIlqj5yv2RS15jvJyTyYmA/vuIciU=
Received: by 10.86.97.7 with SMTP id u7mr7795687fgb.54.1204190749521;
        Thu, 28 Feb 2008 01:25:49 -0800 (PST)
Received: from scientist-2.local ( [195.176.178.209])
        by mx.google.com with ESMTPS id u26sm4247484mug.17.2008.02.28.01.25.48
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 28 Feb 2008 01:25:48 -0800 (PST)
User-Agent: Thunderbird 2.0.0.12 (Macintosh/20080213)
In-Reply-To: <1204138503-6126-5-git-send-email-johannes.sixt@telecom.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75371>


> +#ifdef __MINGW32__
> +		strbuf_addch(out, ';');
> +#else
>  		strbuf_addch(out, ':');
> +#endif

Why not adding a PATH_SEPARATOR #define?

Paolo
