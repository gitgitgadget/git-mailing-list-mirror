From: Stephan Beyer <s-beyer@gmx.net>
Subject: Re: Are these bugs?
Date: Thu, 28 Aug 2008 03:04:58 +0200
Message-ID: <20080828010458.GE12354@leksak.fem-net>
References: <76718490808271636i4de8f385pdaeb1672f06a00d7@mail.gmail.com> <7v1w0akolk.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jay Soffian <jaysoffian@gmail.com>, Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 28 03:06:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYVxg-0005OP-Er
	for gcvg-git-2@gmane.org; Thu, 28 Aug 2008 03:06:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753782AbYH1BFB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2008 21:05:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753874AbYH1BFB
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Aug 2008 21:05:01 -0400
Received: from mail.gmx.net ([213.165.64.20]:37521 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753037AbYH1BFA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2008 21:05:00 -0400
Received: (qmail invoked by alias); 28 Aug 2008 01:04:59 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp058) with SMTP; 28 Aug 2008 03:04:59 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX19iQ0QTFg1iIwcyJtvoxhay8q0JkMv8iV6/p95IQr
	ilDH2RgoX7LJpB
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1KYVwY-0006WR-DO; Thu, 28 Aug 2008 03:04:58 +0200
Content-Disposition: inline
In-Reply-To: <7v1w0akolk.fsf@gitster.siamese.dyndns.org>
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.67
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94005>

Hi,

Junio C Hamano wrote:
> "Jay Soffian" <jaysoffian@gmail.com> writes:
> 
> > I understand why "git reset" failed, but at best the error message is
> > confusing to a new user.
> 
> This is in "patches welcome" category.

<noise>
I sometimes wondered if "git init" should create a dummy commit
with empty tree, empty commit message or something like that and
set refs/heads/master to that and HEAD to master.
But I always said to myself that this is a stupid idea for several
reasons, i.e. backwards compatibility, or: if the dummy commit is to
be ignored (i.e. will not become parent of the first commit),
then it does not really help at all in decreasing complexity.
So I rejected this thought, but now it came back. ;-)

A backwards-compatibily-breaking dummy commit would also help
rebasing onto the dummy (replacing the first real commit).
But I still think it's stupid.
</noise>


So, for a patch, is it sane to just remove/clear the index
if get_sha1("HEAD", sha1) fails?

Regards,
  Stephan

-- 
Stephan Beyer <s-beyer@gmx.net>, PGP 0x6EDDD207FCC5040F
