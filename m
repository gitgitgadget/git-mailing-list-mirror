From: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
Subject: Re: BEWARE: mkdelta is broken
Date: Fri, 27 May 2005 19:42:20 +0200
Message-ID: <20050527174220.GB7068@cip.informatik.uni-erlangen.de>
References: <Pine.LNX.4.62.0505262125050.16151@localhost.localdomain> <20050527094133.GR24351@cip.informatik.uni-erlangen.de> <Pine.LNX.4.62.0505271335170.16151@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 27 19:45:30 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dbirk-00060J-Jm
	for gcvg-git@gmane.org; Fri, 27 May 2005 19:43:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262018AbVE0RoC (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 May 2005 13:44:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261927AbVE0RnR
	(ORCPT <rfc822;git-outgoing>); Fri, 27 May 2005 13:43:17 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:50850 "EHLO
	faui03.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S261969AbVE0Rmb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 May 2005 13:42:31 -0400
Received: from faui03.informatik.uni-erlangen.de (faui03.informatik.uni-erlangen.de [131.188.30.103])
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) with ESMTP id j4RHgKS8021441
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 27 May 2005 17:42:20 GMT
Received: (from sithglan@localhost)
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) id j4RHgKuC021440;
	Fri, 27 May 2005 19:42:20 +0200 (CEST)
To: Nicolas Pitre <nico@cam.org>
Mail-Followup-To: Nicolas Pitre <nico@cam.org>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0505271335170.16151@localhost.localdomain>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hello,

> Yes, that's because you end up with delta loops.  When trying to expand 
> the delta, it keeps looping and allocating memory until killed.

> I fixed that already and am preparing a patch at the moment.

perfekt. I am happy to give it a test.

	Thomas
