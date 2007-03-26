From: Eric Lesh <eclesh@ucla.edu>
Subject: Re: .gitlink for Summer of Code
Date: Mon, 26 Mar 2007 10:38:08 -0700
Message-ID: <1174930688.5662.20.camel@localhost>
References: <1174825838.12540.5.camel@localhost>
	 <vpqvegpe4e1.fsf@olympe.imag.fr> <1174929374.5662.15.camel@localhost>
	 <vpqr6rbex7g.fsf@olympe.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Mon Mar 26 19:58:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HVtSm-0001ve-Gh
	for gcvg-git@gmane.org; Mon, 26 Mar 2007 19:58:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753427AbXCZR6c (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Mar 2007 13:58:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753646AbXCZR6c
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Mar 2007 13:58:32 -0400
Received: from smtp-7.smtp.ucla.edu ([169.232.46.138]:38510 "EHLO
	smtp-7.smtp.ucla.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753632AbXCZR6b (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Mar 2007 13:58:31 -0400
X-Greylist: delayed 1213 seconds by postgrey-1.27 at vger.kernel.org; Mon, 26 Mar 2007 13:58:31 EDT
Received: from mail.ucla.edu (mail.ucla.edu [169.232.47.146])
	by smtp-7.smtp.ucla.edu (8.13.8/8.13.8) with ESMTP id l2QHc8mD019738;
	Mon, 26 Mar 2007 10:38:08 -0700
Received: from [192.168.1.7] (adsl-75-26-198-139.dsl.scrm01.sbcglobal.net [75.26.198.139])
	(authenticated bits=0)
	by mail.ucla.edu (8.13.8/8.13.8) with ESMTP id l2QHc808010453
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NOT);
	Mon, 26 Mar 2007 10:38:08 -0700
In-Reply-To: <vpqr6rbex7g.fsf@olympe.imag.fr>
X-Mailer: Evolution 2.8.1 
X-Probable-Spam: no
X-Scanned-By: smtp.ucla.edu on 169.232.46.138
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43169>

On Mon, 2007-03-26 at 19:22 +0200, Matthieu Moy wrote:
> 
> I don't see any contradiction.
> 
> Light checkouts would have an almost empty .git (it still needs an
> index, and its own head anyway) and use the .git of the main repo for
> everything else.
> 

Josef Weidendorfer tried to implement this before, and he concluded that
having a _text file_ .git, instead of a directory, would be a good way
to distinguish .gitlinked checkouts from normal checkouts.

As far as .git/link, that would seem to work better.  As long as there
is a sanity check to make sure that you don't manage to mix things up,
it might be fine.

-Eric
