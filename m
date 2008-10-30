From: "Jan =?UTF-8?B?S3LDvGdlcg==?=" <jk@jk.gs>
Subject: Re: [PATCH] Introduce receive.denyDeletes
Date: Thu, 30 Oct 2008 19:45:03 +0100
Message-ID: <20081030194503.2f9ece1a@perceptron>
References: <20081030191134.62455c24@perceptron>
	<20081030183210.GO14786@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Oct 30 19:46:53 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KvcXa-0001iL-99
	for gcvg-git-2@gmane.org; Thu, 30 Oct 2008 19:46:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753591AbYJ3SpK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Oct 2008 14:45:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755581AbYJ3SpK
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Oct 2008 14:45:10 -0400
Received: from zoidberg.org ([213.133.99.5]:33237 "EHLO cthulhu.zoidberg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753591AbYJ3SpJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Oct 2008 14:45:09 -0400
Received: from perceptron (xdsl-87-78-167-87.netcologne.de [::ffff:87.78.167.87])
  (IDENT: unknown, AUTH: LOGIN jast, TLS: TLSv1/SSLv3,256bits,AES256-SHA)
  by cthulhu.zoidberg.org with esmtp; Thu, 30 Oct 2008 19:45:07 +0100
  id 001627CA.490A00B3.00002ABF
In-Reply-To: <20081030183210.GO14786@spearce.org>
X-Mailer: Claws Mail 3.3.1 (GTK+ 2.12.9; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99520>

On Thu, 30 Oct 2008 11:32:10 -0700, "Shawn O. Pearce"
<spearce@spearce.org> wrote:
> >  test_expect_success \
> > [snip]
> > +	git send-pack ./victim/.git/ :extra master && return 1
> 
> Hmm, that should be:
> 
>   test_must_fail git send-pack ./victim/.git/ :extra master

Can I then delete the branch afterwards without lots of juggling (in
case the test fails due to a random other reason that the branch
accidentally getting deleted by receive-pack)? I'd expect I'd have to
save the exit code to a temporary variable and that's just as ugly.

Disclaimer: I sort of just hacked the test case together by stringing
together pieces of existing test code, so I don't presume full
understanding of the test framework.

By the way, I love what your mail client did to my name.

-Jan
