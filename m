From: Wincent Colaiuta <win@wincent.com>
Subject: Re: git rebase -i
Date: Thu, 19 Feb 2009 10:36:40 +0100
Message-ID: <A3E3A7A0-F03F-4C8B-B3F8-756B0E89798C@wincent.com>
References: <43d8ce650902190121v2e18aac1rfaa64a4ce6e799a3@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: John Tapsell <johnflux@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 19 10:38:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1La5MD-0006qa-RI
	for gcvg-git-2@gmane.org; Thu, 19 Feb 2009 10:38:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753959AbZBSJgq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 19 Feb 2009 04:36:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753510AbZBSJgp
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Feb 2009 04:36:45 -0500
Received: from wincent1.inetu.net ([209.235.192.161]:47221 "EHLO
	wincent1.inetu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753209AbZBSJgp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Feb 2009 04:36:45 -0500
Received: from cuzco.lan (54.pool85-53-5.dynamic.orange.es [85.53.5.54])
	(authenticated bits=0)
	by wincent1.inetu.net (8.13.8/8.13.8) with ESMTP id n1J9aeIn029638
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Thu, 19 Feb 2009 04:36:42 -0500
In-Reply-To: <43d8ce650902190121v2e18aac1rfaa64a4ce6e799a3@mail.gmail.com>
X-Mailer: Apple Mail (2.930.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110652>

El 19/2/2009, a las 10:21, John Tapsell escribi=F3:

> Hi,
>
>  I often do   'git rebase -i HEAD~10'  to rebase.  Since afaics it
> doesn't matter if you go back 'too far' I just always use HEAD~10 eve=
n
> if it's just for the last or so commit.
>
>  Would there be any objections to making  'git rebase -i' default to
> HEAD~10  or maybe 16 or 20.

Sounds awfully arbitrary and counter-intuitive to me.

Take a sample of Git users who know what "git rebase" does and ask =20
them what they intuitively think "git rebase -i" without any =20
additional arguments should do; I'd be _extremely_ surprised if they =20
answered that it should default to HEAD~10, HEAD~16, HEAD~20, or =20
HEAD~N for any N.

(I could tell you what my intuition tells me, but I don't think it's =20
very interesting.)

Cheers,
Wincent
