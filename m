From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Implement git-quiltimport
Date: Tue, 16 May 2006 22:31:04 -0700
Message-ID: <7v1wut2p5z.fsf@assigned-by-dhcp.cox.net>
References: <m1k68l6hga.fsf@ebiederm.dsl.xmission.com>
	<Pine.LNX.4.64.0605161001190.3866@g5.osdl.org>
	<m1bqtx6el6.fsf@ebiederm.dsl.xmission.com>
	<7vbqtxaj5k.fsf@assigned-by-dhcp.cox.net>
	<m13bf95ixo.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 17 07:31:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FgEco-0006DD-FL
	for gcvg-git@gmane.org; Wed, 17 May 2006 07:31:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932130AbWEQFbH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 17 May 2006 01:31:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932141AbWEQFbH
	(ORCPT <rfc822;git-outgoing>); Wed, 17 May 2006 01:31:07 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:20692 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S932130AbWEQFbG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 May 2006 01:31:06 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060517053105.YJSO19317.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 17 May 2006 01:31:05 -0400
To: ebiederm@xmission.com (Eric W. Biederman)
In-Reply-To: <m13bf95ixo.fsf@ebiederm.dsl.xmission.com> (Eric W. Biederman's
	message of "Tue, 16 May 2006 23:17:23 -0600")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20164>

ebiederm@xmission.com (Eric W. Biederman) writes:

> A infrastructure question came to me when looking at this:
> several of the patches are from a branch with several authors.
> How do we specify a commit in git with several authors?
>
> There are cases when you have enough collaboration that even
> a single patch could have multiple authors, contributing equally.

The object format allows one author and one committer, but they
are only used for human consumption and log summarizing purposes
by the core.  We could extend it to support more than one but I
doubt it is worth it.

I would say it would be best to place the primary contact
person, incase somebody has a problem with that particular patch
done by such a group, on the author line.  Listing everybody
involved to give credits to them at the end of the log message
would also be a good idea, and that's where we usually record
attribution, sign-offs and acked-bys.
