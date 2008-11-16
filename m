From: Ian Hilt <ian.hilt@gmx.com>
Subject: Re: git rev-list ordering
Date: Sat, 15 Nov 2008 20:44:18 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0811152040570.2935@sys-0.hiltweb.site>
References: <alpine.LFD.2.00.0811151922310.2935@sys-0.hiltweb.site> <bd6139dc0811151727k605a3575hf409fed32a3a4baf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: sverre@rabbelier.nl
X-From: git-owner@vger.kernel.org Sun Nov 16 02:56:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L1WsI-0002ov-Gl
	for gcvg-git-2@gmane.org; Sun, 16 Nov 2008 02:56:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752228AbYKPBoY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Nov 2008 20:44:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752230AbYKPBoY
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Nov 2008 20:44:24 -0500
Received: from mail.gmx.com ([74.208.5.67]:53977 "HELO mail.gmx.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752224AbYKPBoY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Nov 2008 20:44:24 -0500
Received: (qmail invoked by alias); 16 Nov 2008 01:44:22 -0000
Received: from cpe-75-185-223-130.woh.res.rr.com [75.185.223.130]
  by mail.gmx.com (mp-us002) with SMTP; 15 Nov 2008 20:44:22 -0500
X-Authenticated: #47758715
X-Provags-ID: V01U2FsdGVkX1+wpiUizb+wgp80CAVg/OkoGB/IEyr9Hck+sis2zX
	vgfgrAU6huOKMY
In-Reply-To: <bd6139dc0811151727k605a3575hf409fed32a3a4baf@mail.gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.75
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101110>

On Sat, 15 Nov 2008, Sverre Rabbelier wrote:
> The --reverse is applied after the --max-count, so you are seeing the
> reverse of one commit ;). For comparison, have a look at:
> 
> $ git rev-list --reverse --max-count=2

Ah, I see.  So if you didn't want the sorting to take a long time for
many commits, you would limit the output to n commits, then sort the
output.  Is this the logic behind this design?
