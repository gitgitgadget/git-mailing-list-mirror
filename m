From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: BUG: git rebase -i -p silently looses commits
Date: Mon, 2 Nov 2009 17:56:58 +0100
Message-ID: <fabb9a1e0911020856o1ff79bfbn50704b7440bfbe0f@mail.gmail.com>
References: <85647ef50911020818p61d0c975kd5655fa58993e07b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git Mailing List <git@vger.kernel.org>,
	Constantine Plotnikov <constantine.plotnikov@gmail.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Nov 02 17:57:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N50Dp-0002uU-Lp
	for gcvg-git-2@lo.gmane.org; Mon, 02 Nov 2009 17:57:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756049AbZKBQ5O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Nov 2009 11:57:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755702AbZKBQ5O
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Nov 2009 11:57:14 -0500
Received: from mail-bw0-f227.google.com ([209.85.218.227]:40947 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755412AbZKBQ5O (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Nov 2009 11:57:14 -0500
Received: by bwz27 with SMTP id 27so6523703bwz.21
        for <git@vger.kernel.org>; Mon, 02 Nov 2009 08:57:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=LLT7meNl/aUOQDUYNClTJMZ13AslsXNmEATVaJHD0sw=;
        b=OMYzhKtSuzUZKRwQxbUYRbItppsxwnG7jSc1KTdhttS0rhjI7W7g3hYDrk2MhgG2E+
         W6J2UKY1TuEyw+180TfuvCxEsyO37pUOZ0gCKPyaloor0tqsrOCdPak6e2HAXdvs/rH7
         CRoVJzUNyLfBIsfIzEUDiK+ZPHV6h5zP79IK4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=U/nySU41lAeKc5/fyTUmjsZGpNePV61SZrCw+RxyvUY3k0JpCgsS8hENlaJGs4zGU8
         cYHfBA/huQSghgDnbOf5oAkxFcbKM5PIMmLEwN9wuXbK04X7R9s3JiOgRS9XHL6nvIgm
         VzUD4nesbppQb4OCXdowcVfwpZpKUY/SSTjQ0=
Received: by 10.204.154.135 with SMTP id o7mr3771821bkw.201.1257181038278; 
	Mon, 02 Nov 2009 08:57:18 -0800 (PST)
In-Reply-To: <85647ef50911020818p61d0c975kd5655fa58993e07b@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131925>

Heya,

On Mon, Nov 2, 2009 at 17:18, Constantine Plotnikov
<constantine.plotnikov@gmail.com> wrote:
> I have encountered what looks like critical bugs in the git rebase -i
> -p (it can be reproduced on mingw and cygwin, I have not tried other
> platforms).

Johannes has been working off and on on fixing git rebase -i -p to
DTRT, perhaps this is related?

-- 
Cheers,

Sverre Rabbelier
