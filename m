From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: git svn bug?
Date: Thu, 2 Oct 2008 16:49:16 +0200
Message-ID: <20081002144916.GA3644@atjola.homenet>
References: <36C9BCCC-875A-4C65-98E2-0AD486FF8F61@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Ark Xu <ark.work@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 02 16:52:58 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KlPVZ-0001ij-ML
	for gcvg-git-2@gmane.org; Thu, 02 Oct 2008 16:50:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753580AbYJBOtO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 2 Oct 2008 10:49:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753368AbYJBOtO
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Oct 2008 10:49:14 -0400
Received: from mail.gmx.net ([213.165.64.20]:52266 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752514AbYJBOtO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Oct 2008 10:49:14 -0400
Received: (qmail invoked by alias); 02 Oct 2008 14:49:11 -0000
Received: from i577B8F08.versanet.de (EHLO atjola.local) [87.123.143.8]
  by mail.gmx.net (mp057) with SMTP; 02 Oct 2008 16:49:11 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX18wNuVisr8w2nib8SEwxzoYM70Tn33sCIPp6RQjIt
	q2t+kPJaQcAiKy
Content-Disposition: inline
In-Reply-To: <36C9BCCC-875A-4C65-98E2-0AD486FF8F61@gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.61
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97344>

On 2008.10.02 16:50:45 +0800, Ark Xu wrote:
> Hi guys,
>
>   I like git very much so I also use git svn for subversion repo.
>
>   Now I got a tough problem which stopping me for any svn related =20
> operations. There is a file log4j.xml that is somehow strange because=
 =20
> when I fetch it, i got the following message:
>
> tms-service/src/test/resources/log4j.xml has mode 120000 but is not a=
 =20
> link at /opt/local/bin/git-svn line 3230.
> M	tms-service/src/test/resources/log4j.xml
>
>   And then, all the operation will lead to :
> Checksum mismatch: branches/5.3/tms-service/src/test/resources/log4j.=
xml=20
> 51031cbb0e1a2e878e4a3836cf0baa9b80a037a5
> expected: fab6daef9fc355b9342e26047f5d0141
>      got: 0e7e9081d608c80d2de0340ba5cd1600
>
> Could anybody help?

Which git version? And is your /tmp large enough to store that file?

Bj=F6rn
