From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: Delete branch start with "-"
Date: Thu, 9 Apr 2009 15:12:10 +0200
Message-ID: <20090409131210.GE4413@atjola.homenet>
References: <49DDEA00.9090003@makina-corpus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Yoann =?iso-8859-1?Q?Herv=E9?= <yoann.herve.ext@makina-corpus.com>
X-From: git-owner@vger.kernel.org Thu Apr 09 15:13:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lru4o-00049v-IX
	for gcvg-git-2@gmane.org; Thu, 09 Apr 2009 15:13:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763293AbZDINMQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 9 Apr 2009 09:12:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761677AbZDINMQ
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Apr 2009 09:12:16 -0400
Received: from mail.gmx.net ([213.165.64.20]:37653 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1759481AbZDINMP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Apr 2009 09:12:15 -0400
Received: (qmail invoked by alias); 09 Apr 2009 13:12:12 -0000
Received: from i59F5B2D2.versanet.de (EHLO atjola.local) [89.245.178.210]
  by mail.gmx.net (mp002) with SMTP; 09 Apr 2009 15:12:12 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1++feIe+xq+GSYgF6X7nK9abkt0YtWMAdSWNmnZ6Z
	V5O31/dHQKybuL
Content-Disposition: inline
In-Reply-To: <49DDEA00.9090003@makina-corpus.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116167>

On 2009.04.09 14:28:48 +0200, Yoann Herv=E9 wrote:
> Hello,
> by mistake I have created a branch with a "-" at the beginning of his=
 =20
> name, and now I can't delete it.
>
> git branch -d -f
>
> error: unknown switch `s'

Uhm, that error message doesn't fit the command... Anyway, use -- to
separate the branch name from the options:

git branch -d -- -f

Bj=F6rn
