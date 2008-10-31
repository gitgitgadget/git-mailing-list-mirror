From: Nicolas Pitre <nico@cam.org>
Subject: Re: Are binary xdeltas only used if you use git-gc?
Date: Fri, 31 Oct 2008 15:31:05 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0810311530290.13034@xanadu.home>
References: <f1d2d9ca0810310243r669840bbj2c5ee7183e0caaed@mail.gmail.com>
 <20081031110245.GA22633@artemis.corp>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Thanassis Tsiodras <ttsiodras@gmail.com>, git@vger.kernel.org
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Fri Oct 31 20:32:44 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KvzjO-0005tb-Gd
	for gcvg-git-2@gmane.org; Fri, 31 Oct 2008 20:32:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751096AbYJaTbQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Oct 2008 15:31:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751723AbYJaTbP
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Oct 2008 15:31:15 -0400
Received: from relais.videotron.ca ([24.201.245.36]:22884 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751883AbYJaTbN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Oct 2008 15:31:13 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K9M00F9VBJTKA70@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 31 Oct 2008 15:31:06 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <20081031110245.GA22633@artemis.corp>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99625>

On Fri, 31 Oct 2008, Pierre Habouzit wrote:

> On Fri, Oct 31, 2008 at 09:43:43AM +0000, Thanassis Tsiodras wrote:
> > So even though the xdelta is just 8KB, and git-gc actually finds out
> > that indeed
> > the new file is very similar to the old one, the initial commit of the
> > new version
> > in the repos is not taking advantage.
> 
> Have you tried to git repack with aggressive options, like:
> 
>     git repack --window=500 --depth=500 \
>       --window-memory=<fair amount of your physical RAM>

That wouldn't bring any benefit in this case.


Nicolas
