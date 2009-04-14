From: Jan =?UTF-8?B?S3LDvGdlcg==?= <jk@jk.gs>
Subject: Re: git init permissions?
Date: Tue, 14 Apr 2009 20:40:24 +0200
Message-ID: <20090414204024.5371fcac@perceptron>
References: <49E4D16E.9050500@pelagic.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: "Ferry Huberts (Pelagic)" <ferry.huberts@pelagic.nl>
X-From: git-owner@vger.kernel.org Tue Apr 14 20:42:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ltnav-0007aZ-4r
	for gcvg-git-2@gmane.org; Tue, 14 Apr 2009 20:42:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756839AbZDNSkc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Apr 2009 14:40:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757027AbZDNSka
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Apr 2009 14:40:30 -0400
Received: from zoidberg.org ([88.198.6.61]:60364 "EHLO cthulhu.zoidberg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757068AbZDNSk3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Apr 2009 14:40:29 -0400
Received: from perceptron (xdsl-78-34-167-14.netcologne.de [::ffff:78.34.167.14])
  (IDENT: unknown, AUTH: LOGIN jast, TLS: TLSv1/SSLv3,256bits,AES256-SHA)
  by cthulhu.zoidberg.org with esmtp; Tue, 14 Apr 2009 20:40:27 +0200
  id 004045E6.49E4D89B.0000651C
In-Reply-To: <49E4D16E.9050500@pelagic.nl>
X-Mailer: Claws Mail 3.5.0 (GTK+ 2.14.4; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116551>

Hi,

On Tue, 14 Apr 2009 20:09:50 +0200, "Ferry Huberts (Pelagic)"
<ferry.huberts@pelagic.nl> wrote:

> Is there some kind of reason that the branches directory is
> not created with +s permissions?

Probably because it isn't really used anymore. It's more like a
historical artifact. Branch refs actually live in refs/heads/ and the
like (or in the packed-refs file).

-Jan
