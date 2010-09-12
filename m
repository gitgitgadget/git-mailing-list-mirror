From: Kent Borg <kentborg@borg.org>
Subject: Re: git-p4
Date: Sun, 12 Sep 2010 16:07:31 -0400
Message-ID: <4C8D3303.1030302@borg.org>
References: <4C8A8CE8.90600@borg.org>	<20100910235323.773d2c5b@varda>	<AANLkTinmG5BU+yswWQ8=cRKT5WL_h8vWuUCu2PjZYb87@mail.gmail.com>	<4C8CF231.6090403@borg.org>	<AANLkTi=yJ5kVA17+40xc6NpEczFjgmYh7=w5k=GL_U9w@mail.gmail.com>	<4C8D14F9.90705@borg.org> <AANLkTi=NGsY3wDiTLwNLpw4TJMpiSY8A=az_=v2fYDLj@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	=?UTF-8?B?QWxlamFuZHJvIFJpdmVpcmEgRmVybsOhbmRleg==?= 
	<ariveira@gmail.com>
To: Tor Arvid Lund <torarvid@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 12 22:07:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ousq2-0004Nw-C5
	for gcvg-git-2@lo.gmane.org; Sun, 12 Sep 2010 22:07:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753495Ab0ILUHm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Sep 2010 16:07:42 -0400
Received: from borg.org ([64.105.205.123]:38162 "EHLO borg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752972Ab0ILUHg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Sep 2010 16:07:36 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: kentborg)
	by borg.org (Postfix) with ESMTP id 607DA87805;
	Sun, 12 Sep 2010 16:07:31 -0400 (EDT)
User-Agent: Thunderbird 2.0.0.24 (X11/20100411)
In-Reply-To: <AANLkTi=NGsY3wDiTLwNLpw4TJMpiSY8A=az_=v2fYDLj@mail.gmail.com>
X-Enigmail-Version: 0.95.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156049>

Tor Arvid Lund wrote:
> When messing about with git-p4 I have sometimes messed up that
> p4/master ref myself. I can normally fix it by setting it manually

Um, I maybe just did that before I saw your e-mail.

I edited:

  .git/info/refs
  .git/ORIG_HEAD
  .git/packed/refs

...and put in the sha1 of the "[git-p4:"-commit.

When I now do:

  $ git rev-list --no-merges remotes/p4/master..master

I get just the one commit that I hoped to get!

...did I just fix it?

I don't have time to try the "git p4 submit" now, I am going to be late
in meeting my wife.  Tomorrow morning...will it work?


Thanks so very much for your help,

-kb
