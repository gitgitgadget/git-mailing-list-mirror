From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [PATCH 2/6] user-manual: fix inconsistent example
Date: Wed, 14 Mar 2007 19:19:56 -0400
Message-ID: <20070314231956.GA13991@fieldses.org>
References: <7vr6s42xgm.fsf@assigned-by-dhcp.cox.net> <11735877311383-git-send-email-bfields@citi.umich.edu> <11735877321525-git-send-email-bfields@citi.umich.edu> <11735877332438-git-send-email-bfields@citi.umich.edu> <20070311043938.GC25492@fieldses.org> <45F6FC02.3000106@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Thu Mar 15 00:20:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HRclM-00039z-Pz
	for gcvg-git@gmane.org; Thu, 15 Mar 2007 00:20:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964821AbXCNXT7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Mar 2007 19:19:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964824AbXCNXT7
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Mar 2007 19:19:59 -0400
Received: from mail.fieldses.org ([66.93.2.214]:58051 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964821AbXCNXT6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Mar 2007 19:19:58 -0400
Received: from bfields by fieldses.org with local (Exim 4.63)
	(envelope-from <bfields@fieldses.org>)
	id 1HRclA-0003nB-VY; Wed, 14 Mar 2007 19:19:56 -0400
Content-Disposition: inline
In-Reply-To: <45F6FC02.3000106@ramsay1.demon.co.uk>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42250>

On Tue, Mar 13, 2007 at 07:31:14PM +0000, Ramsay Jones wrote:
> J. Bruce Fields wrote:
> >On Sat, Mar 10, 2007 at 11:35:27PM -0500, J. Bruce Fields wrote:
> >>From: J. Bruce Fields <bfields@citi.umich.edu>
> >>
> >>The configuration file fragment here is inconsistent with the text
> >>above.  Thanks to Ramsay Jones for the correction.
> >>
> >>Cc: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
> >
> >Hm, I was hoping git-send-email would pick up Cc: lines from the commit
> >message in addition to Signed-off-by lines; oh well.  (Thanks for those
> >corrections, all were good.)
> >
> >--b.
> >
> 
> Glad to be of help!
> 
> Did you figure out how to fix the diagram breakage?
> (i.e. the "\<lf>" line continuation problem)

I'm working around it by explicitly quoting those diagrams--see e.g.

http://git.kernel.org/?p=git/git.git;a=commit;h=1dc71a9155e209ed4da866eeb7c3064e4568532e

but I'm still trying to figure out exactly why it does that.

--b.
