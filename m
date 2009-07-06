From: Florian Mickler <florian@mickler.org>
Subject: Re: Checking for fast-forward
Date: Mon, 6 Jul 2009 23:26:14 +0200
Message-ID: <20090706232614.32602ccc@schatten>
References: <ca4f67be0907060936v7bf7c44y4395717fff854fd4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Lee Griffiths <poddster@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 06 23:50:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MNw5I-0008M0-A0
	for gcvg-git-2@gmane.org; Mon, 06 Jul 2009 23:50:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753146AbZGFVui (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jul 2009 17:50:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752927AbZGFVui
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Jul 2009 17:50:38 -0400
Received: from ist.d-labs.de ([213.239.218.44]:43094 "EHLO mx01.d-labs.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752757AbZGFVuh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jul 2009 17:50:37 -0400
X-Greylist: delayed 1448 seconds by postgrey-1.27 at vger.kernel.org; Mon, 06 Jul 2009 17:50:37 EDT
Received: from schatten (f053209007.adsl.alicedsl.de [78.53.209.7])
	by mx01.d-labs.de (Postfix) with ESMTP id 58BD8C7BED;
	Mon,  6 Jul 2009 23:26:29 +0200 (CEST)
Newsgroups: gmane.comp.version-control.msysgit
In-Reply-To: <ca4f67be0907060936v7bf7c44y4395717fff854fd4@mail.gmail.com>
X-Newsreader: Claws Mail 3.7.1 (GTK+ 2.14.7; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122801>

this is more of a git question, than smth special to msysgit. 

(git ml cc'd)

On Mon, 6 Jul 2009 17:36:54 +0100
Lee Griffiths <poddster@gmail.com> wrote:

> 
> I have a script that checks for fast-forwarding by doing a git push
> --dry-run. This strikes me as the wrong way to do it as it does _all_
> of the stuff a git push would normally do i.e., packing and so on, and
> I'm only really after the fast-forward check. Seeing as I already do a
> git push at the end of the script (actualy two, as I do a --tags one
> as well[1]), it seems like a big waste of time. Is there anyother way
> to check and see if the git push would work? (I want the script to
> avoid doing a git pull if possible).
> 
> 
> Thanks,
> Lee
> 
> 
> 
> [1] I originally assumed --tags would push the data AND the tags, but
> that doesn't seem to be the case.... Am I wrong in this?
> 
