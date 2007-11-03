From: "Lars Hjemli" <hjemli@gmail.com>
Subject: Re: git-svn questions: how to clone/init non-standard layout branches/tags?
Date: Sat, 3 Nov 2007 14:59:45 +0100
Message-ID: <8c5c35580711030659x203f8ae8s40366c493a3eeae6@mail.gmail.com>
References: <756D5EE2-FB2C-48DB-8242-14E154E34A9C@vicaya.com>
	 <87597D7C-60FB-4CD8-BB27-7E870001A899@lrde.epita.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Luke Lu" <git@vicaya.com>, git@vger.kernel.org
To: "Benoit SIGOURE" <tsuna@lrde.epita.fr>
X-From: git-owner@vger.kernel.org Sat Nov 03 15:00:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IoJXe-0003jQ-8z
	for gcvg-git-2@gmane.org; Sat, 03 Nov 2007 15:00:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754093AbXKCN7r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Nov 2007 09:59:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754050AbXKCN7r
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Nov 2007 09:59:47 -0400
Received: from wa-out-1112.google.com ([209.85.146.181]:56054 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753970AbXKCN7q (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Nov 2007 09:59:46 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1297751wah
        for <git@vger.kernel.org>; Sat, 03 Nov 2007 06:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=3UA74pjKmCpbfagYyKTmeUYQ3gmeraSdq0WUv/kn9js=;
        b=sHEo+pVaPrG0OS9OQtLekR0TmOeFjMD186RMuXFzolI3icMBUNBP0nQWlb9gGGhnlA1QEeEBFxwg3fx2Y1+krVmpAvIUTnOe1cvySGLJyIPNapQaPRVzKf4aTTjZexJ+JPemws3VN0YgiGRLveWxRnXAg3CM0XKNpMjYEz40ArA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=UZTVGSMso4v66aZjViv3osl+rFY1zgeI8sdZsBBj787GQr+9CWEQ66swKCgq6RIJjVYJd6qvVg6rHtjD8dXwipOsPPA4nB2K4GVpz9e0vWXNFzDGA2Q7AtKljwIg4e16wXna2cokDg0qooHfYHjBNIBqD3f0SFUOJU6pwrLIMbc=
Received: by 10.114.58.1 with SMTP id g1mr3036456waa.1194098385858;
        Sat, 03 Nov 2007 06:59:45 -0700 (PDT)
Received: by 10.114.235.4 with HTTP; Sat, 3 Nov 2007 06:59:45 -0700 (PDT)
In-Reply-To: <87597D7C-60FB-4CD8-BB27-7E870001A899@lrde.epita.fr>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63272>

On Nov 3, 2007 11:56 AM, Benoit SIGOURE <tsuna@lrde.epita.fr> wrote:
> On Nov 3, 2007, at 9:19 AM, Luke Lu wrote:
> > 2. Is there a way to add a new svn branch like that (say production
> > or some_branch) to an existing git-svn repository that has trunk
> > cloned?
>
> I don't know, but that'd be great indeed.
>

You can simply add "fetch" lines to  the relevant "svn-remote" section
in .git/config.

-- 
larsh
