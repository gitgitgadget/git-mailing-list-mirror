From: Martin Atukunda <matlads@dsmagic.com>
Subject: Re: Add uninstall target to Makefile
Date: Sun, 18 Sep 2005 13:03:00 +0300
Message-ID: <20050918100300.GA9890@igloo.ds.co.ug>
References: <20050916125814.GA8084@igloo.ds.co.ug> <7vfys5ndor.fsf@assigned-by-dhcp.cox.net> <20050916175402.GC22825@tuxdriver.com> <20050916180810.GK8041@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sun Sep 18 12:06:11 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EGw3W-0003EP-P1
	for gcvg-git@gmane.org; Sun, 18 Sep 2005 12:05:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750828AbVIRKFi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Sep 2005 06:05:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750829AbVIRKFi
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Sep 2005 06:05:38 -0400
Received: from mail1.imul.com ([217.113.72.31]:57391 "EHLO mail1.infocom.co.ug")
	by vger.kernel.org with ESMTP id S1750828AbVIRKFi (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 18 Sep 2005 06:05:38 -0400
Received: from entandikwa.ds.co.ug ([::ffff:217.113.73.39])
  by mail1.infocom.co.ug with esmtp; Sun, 18 Sep 2005 13:05:22 +0300
  id 000E5E2D.432D3BE2.00003E40
Received: from igloo.ds.co.ug (igloo.ds.co.ug [192.168.129.66])
	by entandikwa.ds.co.ug (Postfix) with ESMTP id A27554DC0
	for <git@vger.kernel.org>; Sun, 18 Sep 2005 13:06:20 +0300 (EAT)
Received: from matlads by igloo.ds.co.ug with local (Exim 4.52)
	id 1EGw0i-0002ad-MJ
	for git@vger.kernel.org; Sun, 18 Sep 2005 13:03:00 +0300
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20050916180810.GK8041@shell0.pdx.osdl.net>
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8778>


On Fri, Sep 16, 2005 at 11:08:10AM -0700, Chris Wright wrote:
> * John W. Linville (linville@tuxdriver.com) wrote:
> > > Sorry, I absolutely detest other peoples' Makefiles that has
> > > this target.  Why would anybody want this?
> > 
> > Is this a serious question?  To uninstall the binaries e.g. if you
> > installed them in the wrong place?
> 
> Of course package manager will do better at this, but it is useful to be
> able to uninstall.  However, I don't think Martin's external script with
> all the filenames hardcoded is the right approach.  There are $(PROG)
> and $(SCRIPTS) which already know all these filenames.

The external script only removes the symlinks created by ./cmd-rename.sh

- Martin -
