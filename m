From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: Patchdiff
Date: Tue, 26 Jan 2010 20:19:13 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1001262014250.1681@xanadu.home>
References: <fabb9a1e1001261606i4f706387vaf5647436e454fb4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Git List <git@vger.kernel.org>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 27 02:19:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NZwYw-0003OH-8i
	for gcvg-git-2@lo.gmane.org; Wed, 27 Jan 2010 02:19:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754947Ab0A0BTP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jan 2010 20:19:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754287Ab0A0BTP
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Jan 2010 20:19:15 -0500
Received: from relais.videotron.ca ([24.201.245.36]:40285 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752539Ab0A0BTO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jan 2010 20:19:14 -0500
Received: from xanadu.home ([66.130.28.92]) by VL-MR-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0KWV0059ET01A7O0@VL-MR-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 26 Jan 2010 20:19:13 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <fabb9a1e1001261606i4f706387vaf5647436e454fb4@mail.gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138097>

On Wed, 27 Jan 2010, Sverre Rabbelier wrote:

> Heya,
> 
> Do we have anything that allows me to compare two versions of a patch?
> In theory it'd do something like "apply both patches to the their
> merge base, then show the diff between the results". I don't think we
> have something like that, since there's probably some major caveats
> about conflicts when applying the patches to their merge-base. Or
> perhaps my theory is silly, and there's an easier way to compare two
> patches (other than looking at a diff's diff, which I've never been
> good at).

What about Git's diff -c/--cc ?  You'd have to reverse the parenthood 
logic though.


Nicolas
