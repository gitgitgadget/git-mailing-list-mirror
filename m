From: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
Subject: Re: BEWARE: mkdelta is broken
Date: Fri, 27 May 2005 11:41:33 +0200
Message-ID: <20050527094133.GR24351@cip.informatik.uni-erlangen.de>
References: <Pine.LNX.4.62.0505262125050.16151@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri May 27 11:45:39 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DbbOG-0005Wd-0g
	for gcvg-git@gmane.org; Fri, 27 May 2005 11:44:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262426AbVE0Jpn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 May 2005 05:45:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262421AbVE0Jm2
	(ORCPT <rfc822;git-outgoing>); Fri, 27 May 2005 05:42:28 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:53947 "EHLO
	faui03.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S262418AbVE0Jle (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 May 2005 05:41:34 -0400
Received: from faui03.informatik.uni-erlangen.de (faui03.informatik.uni-erlangen.de [131.188.30.103])
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) with ESMTP id j4R9fXS8015051
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Fri, 27 May 2005 09:41:33 GMT
Received: (from sithglan@localhost)
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) id j4R9fX2e015050
	for git@vger.kernel.org; Fri, 27 May 2005 11:41:33 +0200 (CEST)
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0505262125050.16151@localhost.localdomain>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hello,

> The current delta loop detection logic is broken.  So if you have 
> multiple merged branches or you have a changeset that revert things then 
> you might end up with a delta loop and fsck-cache will effectively 
> complain about unresolved deltas and assorted dangling/broken object 
> links.

I wanted to give you heads-up, but I forgot it. But I think noone is
using it at the moment otherwise they had complained in the first place.

However ... I took linux-2.6 repository. Ran git-deltafy-script &&
git-deltafy-script -d 0 and it segfaulted on me. Same for my mutt-cvs
import.

	Thomas
