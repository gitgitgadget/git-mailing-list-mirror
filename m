From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Fix safe_create_leading_directories() for Windows
Date: Thu, 2 Jan 2014 21:46:38 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1401022143310.1191@s15462909.onlinehome-server.info>
References: <52C5A039.6030408@gmail.com> <alpine.DEB.1.00.1401021826120.1191@s15462909.onlinehome-server.info> <52C5ABDE.1010006@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 02 21:46:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VypAC-0002d3-A6
	for gcvg-git-2@plane.gmane.org; Thu, 02 Jan 2014 21:46:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751893AbaABUqk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jan 2014 15:46:40 -0500
Received: from mout.gmx.net ([212.227.15.15]:55870 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750740AbaABUqk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jan 2014 15:46:40 -0500
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx103) with ESMTPSA (Nemesis) id 0MJSuF-1W1JKf2rwx-00345Z
 for <git@vger.kernel.org>; Thu, 02 Jan 2014 21:46:38 +0100
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <52C5ABDE.1010006@gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:BH+BA5Jhvu/ZyAOK+lrt5obKDHtHqfBt8jCypEAhDnSFWn/o5oH
 VIALj8xKAcD/aq8YY84gTBeRENTo5ZJwOqISbh7M2glOyCjTBeIuahcsFvYgJdhyA3UfoeC
 6nPdquRW8FxtzLvytA9sdBfDE4+DHl4oXb2kWhAxMyYOeuG1EBp/pFa0cVW3KookDOWblo7
 LTpAqZX/qrCdjL9iztNCQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239875>

Hi Sebastian,

On Thu, 2 Jan 2014, Sebastian Schuberth wrote:

> On 02.01.2014 18:33, Johannes Schindelin wrote:
> 
> > -- snip --
> > On Linux, we can get away with assuming that the directory separator is a
> > forward slash, but that is wrong in general. For that purpose, the
> > is_dir_sep() function was introduced a long time ago. By using it in
> > safe_create_leading_directories(), we proof said function for use on
> > platforms where the directory separator is different from Linux'.
> > -- snap --
> 
> While I'd be fine with this, I do not think we really need it.

I also would have been fine with your commit message. But I knew Junio
wouldn't be.

> As you say, is_dir_sep() has been introduced a long time ago, so people
> should be aware of it, and it should also be immediately clear from the
> diff why using it is better than hard-coding '/'.
> 
> That said, I see any further explanations on top of the commit message
> title is an added bonus, and as "just" a bonus a link to a pull request
> should be fine. You don't need to understand or appreciate the concept
> of pull requests in order to follow the link and read the text in there.

Well, you and I both know how easy GitHub's pull request made things for
us as well as for contributors. I really cannot thank Erik enough for
bullying me into using and accepting them.

But the commit messages of the merged pull requests are not exactly
stellar when you want the repositories to be self-contained, which is
however how I remember things are expected in git.git.

Ciao,
Dscho
