From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: A git-mv question
Date: Mon, 01 Feb 2010 19:29:26 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1002011927490.1681@xanadu.home>
References: <ron1-09EE6C.16083801022010@news.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Ron Garret <ron1@flownet.com>
X-From: git-owner@vger.kernel.org Tue Feb 02 01:29:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nc6eJ-0004FS-35
	for gcvg-git-2@lo.gmane.org; Tue, 02 Feb 2010 01:29:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752471Ab0BBA3k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Feb 2010 19:29:40 -0500
Received: from relais.videotron.ca ([24.201.245.36]:20105 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752042Ab0BBA3k (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Feb 2010 19:29:40 -0500
Received: from xanadu.home ([66.130.28.92]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KX6006PIUP2XHH1@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 01 Feb 2010 19:29:26 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <ron1-09EE6C.16083801022010@news.gmane.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138665>

On Mon, 1 Feb 2010, Ron Garret wrote:

> If I do a git-mv *and* edit the file all in one commit, does that get 
> recorded in a way that allows git to track the change through the 
> changed file name?  In other words, if I do just a git-mv (without 
> changing the file) git can track that by observing that two differently 
> named objects in two different commit trees contain the same blob.  But 
> if the file is edited then the blobs will be different.  Is git smart 
> enough to distinguish a git-mv and edit from, say, the equivalent git-rm 
> and git-add?  If so, how does it do it?

Please see:

http://www.kernel.org/pub/software/scm/git/docs/gitdiffcore.html


Nicolas
