From: Jan =?UTF-8?B?S3LDvGdlcg==?= <jk@jk.gs>
Subject: Re: confusion with git diff-tree output
Date: Thu, 22 Oct 2009 00:42:20 +0200
Message-ID: <20091022004220.7e579547@perceptron>
References: <117f2cc80910211043q3a92a7b6o15464cc049ee33dc@mail.gmail.com>
	<20091021195103.01cef9c4@perceptron>
	<117f2cc80910211523m5c1399aej594398fb6597e5de@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: David Roundy <roundyd@physics.oregonstate.edu>
X-From: git-owner@vger.kernel.org Thu Oct 22 00:43:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0jt2-0002c9-7t
	for gcvg-git-2@lo.gmane.org; Thu, 22 Oct 2009 00:42:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755822AbZJUWmV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Oct 2009 18:42:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755797AbZJUWmV
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Oct 2009 18:42:21 -0400
Received: from zoidberg.org ([88.198.6.61]:56481 "EHLO cthulhu.zoidberg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755132AbZJUWmV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Oct 2009 18:42:21 -0400
Received: from perceptron (xdsl-78-35-156-26.netcologne.de [::ffff:78.35.156.26])
  (IDENT: unknown, AUTH: LOGIN jast, TLS: TLSv1/SSLv3,128bits,AES128-SHA)
  by cthulhu.zoidberg.org with esmtp; Thu, 22 Oct 2009 00:42:22 +0200
  id 004D0140.4ADF8E4F.000073A9
In-Reply-To: <117f2cc80910211523m5c1399aej594398fb6597e5de@mail.gmail.com>
X-Mailer: Claws Mail 3.7.3 (GTK+ 2.16.1; i486-pc-linux-gnu)
X-Obscure-Spam: http://music-jk.net/
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130982>

> David Roundy <roundyd@physics.oregonstate.edu> wrote:

> You're right.  I figured I must be overlooking something obvious, and
> that was it.  What surprised me was that -p implies -r, which is not
> documented.  Since the -p output was recursive, I incorrectly presumed
> that this was the default.

I suppose that's because you can't really display the diff for a
directory in any meaningful way other than recursing.

Jan
