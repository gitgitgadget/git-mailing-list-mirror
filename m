From: Jan =?UTF-8?B?S3LDvGdlcg==?= <jk@jk.gs>
Subject: Re: [PATCH] git-pull.sh: overhaul error handling when no 
 candidates are found
Date: Thu, 12 Nov 2009 16:25:58 +0100
Message-ID: <20091112162558.6b1c4a43@perceptron>
References: <1257945756.26362.79.camel@heerbeest>
	<48B54636-1825-48B3-BECD-4150A55B013F@dbservice.com>
	<1257965806.26362.132.camel@heerbeest>
	<D6B0AE61-6CA3-4F79-BB50-B8795415BAB7@dbservice.com>
	<1257968052.26362.155.camel@heerbeest>
	<AC99BA30-A36D-4798-8E7D-9D69EFE99D55@dbservice.com>
	<1258035449.26362.273.camel@heerbeest>
	<20091112155310.7836c388@perceptron>
	<20091112150626.GA24848@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Jan Nieuwenhuizen <janneke-list@xs4all.nl>,
	Tomas Carnecky <tom@dbservice.com>,
	git list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Nov 12 16:26:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N8bYl-0003Ew-Pk
	for gcvg-git-2@lo.gmane.org; Thu, 12 Nov 2009 16:26:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752768AbZKLPZ4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Nov 2009 10:25:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752685AbZKLPZ4
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Nov 2009 10:25:56 -0500
Received: from zoidberg.org ([88.198.6.61]:43248 "EHLO cthulhu.zoidberg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752426AbZKLPZz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Nov 2009 10:25:55 -0500
Received: from perceptron (xdsl-78-35-170-176.netcologne.de [::ffff:78.35.170.176])
  (IDENT: unknown, AUTH: LOGIN jast, TLS: TLSv1/SSLv3,128bits,AES128-SHA)
  by cthulhu.zoidberg.org with esmtp; Thu, 12 Nov 2009 16:26:00 +0100
  id 004D0152.4AFC2908.00000756
In-Reply-To: <20091112150626.GA24848@coredump.intra.peff.net>
X-Mailer: Claws Mail 3.7.3 (GTK+ 2.18.3; i486-pc-linux-gnu)
X-Obscure-Spam: http://music-jk.net/
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132774>

> Personally, I would go the other way: give them something they can cut
> and paste on the command line, like:

A matter of taste, I suppose. The user has to edit the lines anyway
since they contain placeholders.

> Isn't branch.*.rebase a boolean value?

Argh! Of course it is. Note to self: don't write patches in a hurry.
Disregard everything I said. I thought I was seeing incorrect behavior
in what Jan (N.) reported...

Jan
