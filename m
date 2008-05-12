From: "Sverre Rabbelier" <alturin@gmail.com>
Subject: Re: multiple files for the same hook
Date: Mon, 12 May 2008 22:43:31 +0200
Message-ID: <bd6139dc0805121343i71fc99ebr6570044ddc0ba287@mail.gmail.com>
References: <200805122039.49779.hto@arcor.de>
Reply-To: sverre@rabbelier.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: hto@arcor.de
X-From: git-owner@vger.kernel.org Mon May 12 22:44:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jvesx-0002je-6S
	for gcvg-git-2@gmane.org; Mon, 12 May 2008 22:44:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756825AbYELUne (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 May 2008 16:43:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759404AbYELUne
	(ORCPT <rfc822;git-outgoing>); Mon, 12 May 2008 16:43:34 -0400
Received: from wf-out-1314.google.com ([209.85.200.172]:50573 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756518AbYELUnb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 May 2008 16:43:31 -0400
Received: by wf-out-1314.google.com with SMTP id 27so2446195wfd.4
        for <git@vger.kernel.org>; Mon, 12 May 2008 13:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=37lGLlkOOoph/nws6Yd2LiNtrHKOKkey4c2H/x9BV6s=;
        b=hvDKAuipvQjAu5aY0QnwbJs4GsxougW9i0DcNjD3VARXFM8fii3wlcjWAq6lPISTKOYUIH5XeoLyg0Sgxzy+OcKGyjsUBGiK7akTcXPxqaLyWy4CDqxBwLXaC7YfG1Oc6gXIGj9DmfW5StA6uw296KQ7Zjqp/FbAUR4XUxCqk68=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=t4fAnkun2Pd0SBZYuBb9y6u6ZjM0OXywPUjdaDWypFydKgsTYvWGj/dPStbR5qtLsNf0x+6v5IyckpnSzf/Gu3ATFgSa7WereL4ubpZzxS809ZtTILJLuIcgFbtkhtvG7wiK3ksTfQ83ECLzMB4bXTJU4xoe5EbLMmEhmxwqZKw=
Received: by 10.142.83.4 with SMTP id g4mr3447664wfb.103.1210625011240;
        Mon, 12 May 2008 13:43:31 -0700 (PDT)
Received: by 10.143.33.6 with HTTP; Mon, 12 May 2008 13:43:31 -0700 (PDT)
In-Reply-To: <200805122039.49779.hto@arcor.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81946>

On Mon, May 12, 2008 at 10:39 PM, Thomas Hunger <hto@arcor.de> wrote:
>  where all executable files in the dir are executed in alphanumeric
>  order. Is there a possibility of this going into git (I could try a
>  patch)?

Heya,

Wouldn't it be easy to have the hook script do that?
Just have it walk through the directory and call all the scripts?

-- 
Cheers,

Sverre Rabbelier
