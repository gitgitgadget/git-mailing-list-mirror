From: Casey Dahlin <cdahlin@redhat.com>
Subject: Re: [PATCH] logging branch deletion to help recovering from mistakes
Date: Tue, 7 Dec 2010 11:23:58 -0500
Message-ID: <20101207162358.GT355@fearengine.rdu.redhat.com>
References: <7vlj42siu5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 07 17:24:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQ0LC-0006Zy-0f
	for gcvg-git-2@lo.gmane.org; Tue, 07 Dec 2010 17:24:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755054Ab0LGQYZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Dec 2010 11:24:25 -0500
Received: from mx1.redhat.com ([209.132.183.28]:31062 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754873Ab0LGQYY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Dec 2010 11:24:24 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id oB7GO0au008189
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Tue, 7 Dec 2010 11:24:00 -0500
Received: from fearengine.rdu.redhat.com (dhcp243-150.rdu.redhat.com [10.11.243.150])
	by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id oB7GNwrb010747
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Tue, 7 Dec 2010 11:24:00 -0500
Content-Disposition: inline
In-Reply-To: <7vlj42siu5.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.24
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163084>

On Mon, Dec 06, 2010 at 01:16:18PM -0800, Junio C Hamano wrote:
> This adds core.logrefdeletion configuration variable (enabled by default
> in a repository with a work tree, just like core.logallrefupdates), and
> logs deletion of refs via "update-ref -d", "branch -d", etc.
> 
> "git branch" learns a new "--list-deleted" option to help users view the
> names of branches and the commit objects that were at the tip of them when
> the branches were deleted.
> 

Could commits made onto a detached head also show up here? Or is that
better thwarted with another mechanism?

--CJD
