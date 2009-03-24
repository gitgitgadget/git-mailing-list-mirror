From: Nicolas Pitre <nico@cam.org>
Subject: Re: fatal: unable to write sha1 file git 1.6.2.1
Date: Tue, 24 Mar 2009 15:30:47 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0903241527420.26337@xanadu.home>
References: <49C9246E.3030508@mycircuit.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Peter <vmail@mycircuit.org>
X-From: git-owner@vger.kernel.org Tue Mar 24 20:32:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmCMe-0005lg-Qh
	for gcvg-git-2@gmane.org; Tue, 24 Mar 2009 20:32:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758670AbZCXTbL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Mar 2009 15:31:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758908AbZCXTbK
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Mar 2009 15:31:10 -0400
Received: from relais.videotron.ca ([24.201.245.36]:31017 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757116AbZCXTbJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Mar 2009 15:31:09 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KH000LJ7ZJBTI60@VL-MO-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 24 Mar 2009 15:30:47 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <49C9246E.3030508@mycircuit.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114479>

On Tue, 24 Mar 2009, Peter wrote:

> Hi
> I try to add a directory with lots of binary files to a git repository.
> I receive the error message:
> *
> fatal: unable to write sha1 file
> 
> *This is  git 1.6.2.1.
> 
> Are there limits concerning binary files ( like executables , images ) for the
> inclusion in a git repo ?

Currently, Git is unable to deal with files that it cannot load entirely 
in memory.

What is the size of your largest file?


Nicolas
