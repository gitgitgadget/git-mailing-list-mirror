From: Jeff King <peff@peff.net>
Subject: Re: Compiling git svn from source
Date: Wed, 11 Dec 2013 06:34:58 +0800
Message-ID: <20131210223456.GA7643@sigill.intra.peff.net>
References: <CAHCisteVsy4_GX_1PNZfO44w1WmW28vAY0PBfwo9CL_Ze8fw2A@mail.gmail.com>
 <20131210190129.GD2311@google.com>
 <CAHCistfcBt0oOz=whsrifSB3M6cN8Bk=UHOq-G_+EYOHhrXjkw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: avinash r <nashpapa@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 10 23:35:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VqVtX-0001oH-QE
	for gcvg-git-2@plane.gmane.org; Tue, 10 Dec 2013 23:35:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750989Ab3LJWfH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Dec 2013 17:35:07 -0500
Received: from cloud.peff.net ([50.56.180.127]:57963 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750960Ab3LJWfG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Dec 2013 17:35:06 -0500
Received: (qmail 1785 invoked by uid 102); 10 Dec 2013 22:35:06 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (123.127.199.246)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 10 Dec 2013 16:35:06 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 11 Dec 2013 06:34:58 +0800
Content-Disposition: inline
In-Reply-To: <CAHCistfcBt0oOz=whsrifSB3M6cN8Bk=UHOq-G_+EYOHhrXjkw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239158>

On Wed, Dec 11, 2013 at 01:54:26AM +0530, avinash r wrote:

> but running the command,
> 
> $ git svn init --username=<username> http://mydomain.com/myrepo causes
> the command to fail with the following error:
> 
> Can't locate SVN/Core.pm in @INC (@INC contains:
> /usr/local/share/perl/5.14.2 /etc/perl /usr/local/lib/perl/5.14.2
> [...]

git-svn relies on having subversion's own perl libraries installed by
the system. If you are on a debian/ubuntu-based system, "apt-get install
libsvn-perl" should do it; I don't know the package-name offhand for
other systems.

-Peff
