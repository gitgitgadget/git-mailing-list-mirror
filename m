From: "Bernhard R. Link" <brl+git@mail.brlink.eu>
Subject: Re: git:// protocol over SSL/TLS
Date: Fri, 27 Dec 2013 17:26:07 +0100
Message-ID: <20131227162606.GA6973@client.brlink.eu>
References: <CAErtv27qUMo9LsGAZtk5Zv9qnZRB_YAXhtskvrrNbWGqadQh7Q@mail.gmail.com>
 <20131227173655.3f3109e7ba848c90b302e2f9@domain007.com>
 <CAErtv25JGxEs3ytAB019yajQooNs4k=bzukSE9kuHWAbir9-BQ@mail.gmail.com>
 <87mwjm4c3s.fsf@igel.home>
 <vpqwqiqpe80.fsf@anie.imag.fr>
 <CAErtv25URyB3znN1CMd87374NUjaSFvg=cee_-c=s8bB2j052A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Andreas Schwab <schwab@linux-m68k.org>,
	Konstantin Khomoutov <flatworm@users.sourceforge.net>,
	Git List <git@vger.kernel.org>
To: Sergey Sharybin <sergey.vfx@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 27 18:16:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vwb19-0002oI-46
	for gcvg-git-2@plane.gmane.org; Fri, 27 Dec 2013 18:16:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753776Ab3L0RQF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Dec 2013 12:16:05 -0500
Received: from server.brlink.eu ([78.46.187.186]:55410 "EHLO server.brlink.eu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751225Ab3L0RQE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Dec 2013 12:16:04 -0500
X-Greylist: delayed 1761 seconds by postgrey-1.27 at vger.kernel.org; Fri, 27 Dec 2013 12:16:04 EST
Received: from client.brlink.eu 
	by server.brlink.eu with esmtpsa (tls-peer-hash KfHJgA)
	id 1VwaYW-0001B5-Nx; Fri, 27 Dec 2013 17:46:36 +0100
Received: with local; Fri, 27 Dec 2013 17:26:09 +0100
Content-Disposition: inline
In-Reply-To: <CAErtv25URyB3znN1CMd87374NUjaSFvg=cee_-c=s8bB2j052A@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239742>

* Sergey Sharybin <sergey.vfx@gmail.com> [131227 15:25]:
> Security in this case is about being sure everyone gets exactly the
> same repository as stored on the server, without any modifications to
> the sources cased by MITM.

Note that ssl (and thus https) only helps here against a resource-less
man-in-the-middle. Getting catch-all CA-signed certificates is said to
no longer available to everyone as easily as it was some years ago, but
unless you allow only one private CA (and even there clients often fail)
you still should assume everyone resourceful enough to still be able to
do MITM.

        Bernhard R. Link
