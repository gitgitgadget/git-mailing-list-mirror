From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: keeping track of where a patch begins
Date: Wed, 21 Oct 2009 14:14:37 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0910211402490.21460@xanadu.home>
References: <3a69fa7c0910210745r311cf18xf966f5c63650cde6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: E R <pc88mxer@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 21 20:14:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0fhs-0001LC-4W
	for gcvg-git-2@lo.gmane.org; Wed, 21 Oct 2009 20:14:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754672AbZJUSOd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Oct 2009 14:14:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754642AbZJUSOd
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Oct 2009 14:14:33 -0400
Received: from relais.videotron.ca ([24.201.245.36]:31553 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754467AbZJUSOd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Oct 2009 14:14:33 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KRV00KOGMODCW70@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 21 Oct 2009 14:14:37 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <3a69fa7c0910210745r311cf18xf966f5c63650cde6@mail.gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130947>

On Wed, 21 Oct 2009, E R wrote:

> What solutions have you come up with to either to catch or prevent
> this from happening? It is possible to determine what node a branch
> started from?

This can be determined by looking at the gitk output.

Also 'git merge-base' can give you that node, given the main branch and 
the topic branch.  See documentation about git-merge-base.

Then if you need to move a branch to another starting node, then 'git 
rebase' is what you need (again the git-rebase documentation is pretty 
detailed).


Nicolas
