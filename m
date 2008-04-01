From: "David Aguilar" <davvid@gmail.com>
Subject: Re: Sending patches via gmail
Date: Tue, 1 Apr 2008 03:09:28 -0700
Message-ID: <402731c90804010309w6a27d2d1t2df25ac41fff96b9@mail.gmail.com>
References: <57518fd10804010249h4fe43bbfu64cf9576ca2edcf3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Apr 01 12:11:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JgdRY-0007NW-1d
	for gcvg-git-2@gmane.org; Tue, 01 Apr 2008 12:10:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756475AbYDAKJd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Apr 2008 06:09:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756174AbYDAKJd
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Apr 2008 06:09:33 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:44639 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756517AbYDAKJc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Apr 2008 06:09:32 -0400
Received: by ug-out-1314.google.com with SMTP id z38so66279ugc.16
        for <git@vger.kernel.org>; Tue, 01 Apr 2008 03:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=IW0svZ6UZyeEGYrV7WnHtmechSy46H49D+jFyKvRjUc=;
        b=Tjfrt2DhTuyl6DsObmKGzEew6pP5iKdUT3osINWcNtK3fA5/H4Cy/KpBrQQJLH/IIBaZ/JCpKT2GTdI3oDHWA8B5/QEcwyXx8WI9oDTHLHXCyKx566wyRAOSmEWrt07pWqlNP3UtQZhlYx9wKHw9nr9S2JiwExrlyV/+bAxKUCs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=kUdicvtHD2H/iBI9FjzluHFgwffZ+PsUSWd9qfxcYfECx73bLki0fkHEPCsFl3Y6aAeJ3Whsaddi2pZJHpeo38NFfB26qdnTQe3qBxIyF0iqZ20jZl6z0HrsiiCDVX0erQvdT8vSKXQ9xtkN2QCfhJTT0UR90w4yAQu7C2lk4NE=
Received: by 10.67.105.12 with SMTP id h12mr273828ugm.12.1207044568135;
        Tue, 01 Apr 2008 03:09:28 -0700 (PDT)
Received: by 10.66.236.11 with HTTP; Tue, 1 Apr 2008 03:09:28 -0700 (PDT)
In-Reply-To: <57518fd10804010249h4fe43bbfu64cf9576ca2edcf3@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78640>

On 4/1/08, Jonathan del Strother <maillist@steelskies.com> wrote:
> I can't seem to send patches via gmail without it adding spurious line
>  breaks -  eg http://article.gmane.org/gmane.comp.version-control.git/78407.
>   I thought this was supposed to be possible...  All I'm doing is
>  copying the contents of my patch, then in Gmail, clicking Compose
>  Mail, make sure it's in Plain Text rather than Rich Formatting mode,
>  paste my patch, and moving the mail header lines out of the message
>  body.
>
>  What am I missing?
>  Jonathan del Strother

Try git send-email w/ msmtp:
http://git.or.cz/gitwiki/GitTips#head-a015948617d9becbdc9836776f96ad244ba87cb8


-- 
    David
