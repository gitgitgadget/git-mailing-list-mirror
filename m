From: "Lars Hjemli" <hjemli@gmail.com>
Subject: Re: Merge problems with git-mingw
Date: Mon, 8 Oct 2007 14:00:55 +0200
Message-ID: <8c5c35580710080500n78259210v1b087e1ef506c0ee@mail.gmail.com>
References: <Pine.LNX.4.64.0710081203020.29715@ds9.cixit.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Peter Karlsson" <peter@softwolves.pp.se>
X-From: git-owner@vger.kernel.org Mon Oct 08 14:01:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IerIM-0002I1-M5
	for gcvg-git-2@gmane.org; Mon, 08 Oct 2007 14:01:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753915AbXJHMA5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Oct 2007 08:00:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753675AbXJHMA4
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Oct 2007 08:00:56 -0400
Received: from wa-out-1112.google.com ([209.85.146.183]:2016 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753105AbXJHMA4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Oct 2007 08:00:56 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1633757wah
        for <git@vger.kernel.org>; Mon, 08 Oct 2007 05:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=JI3Yz1z6o9V05PXAfoE1Yuo8hsNvENRAksK9JZxZELM=;
        b=hz9lSZjMD7xmlgu8q69ktPhaPqqILFGQ6lbXVXTGkJt5PaZbh/oltPRjzTUvNxUeaIW4as9YBO6ZsyS/l59HkZVRs0iksxuSzgZguDtTWjHumpZyMMtrpXGJkZvIKIOck/VcOxBnewYIBt4EXvJZvBCq685GpbctsGiaSNXl4o8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=lUyQcnESq2wE/oH4jqmwIhvIn1SB95fXNIWPwUWI3rVkk9P7ZC3YKn1NPcTRjTtjMDDhWHOx6/z8YcBaFYAtko5aV/3vMsSHN59rV8DO8wyYwYnjwhlyGk9eFXQGDQ7tZKuz7OQmrhPbhpUs+gTVBF7DlzU6M79wuWPEYAFJxks=
Received: by 10.114.53.1 with SMTP id b1mr3147300waa.1191844855304;
        Mon, 08 Oct 2007 05:00:55 -0700 (PDT)
Received: by 10.114.235.4 with HTTP; Mon, 8 Oct 2007 05:00:55 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0710081203020.29715@ds9.cixit.se>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60313>

On 10/8/07, Peter Karlsson <peter@softwolves.pp.se> wrote:
>   $ git merge master
>   usage: git-var [-l | <variable>]
>   $

What does this command return?

  $ git var GIT_COMMITTER_IDENT

--
larsh
