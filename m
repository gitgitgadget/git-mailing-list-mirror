From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: allow only a strictly defined set of references under .git/
Date: Fri, 16 Dec 2005 21:44:27 +0100
Message-ID: <20051216204427.GA4164@steel.home>
References: <81b0412b0512160024q47afe0b9v1b7f217a6cecfe68@mail.gmail.com> <7v1x0cj4zz.fsf@assigned-by-dhcp.cox.net>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 16 21:45:46 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EnMRd-000678-E2
	for gcvg-git@gmane.org; Fri, 16 Dec 2005 21:44:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932401AbVLPUor (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Dec 2005 15:44:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932405AbVLPUor
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Dec 2005 15:44:47 -0500
Received: from devrace.com ([198.63.210.113]:12294 "EHLO devrace.com")
	by vger.kernel.org with ESMTP id S932401AbVLPUoq (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 Dec 2005 15:44:46 -0500
Received: from tigra.home (p54A0D5AC.dip.t-dialin.net [84.160.213.172])
	(authenticated bits=0)
	by devrace.com (8.12.11/8.12.11) with ESMTP id jBGKiTuc040311;
	Fri, 16 Dec 2005 14:44:30 -0600 (CST)
	(envelope-from fork0@users.sourceforge.net)
Received: from steel.home ([192.168.1.2])
	by tigra.home with esmtp (Exim 3.36 #1 (Debian))
	id 1EnMRI-0001an-00; Fri, 16 Dec 2005 21:44:28 +0100
Received: from raa by steel.home with local (Exim 4.42 #1 (Debian))
	id 1EnMRH-000375-Tk; Fri, 16 Dec 2005 21:44:27 +0100
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7v1x0cj4zz.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.6i
X-Spam-Status: No, score=1.9 required=4.5 tests=AWL,RCVD_IN_NJABL_DUL,
	RCVD_IN_SORBS_DUL autolearn=no version=3.0.2
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on devrace.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13748>

Junio C Hamano, Fri, Dec 16, 2005 19:01:20 +0100:
> > Maybe we should only allow only a strictly defined set of refnames
> > under $GIT_DIR? The directory is used pretty much for anything else
> > (temporary message files, config, description).
> 
> I am glad somebody is paying attention.
> 

I actually run into it...

> Probably post 1.0 --- I have not assessed the extent of
> confusion yet.

It has good chances to continue to grow, as git gets more exposure.
