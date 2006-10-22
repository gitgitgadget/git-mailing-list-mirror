From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [PATCH] RFC2047-encode email headers
Date: Sun, 22 Oct 2006 14:12:40 +0200
Message-ID: <20061022121240.GA21084@diana.vm.bytemark.co.uk>
References: <20061022120217.7650.23715.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 22 14:12:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GbcC9-0002lF-BI
	for gcvg-git@gmane.org; Sun, 22 Oct 2006 14:12:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751780AbWJVMMn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 22 Oct 2006 08:12:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751781AbWJVMMn
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Oct 2006 08:12:43 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:11528 "EHLO
	diana.vm.bytemark.co.uk") by vger.kernel.org with ESMTP
	id S1751780AbWJVMMn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Oct 2006 08:12:43 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1GbcC0-0005nO-00; Sun, 22 Oct 2006 13:12:40 +0100
To: Catalin Marinas <catalin.marinas@gmail.com>
Content-Disposition: inline
In-Reply-To: <20061022120217.7650.23715.stgit@localhost>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29724>

On 2006-10-22 14:02:17 +0200, Karl Hasselstr=F6m wrote:

> From: Karl Hasselstr=C3=B6m <kha@treskal.com>

OK, this patch did what it was supposed to do -- which was to encode
the mail headers properly -- but StGIT still generates an 8-bit
encoded body, and vger doesn't seem to like that (see the X-Warning:
headers it added to the patch mail). That's another fix for another
day.

Catalin, if you take this patch, I'd appreciate it if you made double
sure that my name doesn't have garbage in it. (It may very well be
that the copy of the patch sent to you personally is unharmed; it all
works fine when I send patches to myself. vger is the only mail server
I have seen that has this problem.)

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
