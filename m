From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: the meaning of keephardlinks
Date: Tue, 13 Jan 2009 01:42:32 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901130141190.3586@pacific.mpi-cbg.de>
References: <93c3eada0901121617m43af82a7te946b1607fbf3f77@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Geoff Russell <geoffrey.russell@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 13 01:43:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMXN6-0006SV-Fr
	for gcvg-git-2@gmane.org; Tue, 13 Jan 2009 01:43:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752799AbZAMAlp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jan 2009 19:41:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752626AbZAMAlp
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Jan 2009 19:41:45 -0500
Received: from mail.gmx.net ([213.165.64.20]:37873 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752246AbZAMAlo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jan 2009 19:41:44 -0500
Received: (qmail invoked by alias); 13 Jan 2009 00:41:43 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp020) with SMTP; 13 Jan 2009 01:41:43 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/eDJMhEv3eREjeGw9mKh1ABnQGJQEgF7VMxm0HF1
	nvX5t3j1Zi3mEU
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <93c3eada0901121617m43af82a7te946b1607fbf3f77@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105426>

Hi,

On Tue, 13 Jan 2009, Geoff Russell wrote:

> I'm curious about what keephardlinks means.
> 
> If I do: "ln X Y ; git add Y ; git commit" in my origin and then
> "git pull" in my cloned repository,
> should I get a hard linked file in the clone
> when core.keephardlinks is set to true?

Nope.

It means that if you have a hard link locally, it will stay a hard link 
(and if it is modified, the other linked files will obviously change, 
too).

Note that this feature is not even in 'next'.

Ciao,
Dscho
