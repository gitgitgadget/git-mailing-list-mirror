From: Nicolas Pitre <nico@cam.org>
Subject: Re: why is git destructive by default? (i suggest it not be!)
Date: Mon, 23 Jun 2008 22:17:41 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0806232213360.2979@xanadu.home>
References: <jeske@willow=01l5V7waFEDjChmh>
 <willow-jeske-01l5PFjPFEDjCfzf-01l5V7wbFEDjCX7V@videotron.ca>
 <willow-jeske-01l5cKsCFEDjC=91MX@videotron.ca>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: David Jeske <jeske@google.com>
X-From: git-owner@vger.kernel.org Tue Jun 24 04:19:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KAy7Z-000725-Ct
	for gcvg-git-2@gmane.org; Tue, 24 Jun 2008 04:19:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751688AbYFXCRn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jun 2008 22:17:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751405AbYFXCRn
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jun 2008 22:17:43 -0400
Received: from relais.videotron.ca ([24.201.245.36]:35978 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751364AbYFXCRm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jun 2008 22:17:42 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K2Y00EWM3PHD260@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 23 Jun 2008 22:17:42 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <willow-jeske-01l5cKsCFEDjC=91MX@videotron.ca>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85979>

On Tue, 24 Jun 2008, David Jeske wrote:

> I've heard from a couple users that the solution to these problems is to "go
> dig what you need out of the log, it's still in there". However, it's only in
> there until the log is garbage collected. This either means they are
> destructive operations, or we expect "running without ever collecting the log"
> to be a valid mode of operation... which I doubt is the case.

Why not?

> Question: How about assuring ALL operations can be done non-destructivly by
> default?

	git config --global gc.reflogexpire "2 years"


Nicolas
