From: "Francis Moreau" <francis.moro@gmail.com>
Subject: Re: git describe origin ?
Date: Sun, 8 Jul 2007 15:51:20 +0200
Message-ID: <38b2ab8a0707080651m2242b518x5313e852621db2cf@mail.gmail.com>
References: <38b2ab8a0707070851m25d615bdn4f7286cbadaf1316@mail.gmail.com>
	 <Pine.LNX.4.64.0707071728330.4093@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jul 08 15:51:29 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I7XAe-0005lO-Pi
	for gcvg-git@gmane.org; Sun, 08 Jul 2007 15:51:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752790AbXGHNv0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 Jul 2007 09:51:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752783AbXGHNv0
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Jul 2007 09:51:26 -0400
Received: from wa-out-1112.google.com ([209.85.146.179]:61436 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752711AbXGHNvZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jul 2007 09:51:25 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1026960wah
        for <git@vger.kernel.org>; Sun, 08 Jul 2007 06:51:25 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=D55TzdSqGssC21IPF20gH1/iTxmjvemif8O3cOgNJoRcZ23XqoKftAULQ7+Uw2+It22+lOC0Gwsm7YPZimGw80jWPE9f3fqVQ1ysedjRJoOZ6G30lZ8YFsmaejLu8B6OWw3wqIuDHz1P27U5lnDQgAyx7nDnp4629I9wgmoHSnU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Pxsp6yuWGYsxFMEQvV0Ufo36zZqdiOX3dVQRmpfY4sPAFrffIbCBIOgadhpdD/DHe1qixw7Sa+IsDTVqq9G4uNaphbco13/RDtvgimkAroGys7Ebai3DHmuHhFlJibwzerWD+uG21V85cM+KUGbIjll1CP5OZ/d0GnE9xjkZxBk=
Received: by 10.114.194.1 with SMTP id r1mr2280343waf.1183902685087;
        Sun, 08 Jul 2007 06:51:25 -0700 (PDT)
Received: by 10.115.47.12 with HTTP; Sun, 8 Jul 2007 06:51:20 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0707071728330.4093@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51884>

On 7/7/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> On Sat, 7 Jul 2007, Francis Moreau wrote:
>
> > I was wondering what does 'git describe origin' command mean on a git
> > repo. Does it mean ?
> >
> >    a/ git describe origin/HEAD
> >    b/ git describe origin/master
> >    c/ something else
>
> This is completely unrelated to "git describe". It is about naming
> commits AKA "specifying revisions". You might find the section "SPECIFYING
> REVISIONS" in Documentation/git-rev-parse.txt especially helpful. FWIW
> this section is hinted at in the section "Symbolic Identifiers" in
> Documentation/git.txt.
>
> If you're too lazy to read, it's a/.
>

Ok I took a look to it and I think I get the idea. But now I don't
understand this example taken from "git-branch" documentation:

"""
Delete unneeded branch

    $ git clone git://git.kernel.org/.../git.git my.git
    $ cd my.git
    $ git branch -d -r todo html man   (1)
"""

I think the last command can't work since the given refs can't be
found according the rules given by the documention you mentioned
earlier.

thanks
-- 
Francis
