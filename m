From: Ferry Huberts <ferry.huberts@pelagic.nl>
Subject: Re: Move JGit off JSch?
Date: Thu, 25 Jun 2009 22:52:25 +0200
Message-ID: <4A43E389.8060807@pelagic.nl>
References: <20090625181428.GM11191@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Robin Rosenberg <robin.rosenberg@dewire.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Jun 25 22:53:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MJvwX-0005Si-Fa
	for gcvg-git-2@gmane.org; Thu, 25 Jun 2009 22:53:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753180AbZFYUw1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Jun 2009 16:52:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752978AbZFYUw1
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Jun 2009 16:52:27 -0400
Received: from hupie.xs4all.nl ([82.95.241.251]:53578 "EHLO
	Lighthouse.internal.Hupie.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752830AbZFYUw0 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 Jun 2009 16:52:26 -0400
Received: from [192.168.0.51] (unknown [192.168.0.51])
	by Lighthouse.internal.Hupie.com (Postfix) with ESMTP id 652E358BDA0;
	Thu, 25 Jun 2009 22:52:25 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
In-Reply-To: <20090625181428.GM11191@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122243>

Shawn O. Pearce wrote:
> I'm fed up with JSch.

Good to know!

Last year I moved our application away from j2ssh to jsch because j2ssh
was pratically dead and rather oddly implemented within our application.
I chose jsch because Eclipse was using it and development was actually
being done on it. I wasn't aware of the issues with it though and also
was not aware of MINA.
I'll start looking into MINA soon because we're having some rather odd
issue in our application that seem to point to problems with jsch under
heavy load/many parallel connections. Your story lit up a light in my
head to that effect :-)

Are the Eclipse folks aware of these issues? they seem rather serious.
Wouldn't it be more effective to try to improve jsch through the eclipse
foundation/community, from multiple sides? (excuse me for asking the
obvious)

My background is in massive parallel systems so I know about the pain of
implementing this kind of thing correctly (and also the reward of seeing
it working...)
