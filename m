From: Jeff King <peff@peff.net>
Subject: Re: Odd remote: error: packfile ./objects/pack/pack-FOO.pack cannot
 be accessed
Date: Tue, 3 Jan 2012 14:33:49 -0500
Message-ID: <20120103193349.GE20926@sigill.intra.peff.net>
References: <CAOoYcj2pnNtK3RshcJFwiXK356cZz6M38-NG1_uORjknyhdAKQ@mail.gmail.com>
 <CAOoYcj0JO4q0GJRzuexQR6OAng2PdZX8gD7zNYNoOCmCCLqz4Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Sudarshan Wadkar <wadkar@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 03 20:33:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RiA7R-0005Kj-5v
	for gcvg-git-2@lo.gmane.org; Tue, 03 Jan 2012 20:33:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754374Ab2ACTdx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 Jan 2012 14:33:53 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:55519
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751796Ab2ACTdv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jan 2012 14:33:51 -0500
Received: (qmail 9105 invoked by uid 107); 3 Jan 2012 19:40:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 03 Jan 2012 14:40:41 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 03 Jan 2012 14:33:49 -0500
Content-Disposition: inline
In-Reply-To: <CAOoYcj0JO4q0GJRzuexQR6OAng2PdZX8gD7zNYNoOCmCCLqz4Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187877>

On Mon, Jan 02, 2012 at 02:48:22PM +0530, Sudarshan Wadkar wrote:

> But when I push, I get this odd error from remote
>=20
> $ git push --verbose --mirror
> ssh://wadkar@192.168.1.177:7185/~wadkar/repo/bare/myproj.git
> Pushing to ssh://wadkar@192.168.1.177:7185/~wadkar/repo/bare/myproj.g=
it
> Counting objects: 5, done.
> Delta compression using up to 4 threads.
> Compressing objects: 100% (3/3), done.
> Writing objects: 100% (3/3), 323 bytes, done.
> Total 3 (delta 2), reused 0 (delta 0)
> remote: error: packfile
> ./objects/pack/pack-17900952dc824651db15369a341eec8d3e8f39d2.pack
> cannot be accessed
> remote: HEAD is now at 4d5a6f1 Investigate and report odd error
> To ssh://wadkar@192.168.1.177:7185/~wadkar/repo/bare/myproj.git
> =C2=A0=C2=A0 d066a2f..4d5a6f1=C2=A0 master -> master

Is it always the same pack? If so, have you tried looking in the
objects/pack directory to make sure it's not a permissions problem?

-Peff
