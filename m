From: "Lars Hjemli" <lh@elementstorage.no>
Subject: Re: git-stash
Date: Fri, 8 Jun 2007 01:38:38 +0200
Message-ID: <8c5c35580706071638m39bccc7xeee6b790c00af993@mail.gmail.com>
References: <Pine.LNX.4.64.0706072328000.4046@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jun 08 01:38:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HwRZ0-000060-MY
	for gcvg-git@gmane.org; Fri, 08 Jun 2007 01:38:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762757AbXFGXil (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 7 Jun 2007 19:38:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763005AbXFGXil
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Jun 2007 19:38:41 -0400
Received: from nz-out-0506.google.com ([64.233.162.238]:38027 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762757AbXFGXij (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jun 2007 19:38:39 -0400
Received: by nz-out-0506.google.com with SMTP id n1so665797nzf
        for <git@vger.kernel.org>; Thu, 07 Jun 2007 16:38:39 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=YsEllIKQQcB8Qxa49W3x5BIUGrr7fIJBG5F2D1IIDvcoj7i1NnOUNfyqvJ4fHwCfFoJDKkd4A+WEbkQRrduA/qKThde++02LFn1R62ACVHlf7HMMz3vs9kMCFuywq7irb+75a11kZlChB5bdYN7wqMxR6H684kUdJ2giIwYzcOc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=qboTfsUVxq5bJ6eqkHH9tsaPp+oXICpAxVfnQPkNJMh1wFuChW1YAeGl1fAn9LUNpibhyxFPI6aP4Gjuteo9D4hKljk0eZtyIpPDIZzkj82GG+g09nS/FwozU+jT7PjWy8dRLPJJojkFGTSnJzzZ4Kv0ZcOZbR06xjKXHjt28yU=
Received: by 10.114.202.15 with SMTP id z15mr1961537waf.1181259518824;
        Thu, 07 Jun 2007 16:38:38 -0700 (PDT)
Received: by 10.115.73.2 with HTTP; Thu, 7 Jun 2007 16:38:38 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0706072328000.4046@racer.site>
Content-Disposition: inline
X-Google-Sender-Auth: a5d597276cd84fe2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49411>

On 6/8/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> I just was in the need for git-stash (for the 1e6th time this year), but
> instead of writing a script, I though I'd try the "!" convention for
> aliases.

Fwiw, here's a very simple unstash:

git config alias.unstash '!git diff --binary stash^ stash | git-apply -'

--
larsh
