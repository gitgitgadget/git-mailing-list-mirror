From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 2/2] gitk: Markup many strings for translation.
Date: Sat, 28 Jul 2007 12:40:20 +1000
Message-ID: <18090.44180.802184.747398@cargo.ozlabs.ibm.com>
References: <959247.27950.qm@web38905.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Christian Stimming <stimming@tuhh.de>, git@vger.kernel.org
To: Brett Schwarz <brett_schwarz@yahoo.com>
X-From: git-owner@vger.kernel.org Sat Jul 28 04:40:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IEcEK-0002w3-52
	for gcvg-git@gmane.org; Sat, 28 Jul 2007 04:40:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932422AbXG1Ck1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 Jul 2007 22:40:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759904AbXG1Ck1
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jul 2007 22:40:27 -0400
Received: from ozlabs.org ([203.10.76.45]:53105 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758416AbXG1Ck0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jul 2007 22:40:26 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id 494D5DDE2A; Sat, 28 Jul 2007 12:40:25 +1000 (EST)
In-Reply-To: <959247.27950.qm@web38905.mail.mud.yahoo.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53990>

Brett Schwarz writes:

> > -        set commitinfo($id) {"No commit information available"}
> > +        set commitinfo($id) {[mc "No commit information available"]}
> 
> I think this is probably a typo (on the original), and carrying that
> forward will probably result in what was not intended.
> 
> The original has the {} and "". I don't know if this was intended
> (it will keep the quotes).

Yes it is what was intended - it is a list with one element, which is
a string.

Paul.
