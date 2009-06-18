From: Nicolas Pitre <nico@cam.org>
Subject: Re: RFH: Unable to get one big pack
Date: Thu, 18 Jun 2009 12:03:03 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0906181152120.16467@xanadu.home>
References: <e5bfff550906180755i774576c1o1c540224cea675ca@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Git Mailing List <git@vger.kernel.org>
To: Marco Costalba <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 18 18:03:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MHK5L-0005mn-77
	for gcvg-git-2@gmane.org; Thu, 18 Jun 2009 18:03:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754259AbZFRQDW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jun 2009 12:03:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753588AbZFRQDV
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Jun 2009 12:03:21 -0400
Received: from relais.videotron.ca ([24.201.245.36]:44835 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751931AbZFRQDV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jun 2009 12:03:21 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KLF0084BZ93TWA0@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 18 Jun 2009 12:03:03 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <e5bfff550906180755i774576c1o1c540224cea675ca@mail.gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121852>

On Thu, 18 Jun 2009, Marco Costalba wrote:

> Sorry for the silly question, but I have tried anything to get one big
> pack instead of many objects.
> 
> I tried git repack but with no success:
> 
> $ git repack -adf
> Counting objects: 3317, done.
> Compressing objects: 100% (3317/3317), done.
> Writing objects: 100% (3317/3317), done.
> Total 3317 (delta 2607), reused 0 (delta 0)
> $ ls -R .git/objects | wc -l
>   519
> $

The -d flag to 'git repack' only deletes old packs.

If you want to remove redundant loose objects then you need to run 
'git prune'.


Nicolas
