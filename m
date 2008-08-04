From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: StGit and charsets
Date: Mon, 4 Aug 2008 17:31:46 +0200
Message-ID: <20080804153146.GF12232@diana.vm.bytemark.co.uk>
References: <9e4733910808040721n6c47908o9d8fabd8f16293c1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 04 17:10:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KQ1hq-0005Jl-PO
	for gcvg-git-2@gmane.org; Mon, 04 Aug 2008 17:10:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752899AbYHDPJl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 4 Aug 2008 11:09:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752838AbYHDPJl
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Aug 2008 11:09:41 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1338 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751852AbYHDPJk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Aug 2008 11:09:40 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1KQ22E-0003yE-00; Mon, 04 Aug 2008 16:31:46 +0100
Content-Disposition: inline
In-Reply-To: <9e4733910808040721n6c47908o9d8fabd8f16293c1@mail.gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91369>

On 2008-08-04 10:21:20 -0400, Jon Smirl wrote:

> Do you have tests in place to handle the names and comments in
> patches being in different charsets?

There are some tests in t1800 and t1900 that use non-ascii names.
Might be others, but a quick grep didn't find them.

> I don't work much with international charsets. If someone is using
> something like Russian or Finish locally, is the metadata in the
> patch converted to UTF8 before exporting or sending it as mail?

I think what happens is that it's assumed to be utf8. No one has
complained that their non-utf8 locale doesn't work, but my guess is
that's because those people just haven't tried StGit yet.

> Comments should be in English, but people's names may need UTF8.

Mine does, for example. I started my StGit career by making sure it
could send out patches that didn't mangle my name. (That's a while
ago, though, so my memory's getting a bit rusty.)

> And what about email addresses, does DNS allow Unicode names now?

I think it's up to each TLD whether they want to allow it. See e.g.

  http://en.wikipedia.org/wiki/Internationalized_domain_name

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
