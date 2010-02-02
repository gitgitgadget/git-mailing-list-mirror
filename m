From: Ron Garret <ron1@flownet.com>
Subject: Re: A git-mv question
Date: Mon, 01 Feb 2010 23:21:58 -0800
Organization: Amalgamated Widgets
Message-ID: <ron1-C9CA44.23215801022010@news.gmane.org>
References: <ron1-09EE6C.16083801022010@news.gmane.org> <alpine.LFD.2.00.1002011927490.1681@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 02 08:24:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NcD7G-0003VA-Og
	for gcvg-git-2@lo.gmane.org; Tue, 02 Feb 2010 08:24:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755608Ab0BBHW1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Feb 2010 02:22:27 -0500
Received: from lo.gmane.org ([80.91.229.12]:51108 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755256Ab0BBHWW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Feb 2010 02:22:22 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1NcD5W-0002hn-Et
	for git@vger.kernel.org; Tue, 02 Feb 2010 08:22:18 +0100
Received: from 68-190-211-184.dhcp.gldl.ca.charter.com ([68.190.211.184])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 02 Feb 2010 08:22:18 +0100
Received: from ron1 by 68-190-211-184.dhcp.gldl.ca.charter.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 02 Feb 2010 08:22:18 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 68-190-211-184.dhcp.gldl.ca.charter.com
User-Agent: MT-NewsWatcher/3.5.1 (Intel Mac OS X)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138688>

In article <alpine.LFD.2.00.1002011927490.1681@xanadu.home>,
 Nicolas Pitre <nico@fluxnic.net> wrote:

> On Mon, 1 Feb 2010, Ron Garret wrote:
> 
> > If I do a git-mv *and* edit the file all in one commit, does that get 
> > recorded in a way that allows git to track the change through the 
> > changed file name?  In other words, if I do just a git-mv (without 
> > changing the file) git can track that by observing that two differently 
> > named objects in two different commit trees contain the same blob.  But 
> > if the file is edited then the blobs will be different.  Is git smart 
> > enough to distinguish a git-mv and edit from, say, the equivalent git-rm 
> > and git-add?  If so, how does it do it?
> 
> Please see:
> 
> http://www.kernel.org/pub/software/scm/git/docs/gitdiffcore.html
> 

Thanks!  A little light reading :-)

rg
