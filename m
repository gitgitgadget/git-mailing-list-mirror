From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH/RFC 0/3] Per-repository end-of-line normalization
Date: Fri, 07 May 2010 15:31:58 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1005071529050.14468@xanadu.home>
References: <x2s40aa078e1005061340vaf404ab3g30b2b98ca408205@mail.gmail.com>
 <cover.1273183206.git.eyvind.bernhardsen@gmail.com>
 <7v4oijhdsi.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.1005071007320.901@i5.linux-foundation.org>
 <alpine.LFD.2.00.1005071147460.901@i5.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>,
	git@vger.kernel.org, hasan.aljudy@gmail.com,
	kusmabite@googlemail.com, prohaska@zib.de
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri May 07 21:32:11 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OATHM-0007Vr-9V
	for gcvg-git-2@lo.gmane.org; Fri, 07 May 2010 21:32:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758091Ab0EGTcB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 May 2010 15:32:01 -0400
Received: from relais.videotron.ca ([24.201.245.36]:16789 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757713Ab0EGTcA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 May 2010 15:32:00 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MR-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0L22001LVE9ANIA1@VL-MR-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 07 May 2010 15:31:58 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <alpine.LFD.2.00.1005071147460.901@i5.linux-foundation.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146561>

On Fri, 7 May 2010, Linus Torvalds wrote:

> Btw, another option might be to start searching ".gitconfig", but only 
> allow a certain "safe subset" of config options in that. Things that can 
> really be about the project itself, and not per-user or per-repository.
> 
> And parse it before ~/.gitconfig and .git/config, so that people can 
> always override it.
> 
> I dunno. Looking at the config options, there really aren't a lot of them 
> that make sense on a project scale. There's a few, though. Things like
> 
> 	core.autocrlf
> 	i18n.commitEnconfig
> 
> and possibly others..

Given that only a subset of gitconfig could make sense to have 
distributed, I think the file should be named .gitparams to make the 
distinction clear.


Nicolas
