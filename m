From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/3] remove pathspec_match, use match_pathspec instead
Date: Wed, 14 Jan 2009 16:40:42 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901141637170.3586@pacific.mpi-cbg.de>
References: <1231944876-29930-1-git-send-email-drizzd@aon.at> <1231944876-29930-2-git-send-email-drizzd@aon.at> <1231944876-29930-3-git-send-email-drizzd@aon.at>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	johannes@familieschneider.info
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Wed Jan 14 16:46:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LN7s2-0008KE-Lg
	for gcvg-git-2@gmane.org; Wed, 14 Jan 2009 16:41:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757205AbZANPjx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2009 10:39:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756691AbZANPjx
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Jan 2009 10:39:53 -0500
Received: from mail.gmx.net ([213.165.64.20]:55934 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755528AbZANPjw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jan 2009 10:39:52 -0500
Received: (qmail invoked by alias); 14 Jan 2009 15:39:50 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp062) with SMTP; 14 Jan 2009 16:39:50 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19UpEIDXbRU7NikR9Qi0kPIPAxPmf8zMY+XiSbkHa
	oKKBYRay+vSpmb
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <1231944876-29930-3-git-send-email-drizzd@aon.at>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6899999999999999
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105642>

Hi,

On Wed, 14 Jan 2009, Clemens Buchacher wrote:

> Both versions have the same functionality. This removes any
> redundancy.
> 
> This also adds makes two extensions to match_pathspec:

s/makes//

>  5 files changed, 17 insertions(+), 51 deletions(-)

Nice.  Does it still pass the test suite?  (From my reading, it should, 
but I do not quite have the time to run it right now.)

Ciao,
Dscho
