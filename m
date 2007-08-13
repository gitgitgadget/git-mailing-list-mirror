From: Steven Grimm <koreth@midwinter.com>
Subject: Re: Integrating the kernel tree and lkml
Date: Mon, 13 Aug 2007 10:08:24 +0800
Message-ID: <46BFBD18.50007@midwinter.com>
References: <9e4733910708121731h1245eab3h9e331de8285daf8a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 13 04:08:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IKPMI-00079E-8r
	for gcvg-git@gmane.org; Mon, 13 Aug 2007 04:08:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933874AbXHMCI3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 12 Aug 2007 22:08:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933802AbXHMCI3
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Aug 2007 22:08:29 -0400
Received: from tater2.midwinter.com ([216.32.86.91]:44913 "HELO midwinter.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S933742AbXHMCI2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Aug 2007 22:08:28 -0400
Received: (qmail 10835 invoked from network); 13 Aug 2007 02:08:28 -0000
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=200606; d=midwinter.com;
  b=kz2ONGZxFQjqAH5cFlw7bVe0QRWLc//2renauKU3B4UJsPDCnfrNWKM+hNZmU2fS  ;
Received: from localhost (HELO sgrimm-mbp.local) (koreth@127.0.0.1)
  by localhost with SMTP; 13 Aug 2007 02:08:27 -0000
User-Agent: Thunderbird 2.0.0.6 (Macintosh/20070728)
In-Reply-To: <9e4733910708121731h1245eab3h9e331de8285daf8a@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55741>

Jon Smirl wrote:
> You could load the lkml history into the git db along with the kernel
> tree. Then process the mailing list history to tie discussion threads
> to commits. As you look at commits with gitk you could also see the
> relevant messages on lkml.
>   

That sounds a lot like the "notes" proposal that was discussed on this 
list a couple months back. It included a notion of "soft references" 
which were used to tie commits to the note objects; that would 
presumably apply to the mailing list messages as well. IIRC the 
implementation that was proposed had some issues. Not sure what happened 
to it in the end.

Such a capability would also be a good integration point for bug 
tracking systems.

-Steve
