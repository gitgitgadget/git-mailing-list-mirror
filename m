From: Jan =?UTF-8?B?S3LDvGdlcg==?= <jk@jk.gs>
Subject: Re: Autodiscovery of git repositories from HTML
Date: Tue, 27 Oct 2009 14:32:29 +0100
Message-ID: <20091027143229.78140450@perceptron>
References: <20091027130000.GX30085@Dorothy.plexq.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Thomas Thurman <tthurman@gnome.org>
X-From: git-owner@vger.kernel.org Tue Oct 27 14:35:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N2mA9-0004B2-Df
	for gcvg-git-2@lo.gmane.org; Tue, 27 Oct 2009 14:32:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754604AbZJ0Nc2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Oct 2009 09:32:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754521AbZJ0Nc1
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Oct 2009 09:32:27 -0400
Received: from zoidberg.org ([88.198.6.61]:43342 "EHLO cthulhu.zoidberg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754260AbZJ0Nc1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Oct 2009 09:32:27 -0400
Received: from perceptron (xdsl-78-35-136-244.netcologne.de [::ffff:78.35.136.244])
  (IDENT: unknown, AUTH: LOGIN jast, TLS: TLSv1/SSLv3,128bits,AES128-SHA)
  by cthulhu.zoidberg.org with esmtp; Tue, 27 Oct 2009 14:32:31 +0100
  id 004D0114.4AE6F66F.00001463
In-Reply-To: <20091027130000.GX30085@Dorothy.plexq.com>
X-Mailer: Claws Mail 3.7.3 (GTK+ 2.16.1; i486-pc-linux-gnu)
X-Obscure-Spam: http://music-jk.net/
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131332>

> I have a web page which lives in a git repository so that it can be 
> easily mirrored.  I would like to use a "rel" link to the URL of the
> git repository so that it can be automatically discovered, like an
> RSS feed:
> 
> <link rel="alternate" type="???" href="http://example.com/.git"/>
> 
> Is there any existing convention as to what the type should be?

I don't think there is any such convention, since I don't think anyone
has done this before (but it would have interesting use cases).

Actually, I don't think rel="alternate" describes the relation well; a
repository isn't exactly an alternate version of the document.

If we don't care about the standard, we might want to use something like
the widely used rel="shortcut icon", e.g. rel="git repository".

Jan
