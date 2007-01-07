From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: [KORG] Re: kernel.org lies about latest -mm kernel
Date: Mon, 8 Jan 2007 12:32:26 +1300
Message-ID: <46a038f90701071532o6d55b92eu4c8399ed6149b2e@mail.gmail.com>
References: <20061214223718.GA3816@elf.ucw.cz>
	 <1166297434.26330.34.camel@localhost.localdomain>
	 <1166304080.13548.8.camel@nigel.suspend2.net>
	 <459152B1.9040106@zytor.com>
	 <1168140954.2153.1.camel@nigel.suspend2.net>
	 <45A07587.3080503@garzik.org> <20070107201146.GA21956@suse.de>
	 <7v4pr21p0o.fsf@assigned-by-dhcp.cox.net>
	 <45A1727B.7070302@garzik.org>
	 <Pine.LNX.4.64.0701071452300.3661@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Jeff Garzik" <jeff@garzik.org>, "Junio C Hamano" <junkio@cox.net>,
	"Greg KH" <gregkh@suse.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 08 00:32:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H3hVD-00040Q-KV
	for gcvg-git@gmane.org; Mon, 08 Jan 2007 00:32:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965246AbXAGXc2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 7 Jan 2007 18:32:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965247AbXAGXc2
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Jan 2007 18:32:28 -0500
Received: from wr-out-0506.google.com ([64.233.184.227]:25770 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965246AbXAGXc1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jan 2007 18:32:27 -0500
Received: by wr-out-0506.google.com with SMTP id 68so1190566wri
        for <git@vger.kernel.org>; Sun, 07 Jan 2007 15:32:26 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=VubmbdqUM/ptrblAO31Y/q2JDfsQPE5/3ZVaf6McoDxgJWC/ugYkYcc96U7WAlazu0IFtJZ0xuAljjzoSA5Y24dexJ+6FPs20IsnUxc6q59ZeIxzPCLs673Dmp4JqtRgCyAXAGiC1n9Z1Y6U43QV7xCtJusfQJ0UFqRLVeprTw4=
Received: by 10.90.78.1 with SMTP id a1mr1710817agb.1168212746825;
        Sun, 07 Jan 2007 15:32:26 -0800 (PST)
Received: by 10.90.28.1 with HTTP; Sun, 7 Jan 2007 15:32:26 -0800 (PST)
To: "Linus Torvalds" <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0701071452300.3661@woody.osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36204>

On 1/8/07, Linus Torvalds <torvalds@osdl.org> wrote:
> On Sun, 7 Jan 2007, Jeff Garzik wrote:
> > Yes but what about existing trees?
> > Can you add an alternatives file, then prune, and get the same result as if
> > you had done a clone -s ?
> Yes. Also do
>         git repack -a -d -l
>
> where the "-l" flag is the magic (it says to repack only objects that
> aren't already packed in the alternate repository)

If all kernel.org repos get git-repack -a -d -l and git-pack-refs,
gitweb will see a significant speedup, as some up-to-date checks
become extremely cheap.

cheers



martin
