From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [StGit PATCH 0/6] Use git conflict handling on push
Date: Thu, 23 Aug 2007 15:54:51 +0100
Message-ID: <b0943d9e0708230754r533f7749l63b5e2ba9a5dcfe8@mail.gmail.com>
References: <11875975232619-git-send-email-davidk@lysator.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "=?ISO-8859-1?Q?David_K=E5gedal?=" <davidk@lysator.liu.se>
X-From: git-owner@vger.kernel.org Thu Aug 23 16:54:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IOE5K-0003AU-AB
	for gcvg-git@gmane.org; Thu, 23 Aug 2007 16:54:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762314AbXHWOyz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 23 Aug 2007 10:54:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762313AbXHWOyy
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Aug 2007 10:54:54 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:32797 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762289AbXHWOyy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Aug 2007 10:54:54 -0400
Received: by nf-out-0910.google.com with SMTP id g13so390946nfb
        for <git@vger.kernel.org>; Thu, 23 Aug 2007 07:54:52 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=nd2SwBl8q5dfSltWb8M7LtE1umcIIV3zeL/f+saNZTO4DZvAK3ZTtzq09OL5hoW3OuKlxww97EkbcNQX9IuXHM6gcz0nSfi0Ngjz7MjuxN1HIU4jCZd/5bOVMjDILIShnq/wPnuAVX22+cFz+eX6vbiQlWZHCjY40CJk39nQbAU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=FN9x8s9rSQwhjqtzAztQvkRHfzt5/mGMVxLyIF63GrgkDqJf8ySWmSXxkjIu3PVUTsWReZugKaX6crzDt01UfkXt991xw4L7HRmItl+97HApta2iZZVU9pvwfgbZyOqh8uIgGyQaHBAVgeQCmBA52UEzv1yRUAe+wneOlezQTG0=
Received: by 10.78.185.15 with SMTP id i15mr1256389huf.1187880891891;
        Thu, 23 Aug 2007 07:54:51 -0700 (PDT)
Received: by 10.78.151.11 with HTTP; Thu, 23 Aug 2007 07:54:51 -0700 (PDT)
In-Reply-To: <11875975232619-git-send-email-davidk@lysator.liu.se>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56503>

On 20/08/07, David K=E5gedal <davidk@lysator.liu.se> wrote:
> This series of patches updates "stg push" to leave conflicts in the
> index, in the normal git fashion.

Thanks for this series. I'll give it a try (importing it from the kha
branch as it is easier) and check other issues it might break.

> This means that conflict handling and resolution are handled by git
> and not stg, which should make it possible to simplify stg quite a
> bit.  For instance, the 'conflicts' file should go away.

Yes, indeed.

> Unfortunately, this patch series isn't complete, since it doesn't
> remove all uses of the stg merge code.  The remaining client of that
> code is the "sync" command, which I have never used, and haven't
> studied very much.  But if that command is changed somehow, then most
> of the code in gitmergeonefile.py will go simply away.

I still like to keep the interactive merging from that file.

> https://gna.org/task/?5140

BTW, would you like to be added as a project member at gna.org/projects=
/stgit?

Regards.

--=20
Catalin
