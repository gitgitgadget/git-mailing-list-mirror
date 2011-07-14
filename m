From: "J. Bakshi" <joydeep@infoservices.in>
Subject: Re: Coming from SVN world - need help
Date: Thu, 14 Jul 2011 11:03:18 +0530
Message-ID: <20110714110318.7726251c@shiva.selfip.org>
References: <20110713183056.1cde5b61@shiva.selfip.org>
	<CABPQNSa1PO6je+4sXMRWLLwLG9sUNTD1a+SMJj=wdPF+_dUPHA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Thu Jul 14 07:33:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QhEYH-0002AS-1J
	for gcvg-git-2@lo.gmane.org; Thu, 14 Jul 2011 07:33:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752193Ab1GNFdQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 14 Jul 2011 01:33:16 -0400
Received: from static.206.87.46.78.clients.your-server.de ([78.46.87.206]:49227
	"EHLO Kolkata.infoservices.in" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751048Ab1GNFdP convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jul 2011 01:33:15 -0400
Received: from shiva.selfip.org (unknown [122.176.30.116])
	by Kolkata.infoservices.in (Postfix) with ESMTPSA id 9C83E3804001;
	Thu, 14 Jul 2011 07:33:12 +0200 (CEST)
In-Reply-To: <CABPQNSa1PO6je+4sXMRWLLwLG9sUNTD1a+SMJj=wdPF+_dUPHA@mail.gmail.com>
X-Mailer: Claws Mail 3.7.9 (GTK+ 2.24.4; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177099>

On Wed, 13 Jul 2011 15:17:36 +0200
Erik Faye-Lund <kusmabite@gmail.com> wrote:

> On Wed, Jul 13, 2011 at 3:00 PM, J. Bakshi <joydeep@infoservices.in> =
wrote:
> > And now the issues when I am trying to do the same with git
> >
> > [1] git init ${git_path}/<repo>.git =C2=A0>>> ok , it is working
>=20
> You probably want to add the "--bare"-flag if this is the repo that
> will be published.
>=20
Actually the practical scenario is different than just a bare repo. The=
 repos should be connected with its working copy located at htdocs dire=
ctory. So whenever someone commit anything in git the corresponding wor=
king directory should be updated accordingly with a post-commit hook. I=
 have done the same in svn but don't know how git will help to achieve =
this ? The main part, How can I simply map the folder in htdocs with it=
's master in git repo ? As "git clone" actually creates the parent fold=
er. In svn it was easy with

````````````
cd mydir
mydir $> svn --username ${admin_svn} --password ${admin_svn_pass} co  f=
ile:///${svn_path}/${name_site}/trunk ./
``````````````

How can I achieve the same in git ?
