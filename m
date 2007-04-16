From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: parsecvs repository moved...
Date: Mon, 16 Apr 2007 20:37:09 +1200
Message-ID: <46a038f90704160137j3c6ffe5es3e44a6342017db58@mail.gmail.com>
References: <46a038f90704160032m9cfee8ai9830c81dd4a64cd6@mail.gmail.com>
	 <20070416075829.GK2689@curie-int.orbis-terrarum.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: "Martin Langhoff" <martin.langhoff@gmail.com>,
	"Git Mailing List" <git@vger.kernel.org>,
	"Keith Packard" <keithp@keithp.com>
X-From: git-owner@vger.kernel.org Mon Apr 16 10:37:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdMiQ-0000In-Jx
	for gcvg-git@gmane.org; Mon, 16 Apr 2007 10:37:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751623AbXDPIhP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Apr 2007 04:37:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751244AbXDPIhO
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Apr 2007 04:37:14 -0400
Received: from wx-out-0506.google.com ([66.249.82.231]:10628 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965197AbXDPIhK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Apr 2007 04:37:10 -0400
Received: by wx-out-0506.google.com with SMTP id h31so1532436wxd
        for <git@vger.kernel.org>; Mon, 16 Apr 2007 01:37:09 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=K5bFAP6YSVA1W4yMIevtp4K3wpvsjg/oV3DOs2P5N5VcWJr29uBQYfqIddLLYuxyPIkeUvX/K0JEbcfTTic71wX146+N/6ne1261G4BxhFMHplq4jy+SdgNHdsgrjbEy/xbn5yn8D2y6VT9UKLKgzXMVjF/OvGJZXM4vpWNaTUU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=E9aHp6EkfdArUrVFR+7vpBLB95Vvf4By4mdPAkCWZYky+Kjrd21qhcg6XUhTmEpcmQrXwXNXCeHbAXYQGa/3Oj3HbclDdCsX7dFtlmD/RI422IICm7XbjQ1Lc/QJGaqzr3pv5/iv0v8TBeHUPTZt+yjJkM/Q0NneTY9CcIuRrqs=
Received: by 10.90.98.3 with SMTP id v3mr4577537agb.1176712629660;
        Mon, 16 Apr 2007 01:37:09 -0700 (PDT)
Received: by 10.90.52.17 with HTTP; Mon, 16 Apr 2007 01:37:09 -0700 (PDT)
In-Reply-To: <20070416075829.GK2689@curie-int.orbis-terrarum.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44624>

On 4/16/07, Robin H. Johnson <robbat2@gentoo.org> wrote:
> On Mon, Apr 16, 2007 at 07:32:58PM +1200, Martin Langhoff wrote:
> >  I've just found that parsecvs.git repo has moved again... to
> >  http://anongit.freedesktop.org/git/users/keithp/repos/parsecvs.git
> It seems to be broken on there?
>
> $ git clone http://anongit.freedesktop.org/git/users/keithp/repos/parsecvs.git
> Initialized empty Git repository in /code/vcs/parsecvs/.git/
> Cannot get remote repository information.
> Perhaps git-update-server-info needs to be run there?

Oh - I managed to run an update to an existing checkout of mine - but
it's broken for cloning over http. I'm happy to publish my cloned repo
- try

 git-clone http://git.catalyst.net.nz/parsecvs.git

cheers,


martin
