From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: linking libgit.a in C++ projects
Date: Thu, 31 Jul 2008 20:37:32 +0200
Message-ID: <20080731183732.GA7598@steel.home>
References: <ac9f0f090807310253v1d97e2a1n4ddf34aa4fdc79f0@mail.gmail.com> <4891B872.3040707@panasas.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: cte <cestreich@gmail.com>, git@vger.kernel.org
To: Boaz Harrosh <bharrosh@panasas.com>
X-From: git-owner@vger.kernel.org Thu Jul 31 20:38:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOd2r-0003go-B2
	for gcvg-git-2@gmane.org; Thu, 31 Jul 2008 20:38:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753291AbYGaShg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jul 2008 14:37:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753211AbYGaShg
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Jul 2008 14:37:36 -0400
Received: from mo-p05-ob.rzone.de ([81.169.146.181]:35156 "EHLO
	mo-p05-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753201AbYGaShf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jul 2008 14:37:35 -0400
X-RZG-CLASS-ID: mo05
X-RZG-AUTH: :YSxENQjhO8RswxTRIGdg2r44h+w6yw==
Received: from tigra.home (Fa9e8.f.strato-dslnet.de [195.4.169.232])
	by post.webmailer.de (fruni mo3) (RZmta 16.47)
	with ESMTP id g02554k6VHSZs3 ; Thu, 31 Jul 2008 20:37:32 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 97D9F277BD;
	Thu, 31 Jul 2008 20:37:32 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 6546156D2A; Thu, 31 Jul 2008 20:37:32 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4891B872.3040707@panasas.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90960>

Boaz Harrosh, Thu, Jul 31, 2008 15:04:50 +0200:
> Produce a C file and header that defines some stable API to your
> GUI application, that does not expose any git internal headers.
> Then compile that, say git_api.c, with C compiler in Makefile
> and extern "C" link that file to your C++ application. This will
> completely insulate you from any git code.

no, it wont. He still have to resolve name conflicts at the link time.
