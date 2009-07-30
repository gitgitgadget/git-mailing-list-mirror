From: Luciano Rocha <luciano@eurotux.com>
Subject: Re: Pro Git Book
Date: Thu, 30 Jul 2009 16:51:28 +0100
Message-ID: <20090730155127.GB2484@bit.office.eurotux.com>
References: <d411cc4a0907271056x458d7b15lc1b2868a46884175@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git list <git@vger.kernel.org>
To: Scott Chacon <schacon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 30 17:51:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MWXux-0006YT-4V
	for gcvg-git-2@gmane.org; Thu, 30 Jul 2009 17:51:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751459AbZG3Pvf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 30 Jul 2009 11:51:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751363AbZG3Pvf
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Jul 2009 11:51:35 -0400
Received: from os.eurotux.com ([216.75.63.6]:57308 "EHLO os.eurotux.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750701AbZG3Pve (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jul 2009 11:51:34 -0400
Received: (qmail 30513 invoked from network); 30 Jul 2009 15:51:33 -0000
Received: from unknown (HELO bit.office.eurotux.com) (luciano@81.84.255.161)
  by 0 with AES128-SHA encrypted SMTP; 30 Jul 2009 15:51:33 -0000
Content-Disposition: inline
In-Reply-To: <d411cc4a0907271056x458d7b15lc1b2868a46884175@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-07-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124466>

On Mon, Jul 27, 2009 at 10:56:57AM -0700, Scott Chacon wrote:
> Hey all,
>=20
> Just a heads up - I've been working on a book on Git being published
> by Apress called "Pro Git", which is being licensed under a CC 3.0
> license and as I've just finished some of the final reviews, I've put
> the entire content of the book online at:
>=20
> http://progit.org

Many thanks for that. It's an interesting reading. Is it updated often?
There're some typos.

Also, a comment. When you show how to setup a git server with ssh, you
have:
$ su git
$ cd
$ mkdir .ssh

After su make sure umask doesn't allow group-writable, or the ssh daemo=
n
will complay about wrong permissions in .ssh and .ssh/authorized_keys.

$ su git
$ umask 077
$ ..

And reset to more generous defaults after finishing with ssh setup.
(Like by saving the previous value or just using 022.)

Regards,
Luciano Rocha

--=20
Luciano Rocha <luciano@eurotux.com>
Eurotux Inform=E1tica, S.A. <http://www.eurotux.com/>
