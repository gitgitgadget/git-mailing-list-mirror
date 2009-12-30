From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: Minor bug in bash completion
Date: Wed, 30 Dec 2009 12:22:22 +0100
Message-ID: <20091230112222.GA493@neumann>
References: <4B3A140A.60302@steek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: spearce@spearce.org, git@vger.kernel.org
To: Sylvain RABOT <srabot@steek.com>
X-From: git-owner@vger.kernel.org Wed Dec 30 13:08:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NPxLv-0001OS-14
	for gcvg-git-2@lo.gmane.org; Wed, 30 Dec 2009 13:08:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752125AbZL3MIa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 30 Dec 2009 07:08:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751551AbZL3MIa
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Dec 2009 07:08:30 -0500
Received: from viefep20-int.chello.at ([62.179.121.40]:16412 "EHLO
	viefep20-int.chello.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751466AbZL3MI3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Dec 2009 07:08:29 -0500
X-Greylist: delayed 2759 seconds by postgrey-1.27 at vger.kernel.org; Wed, 30 Dec 2009 07:08:29 EST
Received: from edge05.upc.biz ([192.168.13.212]) by viefep12-int.chello.at
          (InterMail vM.7.09.01.00 201-2219-108-20080618) with ESMTP
          id <20091230112228.ORSW13918.viefep12-int.chello.at@edge05.upc.biz>;
          Wed, 30 Dec 2009 12:22:28 +0100
Received: from [127.0.1.1] ([89.132.250.223])
	by edge05.upc.biz with edge
	id PPNP1d0524pwvqp05PNQwc; Wed, 30 Dec 2009 12:22:28 +0100
X-SourceIP: 89.132.250.223
Content-Disposition: inline
In-Reply-To: <4B3A140A.60302@steek.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135889>

Hi Sylvain,


On Tue, Dec 29, 2009 at 03:36:58PM +0100, Sylvain RABOT wrote:
> I found a bug in the git bash completion.
> It occurs when I press tab to complete branch name when I want to pul=
l =20
> from the origin.
> Instead of completing the branch name it prompts me directly for my =20
> password on the origin remote.

I don't think it's a bug.  The completion script should offer the
currently available refs in the remote repository after a 'git pull
<remote> <TAB>'.  In order to do that it contacts the remote
repository for the list of refs available there.  Depending on the
access method, it might need to authenticate, in your case via ssh.
To silence the password prompts you should change your ssh
configuration to use key-based authentication when logging in to the
remote repository's server (just google for 'ssh login without
password').


Best,
G=E1bor
